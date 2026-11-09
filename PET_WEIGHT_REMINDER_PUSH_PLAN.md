# Pet weight reminder: missing emails + push notifications

Nov 9, 2026 · @Rita · follows PET_WEIGHT_REMINDER_FIX_PLAN.md (done in ee5903d)

**Status:** done on main, Nov 9, 2026.

- A–D in `b85ca65`, with D = owners only. `NotificationService` and the `services.notifications` translations were removed.
- E (each person chooses the channel; email with why when the app or LINE fails) in `c844fec`. E replaces C's app → LINE → email order.
- F (Today shows the chosen channel; one weight job instead of two), Nov 9, 2026.
- `lib/tasks/notifications.rake` removed, Nov 9, 2026: nothing scheduled used it.

## Root causes

### 1. The 9am scan only runs on the first day after a deploy (main cause)

`config/recurring.yml`:

```yaml
pet_weight_reminder:
  command: "Rails.application.load_tasks; Rake::Task['notifications:weigh_pets'].invoke"
  schedule: every day at 9am
```

A Solid Queue `command` is evaluated inside the long-running `bin/jobs` worker. `Rake::Task#invoke`
runs a task **once per process**: it sets `@already_invoked = true` (rake 13.4.2, `lib/rake/task.rb:205-216`), and
calling `load_tasks` again returns the same Task object, so the flag stays set. From the second day on,
the recurring job "succeeds" but does nothing. Repro, same calls in one process:

```
day 1:
  ran weigh_pets
day 2:
day 3:
```

So `PetWeightReminderJob` is only queued on the first 9am after each deploy or worker restart.
(Each run also reloads every rake file into the worker.)

### 2. A reminder goes out only on the exact day, with no catch-up

`days_since >= 14 && days_since % 14 == 0`: a pet is due on day 14, 28, 42, and so on, and **only on that
day**. Because of cause 1, the scan rarely runs. An email goes out only when a deploy day happens to land
on a pet's exact day 14 or 28 and the owner is still active. That almost never happens.

### 3. Days are counted in UTC

`config.time_zone` is not set, so `Date.current` is the UTC date and 9am is 9am UTC (5pm in Taiwan, 6pm in Japan).
Tracker dates are local dates, so `days_since` can be off by one. Not a blocker, but it moves the exact day.

### Other gaps (not why email is missing, but worth fixing)

- **LINE users never get email**, by design. If the person who reported this signs in with LINE, they get a LINE message instead.
  The `push_message` response is ignored, so a failed LINE push (bot blocked, not a friend) is silent and doesn't fall back to email.
- **Only owners** are checked (`owned_pets`, and the rake task picks household owners). Caregivers never get one.
- **The email is English only** (no locale), doesn't name the pet, and has no link.

### How to confirm in production (read-only console)

```ruby
# Should be one per day:
SolidQueue::RecurringExecution.where(task_key: "pet_weight_reminder").order(run_at: :desc).limit(10).pluck(:run_at)
# Only on deploy days:
SolidQueue::Job.where(class_name: "PetWeightReminderJob").group("DATE(created_at)").count
```

Also: every reminder email CCs `ajicaretracker@gmail.com`. Few or no CCs in that inbox points to cause 1.
(Finished jobs are cleared every hour, so the job table may be empty. Use the CC inbox if it is.)

## Fix

### A. Schedule a job class, not a rake command

```yaml
pet_weight_reminders:
  class: PetWeightRemindersJob
  schedule: every hour at minute 10
```

- New `PetWeightRemindersJob#perform`: goes over owners of households that have pets (the query the rake task uses now)
  and calls `PetWeightReminderJob.perform_now(user)`, or `perform_later` to spread the work, the way care reminders are scanned.
- Keep `notifications:weigh_pets` for manual runs, as a thin `PetWeightRemindersJob.perform_now`.
  (Removed Nov 9, 2026 with `lib/tasks/notifications.rake`; to send reminders by hand, run `bin/rails runner 'PetWeightRemindersJob.perform_now'`.)
- Runs hourly so each person gets it in their own morning, like `CareReminderJob` (next point).

### B. "Due and not yet sent" instead of "exactly day 14"

In `PetWeightReminderJob`, for each owned pet:

- `local = Time.current.in_time_zone(user.timezone || household.time_zone)`; send only when `HouseholdReminders::SEND_HOURS.cover?(local.hour)` (9:00–20:59).
- `days_since = (local.to_date - last_weighed_date).to_i`; `cycle = days_since / 14`; due when `cycle >= 1`.
- Key: `"weight:#{pet.id}:#{last_weighed_date.iso8601}:#{cycle}"`. Skip if a `CareReminder` with that key exists for the user.
- After sending, create a `CareReminder` row (`household: pet.household`, `due_on: last_weighed_date + 14 * cycle`, `channel:`, `sent_at:`),
  with `care_routine` and `medication` nil. The existing unique `key` per user means it is sent at most once per cycle.
- **No migration**: `care_reminders` already has every column needed, and both foreign keys are optional.

Result: a missed hour or day is caught up on the next run. Days 14, 28, 42… each send once. Weighing again changes
`last_weighed_date`, which starts a new key and restarts the count. Keep `inactive?` (15 days) as it is.

### C. Push notifications, using the household reminder channels (order replaced by E)

New `PetWeightReminderNotifier(user, pets)`, shaped like `CareReminderNotifier`. It sends **one message per user per run**, listing every pet that is due:

1. **Android app**: `FcmClient` to each `device_token` when `FcmClient.configured?`. Drops tokens that come back `:gone`.
2. **LINE**: if the user has a LINE connected service, the push response must be `Net::HTTPSuccess`.
3. **Email**: otherwise, or when 1 and 2 fail.

- Move the shared channel code (`pushed_to_android?`, `pushed_by_line?`, locale from time zone) out of `CareReminderNotifier`
  into a `ReminderChannels` module that both notifiers include, so the two can't drift apart.
- Text: new i18n keys (en / zh-TW / ja), for example `weight_reminders.subject` ("Time to weigh %{pets}") and a body naming each pet
  with "last weighed %{date}" (or "never weighed"), linking to `pet_trackers_url(pet)`.
- `UserMailer#send_pet_weight_reminder`: send in the user's locale, take the pets and the link, and use i18n in the template.
- `NotificationService#send_pet_weight_reminder` then forwards to the notifier, or goes away if nothing else calls it.
  Its private `send_line_notification` path ends up unused.

### D. Who gets it (decide)

| Option | Behavior |
| --- | --- |
| **Owners only, always (recommended, as now)** | No new settings; the household reminder switch doesn't affect it |
| Follow the reminder switches | Owner if `owner_reminders_enabled`, plus caregivers with `reminders_enabled` (`household.reminder_recipients`). Fewer people get it, because the switches are off by default |

### E. Follow-up: app users got no email; let each person choose

**Root cause, found after C shipped:** push worked, but people with the Android app got no email. C used one channel:
`return "android" if pushed_to_android?` stopped before the email was queued. The email wasn't lost; it was never sent.
Household reminders worked the same way.

**Decisions (Nov 9, 2026):**

| Question | Choice |
| --- | --- |
| What the setting covers | All reminders, weight and household, one setting |
| Choices | App notification / LINE (only for people signed in with LINE) / Email. One channel only |
| Before someone chooses | The app if a phone is signed in, else LINE, else email (`User#reminder_channel_choice`) |
| App or LINE fails | Email instead, starting with a note that says why, plus a link to the setting; the profile page shows the problem |

**What was built:**

- Migration `20261109120000`: `users.reminder_channel`, `users.reminder_problem`, `users.reminder_problem_at`, all empty to start.
- `ReminderChannels#deliver_by_choice` sends by the choice and returns the channel used. On failure it passes the problem to the caller,
  which sends the email. The problem is saved on the user and cleared when a send by their choice works.
  Problems: `android_no_phone`, `android_failed`, `line_not_connected`, `line_failed`.
- `ReminderChannelsController#update` (`PATCH /reminder_channel`): refuses LINE without LINE, and anything unknown;
  a new choice clears the old problem.
- Profile section `users/_reminder_channel` (`#reminder-channel`): radio buttons that save on change, and the problem in red.
- `shared/_reminder_problem` (HTML and text) at the top of both reminder emails. Translations under `users.reminder_channel`,
  `reminder_channels.update` and `reminder_delivery` in en / zh-TW / ja.

**Behavior change:** a failed app send now goes to email (with the note) instead of falling through to LINE.

### F. Follow-up: Today's reminder text, and one weight job

**Today showed the wrong channel.** `TodayController` still worked out "Reminders by …" the old way (app, else LINE, else email),
ignoring the choice on the profile page. It now uses `User#reminder_channel_choice`, and the line has a **How reminders come** link
to `users#reminder-channel`.

`reminder_channel_choice`'s default now picks the app only when `FcmClient.configured?`. Without that check, if push isn't set up on
the server, everyone with a phone would get "couldn't send to the app" emails, and Today would say "Android app" while email is used.

**Two weight jobs → one.** `PetWeightReminderJob` was never queued after A; `PetWeightRemindersJob` called it with `perform_now`.
Now the pattern is the same as household reminders (`CareReminderJob` + `HouseholdReminders`):

| Before | After |
| --- | --- |
| `app/jobs/pet_weight_reminders_job.rb` (scheduled) | Same file, calls `PetWeightReminders.new(user).deliver` |
| `app/jobs/pet_weight_reminder_job.rb` (per owner) | `app/models/pet_weight_reminders.rb`, a plain class; `deliver` returns the channel or nil |
| `test/jobs/pet_weight_reminder_job_test.rb` | `test/models/pet_weight_reminders_test.rb`, same cases |

Nothing changes for users. `recurring.yml` is unchanged.

## Tests

`test/jobs/pet_weight_reminders_job_test.rb` (new) and `test/jobs/pet_weight_reminder_job_test.rb` (rewritten):

| Test | Expected |
| --- | --- |
| Scheduler run twice in one process | Both runs queue reminders (regression for cause 1) |
| `config/recurring.yml` | Has `class: PetWeightRemindersJob` and no `Rake::Task` |
| Weighed 15 days ago, nothing sent yet | 1 reminder (catch-up; fails on today's code) |
| Same, second run the same day | 0 (CareReminder key) |
| Day 28 after one sent on day 14 | 1 |
| Weighed 13 days ago | 0 |
| Weighed again after a reminder | New count; nothing until 14 days after the new weighing |
| 08:00 / 21:00 in user's zone | 0; at 09:00 → 1 |
| Taipei user, UTC date different from local date | Uses the local date |
| Inactive 16 days | 0 |
| FCM configured, token sends | Channel `android`, no email |
| Two pets due | One message naming both |

After E (`pet_weight_reminder_job_test.rb`, `household_reminders_test.rb`, new `reminder_channels_controller_test.rb`, `user_mailer_test.rb`):

| Test | Expected |
| --- | --- |
| App chosen (default), push fails, LINE user | Email with the `android_failed` note, not LINE; problem saved; cleared after the app works |
| Phone `:gone` | Token deleted, emailed; next time the default is LINE |
| Chose the app, no phone | Email with the `android_no_phone` note |
| Chose LINE: send fails / LINE disconnected | Email with the `line_failed` / `line_not_connected` note |
| Chose email, phone signed in | Email, no push, no note |
| Profile | Right choices, LINE hidden without LINE, problem shown |
| Saving the choice | Saved and old problem cleared; LINE without LINE and unknown values refused; needs sign-in |

Run `bin/rails test test/jobs test/models/household_reminders_test.rb`, then the full suite.

## Rollout notes

- On the first runs after deploy, every active owner with a pet unweighed for 14 or more days gets **one** reminder for the current cycle.
  This is expected; the 15-day inactive rule limits it.
- After deploy, check the next day that `CareReminder.where("key LIKE 'weight:%'")` keeps growing and that the CC inbox gets mail.
- A–D: no schema change and no new credentials; FCM already uses `FIREBASE_SERVICE_ACCOUNT_JSON` on the worker.
- E adds three empty `users` columns (the deploy migrates them). App users still get push only until they choose Email on their profile page.
- Not yet checked: how the profile section looks in a browser and in the Android app.
- Mail failures: none were checked in production (`SolidQueue::FailedExecution` for `ActionMailer::MailDeliveryJob`).
  If emails are queued but still not arriving, look there, and at the Gmail refresh token.
