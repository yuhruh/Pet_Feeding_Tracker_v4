# Pet weight reminder fix plan

Sep 27, 2026 · @Rita

## Problem

`PetWeightReminderJob` (`app/jobs/pet_weight_reminder_job.rb`) almost never emails owners 14 days after their pet was last weighed. The daily 9am cron (`config/recurring.yml` → `notifications:weigh_pets`) runs correctly; the job's send condition is what blocks it.

The current condition, line 11:

```ruby
days_since >= 14 && days_since % 7 == 0 && inactive_days <= 3
```

A missing `queued` counter is not the cause: each run is a fresh, stateless check, so a local counter would reset to 0 every day.

## Root causes

1. **`inactive_days <= 3` is measured from `current_sign_in_at`.** That field changes only on an explicit sign-in (`sessions_controller.rb:17`, OmniAuth). Returning on an existing session updates `Session#last_active_at`, not `current_sign_in_at`. So by day 14 after weighing, almost every user is more than 3 days past their last sign-in and is skipped.
2. **`days_since % 7 == 0` is weekly.** It fires on days 14, 21, 28, and so on, not every 14 days.

The current tests miss cause 1 because they force `current_sign_in_at: 1.day.ago`.

## Decisions

| Decision | Choice | Why |
| --- | --- | --- |
| Reminder schedule | `days_since >= 14 && days_since % 14 == 0` | Sends on days 14, 28, 42, and so on after the last weighing; weighing resets the count |
| Activity signal | Latest of `user.sessions.maximum(:last_active_at)`, `user.current_sign_in_at`, `user.created_at` | Sessions track real visits; `current_sign_in_at` covers users who sign out (which deletes the session); `created_at` covers new users |
| Removing nils | `.compact.max` | `maximum` is nil with no sessions and `current_sign_in_at` can be nil; `created_at` is never nil |
| Inactive threshold | `INACTIVE_AFTER = 15.days` | One reminder (day 14) for a user who leaves; the cutoff falls a full day before day 0, so the time of weighing never matters |
| Schema change | None | `last_active_at` already exists on `sessions` (`db/schema.rb:134`) |

The threshold must be above 14 days (at 14, the day-14 reminder depends on what time the pet was weighed). It must also be at most 30 days, because `purge_expired_sessions` deletes sessions idle for 30 days (`Session::IDLE_TIMEOUT`). A longer window would need a new `users.last_active_at` column.

## Code change

Replace `app/jobs/pet_weight_reminder_job.rb` with:

```ruby
class PetWeightReminderJob < ApplicationJob
  queue_as :default

  INACTIVE_AFTER = 15.days

  def perform(user)
    return if inactive?(user)

    needs_reminder = user.pets.any? do |pet|
      last_tracker = pet.trackers.where.not(weight: nil).order(date: :desc).first
      last_weighed_date = last_tracker&.date || pet.created_at.to_date

      days_since = (Date.current - last_weighed_date).to_i
      days_since >= 14 && days_since % 14 == 0
    end

    NotificationService.new(user).send_pet_weight_reminder if needs_reminder
  end

  private

  def inactive?(user)
    last_active = [
      user.sessions.maximum(:last_active_at),
      user.current_sign_in_at,
      user.created_at
    ].compact.max

    last_active < INACTIVE_AFTER.ago
  end
end
```

No changes to `recurring.yml`, the rake task, `NotificationService` or the database schema.

## Who gets reminded when

A user who weighs on day 0 and then leaves gets exactly one reminder, on day 14. Each later visit without weighing earns roughly one more.

| Scenario | Day 14 | Day 28 | Day 42+ |
| --- | --- | --- | --- |
| Weighs on day 0, never returns | Sent | Skipped (inactive) | Skipped |
| Weighs on day 0, visits on day 20 without weighing | Sent | Sent (last active 8 days ago) | Skipped from day 42 (22 days) |
| Signs up and adds a pet on day 0, never returns | Sent (counted from `pet.created_at`) | Skipped | Skipped |
| Weighs again on day 10 | Count restarts from day 10 | — | — |
| Signed up, never added a pet | Never checked: the rake task only queues `User.joins(:pets)` | — | — |

Example for a user whose only visit was 2026-07-06, checked on 2026-09-27. In production their session was purged on 2026-08-06, so `user.sessions` is empty and `maximum` is nil. `last_active` is 2026-07-06, which is before the 2026-09-12 cutoff, so they are inactive.

## Test plan

Rewrite `test/jobs/pet_weight_reminder_job_test.rb`. Each test sets up one pet with a weighed tracker and asserts `assert_enqueued_emails` for `PetWeightReminderJob.perform_now(user)`.

| Test | Setup | Expected emails |
| --- | --- | --- |
| Active via session | Weighed 14 days ago; session `last_active_at` 1 day ago; `current_sign_in_at` 20 days ago | 1 (fails on today's code) |
| Signed out, recent sign-in | Weighed 14 days ago; no sessions; `current_sign_in_at` 14 days ago | 1 |
| New user, no sign-in | Weighed 14 days ago; no sessions; `current_sign_in_at` nil; `created_at` 14 days ago | 1 |
| Every 14 days | Active user; weighed 28 days ago | 1 |
| Not on in-between days | Active user; weighed 21 days ago | 0 (catches the old `% 7`) |
| Before day 14 | Active user; weighed 13 days ago | 0 |
| Inactive | Weighed 28 days ago; no sessions; sign-in and `created_at` 20 days ago | 0 |
| Threshold edge | Weighed 14 days ago; last active 16 days ago | 0 |

Run with `bin/rails test test/jobs/pet_weight_reminder_job_test.rb`, then the full suite.

## Caveats

- **Exact-day matching:** a reminder goes out only on the day `days_since` is a multiple of 14. If the 9am run fails that day, that reminder is lost.
- **Production only:** both the reminder and `purge_expired_sessions` are scheduled under `production:` only. In development, old sessions stay in the table, but `inactive?` gives the same result.
- **Threshold range:** `INACTIVE_AFTER` must stay between 15 and 30 days. 29–30 days would give two reminders (days 14 and 28).
