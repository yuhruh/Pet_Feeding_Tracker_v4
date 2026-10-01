# Households and Caregivers — Implementation Plan (v6)

**Goal:** Let several people look after the same cats. Each **owner** has a **household**: their cats, food bags, litter boxes and water spots, and the people they let help. A **caregiver** records care with **one tap** (fed, litter, water, meds given) and everyone in the household sees it right away. A **viewer** sees the charts and today's timeline, read-only, through a **personal link** with no account needed. A caregiver **needs an account**, joining through the owner's invitation. Caregivers and viewers can belong to **several owners' households**. **Reminders** say when a job "might be time" (clean the fountain, change the filter, give meds), by LINE or email first and later as Android app notifications.

## Status

| Checkpoint | Status |
|---|---|
| 0 — Decisions | ✅ Done (2026-09-29). No open questions |
| A — Households and memberships (no visible change) | ✅ Done (2026-09-30). Committed on `feature/households` and pushed. See [Checkpoint A result](#checkpoint-a-result-2026-09-30) |
| B — Access by household and role | ✅ Done (2026-09-30). Committed on `feature/households` and pushed. See [Checkpoint B result](#checkpoint-b-result-2026-09-30) |
| C — Caregiver invitations, viewer links, members, transfer ownership | ✅ Done (2026-09-30). Committed on `feature/households` in five parts and pushed. See [Checkpoint C result](#checkpoint-c-result-2026-09-30) |
| D — Care events and the Today page (fed, litter, water, weight) | ✅ Done (2026-09-30). Committed on `feature/households` in five parts and pushed. See [Checkpoint D result](#checkpoint-d-result-2026-09-30) |
| E — Medications | ✅ Done (2026-10-01). Committed on `feature/households` in four parts and pushed. See [Checkpoint E result](#checkpoint-e-result-2026-10-01) |
| F — Litter observations | ✅ Done (2026-10-01). Committed on `feature/households` in three parts and pushed. See [Checkpoint F result](#checkpoint-f-result-2026-10-01) |
| G — Live updates and care events on the charts | ✅ Done (2026-10-01). Committed on `feature/households` in three parts and pushed. See [Checkpoint G result](#checkpoint-g-result-2026-10-01) |
| H — Reminders by LINE and email | ✅ Done (2026-10-01). Committed on `feature/households` in four parts and pushed. See [Checkpoint H result](#checkpoint-h-result-2026-10-01) |
| H2 — Litter several times a day | ✅ Done (2026-10-02). Committed on `feature/households` and merged into `main`. See [Checkpoint H2 result](#checkpoint-h2-result-2026-10-02) |
| H3 — Delete a mistaken record | ✅ Done (2026-10-02). Committed on `feature/households` and merged into `main`. See [Checkpoint H3 result](#checkpoint-h3-result-2026-10-02) |
| I — Android app push notifications (Firebase) | Not started |
| J — Clean-up, docs, CI, merge | Not started |

**Commits:** each checkpoint is committed on `feature/households` once `bin/rails test` passes, then pushed. Merged into `main` only when you ask.

## Checkpoint H3 result (2026-10-02)

**What people see now:**
- **Delete** next to **Change** on each timeline entry the person may change, and at the bottom of the record's details page: the **owner** for any record in the household, a **caregiver** for their own records for 24 hours, up to 7 days back. Viewers never see it.
- **A confirmation first:** "Delete “Aji: fed” at 08:12? It's removed from Today, the charts and reminders." For a feeding added to trackers it adds "Aji's tracker stays; delete it on the trackers page if it's wrong too."
- **After deleting:** "Deleted. Aji: fed at 08:12". The record leaves the timeline, the status rows ("Not fed yet today"), dose statuses (a deleted "given" makes the dose due again), the "Care by day" bars, the weight line (a ⚖️ record), the CSV and reminder due dates. Everyone's open Today pages and viewer pages update at once; the charts change when they're next opened or reloaded.
- **A feeding added to trackers:** the tracker stays and shows on the timeline as "(tracker)".

**Follow-up (2026-10-02): the timeline shows the last 24 hours.** It stopped at midnight, so a tap at 23:50 couldn't be reached the next morning to change or delete it, though a caregiver may do both for 24 hours. The timeline (Today and the viewer page) now lists the **last 24 hours**, newest first, with last night's entries as "yesterday 23:50"; its title is "Last 24 hours". The status rows ("Fed 08:12 by Mom", "Not fed yet today", doses, "2× today") stay about today. The owner's trackers show there too when their feed time is within the 24 hours.

**Main files:** `CareEvent#deletable_by?`, `#delete_by!`, `CareEventsController#destroy`, `care_delete_confirm`, `care_events/_timeline`, `care_events/edit`, `HouseholdDay#trackers`; `db/migrate/20261002090000_add_deleted_by_to_care_events.rb` (checked on PostgreSQL: up, down, up).

**Decisions made while building:** as in the [plan](#checkpoint-h3-plan-delete-a-mistaken-record-2026-10-02), plus:
- **Found and fixed:** a tracker linked to an **undone** feeding was hidden from the Today timeline; only feedings still on record hide their tracker now.

**Checks:** **6 tests** and **1 browser test**: a caregiver deletes their own feeding (confirmation, notice, gone from the timeline and status, who deleted it kept); the owner deletes anyone's; a caregiver not another's or one older than 24 hours; viewers and outsiders refused; a deleted record leaves Care by day, the weight line, doses, due dates and the CSV; a linked tracker stays and shows; the details page's Delete; other pages hear about it; a record can't be deleted twice. The **browser test**: Mom cancels, then confirms, deleting an accidental "Fed"; it disappears from her Today page and, live, from the owner's.

## Checkpoint H2 result (2026-10-02)

**What people see now:**
- **Household page**, each job of each litter box and water spot: **[Off · 3 times a day · Twice a day · Daily · Twice a week · Weekly · Every 2 weeks · Twice a month · Monthly · Custom · At set times]**. **Custom** shows a number and **hours / days**; **At set times** shows time fields (the set times plus two empty ones, up to 6; save to add more). Each line shows only the fields its choice needs.
- **Today row**, e.g. for a box scooped twice today: "scooped 2× today · last 15:20 by Mom", then each job's reminder line:
  - **At set times:** "🚽 Scooped: 08:00 ✓ 07:55 by Mom · 20:00 due" (done green, due grey, "20:00 not done" red an hour after).
  - **Every … under a day** (or not whole days): "🚽 Scooped due at 20:00" / "due tomorrow at 03:00" / "overdue since 20:00" (red).
  - **Every … whole days:** as in H ("due today", "in 3 days", "2 days overdue").
- **Reminders:** set times at the set time, any hour, with one follow-up 2 hours later; "every …" under a day once the due time passes, between 9am and 9pm, with one follow-up one interval later; whole days as in H. The text names the set time: "🚽 Scooped · Upstairs box: the 20:00 time. Last: 10/2 by Mom."
- **"Record it again?"** for the same litter job only within **30 minutes** (was 2 hours).

**Main files:** `CareRoutine` (`mode`, `every_hours`, `times`, `hourly?`, `due_at`, `slots`, `apply`, `custom_amount`), `HouseholdReminders` (the three kinds), `CareReminder.routine_key` (a day or a due time), `CareReminderNotifier`, `care_events/_routine_due`, `_status`, `HouseholdDay#today_counts`, `households/show`, `routine_fields_controller.js`, `CareEvent::REPEAT_WINDOWS`; `db/migrate/20261002100000_add_set_times_to_care_routines.rb` (checked on PostgreSQL: up, down, up; an existing "every 4 days" became 96 hours and back).

**Decisions made while building:** as in the [plan](#checkpoint-h2-plan-litter-several-times-a-day-2026-10-01), with one change:
- **Which set time a scoop counts for:** a scoop up to **2 hours after** a set time counts for that time (done late); anything later counts for the **next** set time (done early). Between set times closer than 4 hours, the gap is split in half. So with 08:00 and 20:00: 07:00–10:00 → 08:00, 10:00–22:00 → 20:00, 22:00–08:00 → the next 08:00. The plan's "looks back to the previous set time" would have let a late 08:30 scoop cover 20:00 and skip that evening's reminder.
- **A set time is reminded about only within its window** (until 2 hours after it), so after a pause in sending, old set times aren't sent late.

**Checks:** **12 new tests** and the reminders **browser test** reworked. Schedules: whole days as before, due to the minute under a day (never done, from the last record, other jobs ignored), set times (late and early scoops, the night before counting for 08:00, close set times splitting the gap, status due and late), set times checked (none, invalid, more than 6, tidied), the household page's choices (presets in hours, custom hours or days, set times, daily, off, a bad change leaving the old one), a bowl losing its filter reminder. Sending: twice a day (due time, once, 9am to 9pm, the follow-up an interval later waiting for 9am, due again after 9pm waiting for 9am), an early scoop moving it, set times (at 07:00 before 9am, once, follow-up 2 hours later, a scoop before the set time covering it), a late scoop stopping the follow-up, nothing after a set time's window. Pages: saving each kind, set times and custom fields shown back, a bad custom amount explained, set-time statuses and "2× today" on Today, "not done" after an hour, a due time and overdue, the 30-minute question. The **browser test**: the owner sets "At set times 08:00, 20:00" on a box, "Twice a day" and a custom 10 days on a fountain (each showing only its own fields), sees them on Today and turns reminders on.

## Checkpoint H3 plan: delete a mistaken record (2026-10-02)

**The problem:** a tap by mistake ("🍽 Fed" when the cat wasn't fed) can only be undone for **10 seconds**, and only by the person who tapped. After that it can be changed (time, details) but **not removed**, so it stays on the timeline, the status ("Fed 08:12 by Mom"), the "Care by day" chart and the CSV, and it moves reminders' due dates as if the job was done.

**The fix: a Delete button**, next to **Change** on each timeline entry and at the bottom of the record's details page:

```
08:12  🍽 Aji: fed · Mom      Change  Delete
```

| Part | Build |
|---|---|
| 1. Who and which | The same people and records as **Change**: the **owner** any record in the household; a **caregiver** their own records for 24 hours. Viewers never. Records up to 7 days old (the timeline and details page's range) |
| 2. Asking first | "Delete “Aji: fed” at 08:12? It's removed from Today, the charts and reminders." (**Delete** / Cancel) |
| 3. What deleting does | The record is **kept but hidden**, like Undo: `undone_at` set, plus a new `deleted_by_id` (who deleted it). It disappears from the timeline, the status rows, doses (a deleted "given" makes that dose due or overdue again), the "Care by day" chart, the CSV and reminder due dates. Everyone's open Today pages and the viewer page's status and timeline update at once (G's live updates). **The charts** drop it too (a deleted tap from the "Care by day" bars; a deleted ⚖️ weight from the weight line of the amount and weight chart above it; "Care by day" itself has no weight line), since they count only records that weren't undone or deleted, but they aren't redrawn live: they change when the trackers page or viewer page is next opened or reloaded, or another cat or range is picked. The page says "Deleted. Aji: fed at 08:12" |
| 4. Feedings added to trackers | Deleting the care record **leaves the owner's tracker alone** and unlinks it, so the tracker then shows on the timeline as "(tracker)". The confirmation says so: "The tracker stays; delete it on Aji's trackers page if it's wrong too." (Today, a deleted record that was linked would still hide its tracker; this fixes that.) |
| 5. Checks | Tests: owner deletes anyone's record, caregiver their own within 24 hours but not another's or an older one, viewer and outsider refused; the record leaves the timeline, status, doses, the "Care by day" bars, the amount and weight chart's weight line (for a ⚖️ record), CSV and due dates; who deleted it is kept; a linked tracker reappears on the timeline; the live update reaches the other pages; a browser test deleting an accidental "Fed" from the timeline |

**Decisions for H3 (recommended; change any before building):**
- **Delete keeps the record hidden rather than erasing it**, so a mistake by the wrong person can be looked into, and the owner's CSV stays consistent. It's never shown again in the app.
- **No "restore"** for now: tapping the job again records it anew.
- **Undo stays** for the first 10 seconds after a tap (one tap, no question); Delete is for later.
- **Deleting a water record removes all its jobs** ("refilled, fountain cleaned"); to drop just one job, untick it in Change, as now.

## Checkpoint H2 plan: litter several times a day (2026-10-01)

**The problem:** a litter box is often scooped more than once a day (twice a day is common, more with several cats), but what H built assumes at most once:
- **Reminder intervals are whole days** (1 to 365), and "due" is a day: a box scooped at 08:00 with "daily" isn't due again until tomorrow at 9am, and "twice a day" or "every 8 hours" can't be set at all.
- **The double-tap guard asks "Record it again?" for the same litter job within 2 hours**, which gets in the way when a second cat uses the box soon after.
- **The Today row shows only the last scoop** ("scooped 15:20 by Mom"), not how many times it was done today.

**Two kinds of reminder, the owner picks one per job.** Whichever is picked, every tap still records **when it was actually done and by whom** ("scooped 15:20 by Mom"), as since checkpoint D: "Change time" and "Add details" fix a late tap, and the Today row, timeline, "Care by day" chart and CSV show the real times. The reminder only reads those records.

| | **A. Every … after it was last done** | **B. At set times** |
|---|---|---|
| Owner sets | 3 times a day (8 hours), twice a day (12 hours), daily, twice a week, weekly, every 2 weeks, twice a month, monthly, or custom hours or days | Up to **6 times of day**, e.g. 08:00 and 20:00 (like medication times) |
| Due | The last time it was done + the interval. Under 24 hours: to the minute ("due at 20:00"); 24 hours or more: a day, as in H ("due today", "in 3 days") | Each set time, unless it was done in its window: up to 2 hours late counts for it, anything later counts for the next set time (a scoop at 19:40 counts for 20:00; one at 22:30 counts for the next morning's 08:00). *(Refined while building; see the result.)* |
| Doing it early | Moves the next due time | Covers the next set time only |
| Reminder | Once when due, between 9am and 9pm in the person's time zone (overnight waits for 9am); one follow-up after one more interval (under a day) or 2 days later (a day or more), then nothing until it's done | Once at each set time that isn't covered, at that time (the owner chose it, so no 9am–9pm limit); one follow-up 2 hours later if still not done |
| Today row | "🚽 Scooped due at 20:00" / "overdue since 20:00" / "due in 3 days" | Like doses: "🚽 08:00 ✓ 07:55 by Mom · 20:00 due" (done green, due grey, late red after an hour) |

**Build:**

| Part | Build |
|---|---|
| 1. Data | `care_routines` gets `mode` (`interval` · `times`), the interval in **hours** (`every_hours`, filled from `every_days` × 24, then `every_days` removed) and `times` (a list of "HH:MM", up to 6). Existing routines become `interval` with the same length, so nothing changes for them. The "sent once" key includes the due time (`routine:12:2026-10-05T20:00`) |
| 2. Settings | Household page, one line per job: **[Off · Every … · At set times]**; "Every …" shows the interval choices, "At set times" shows up to 6 time fields (the other fields hide; without JavaScript both show and only the chosen one is saved) |
| 3. Due and reminders | `CareRoutine#next_due` for both kinds; `HouseholdReminders` sends each kind by its rules above |
| 4. Today row | "Scooped 3× today · last 15:20 by Mom", plus the due line (A) or the set times with their status (B). Same on the viewer page |
| 5. Double-tap guard | The same litter job within **30 minutes** (instead of 2 hours) asks "Record it again?"; water and feeding stay at 30 minutes |
| 6. Checks | Tests: existing intervals moved over unchanged; A under 24 hours (doing it early moves it, overnight waits for 9am, one follow-up after one more interval); A of days unchanged; B (a slot covered by a record since the previous set time, the first slot looking back to yesterday, once per set time, one follow-up 2 hours later, any hour); switching kind; "3× today"; the 30-minute guard; a browser test setting "At set times 08:00, 20:00" on one box and "Twice a day" on another |

**Decisions for H2 (recommended; change any before building):**
- **Both kinds work for any job**, not only scooping (e.g. "refill the bowl at 08:00 and 18:00").
- **A never reminds between 9pm and 9am; B reminds at the times the owner set**, whatever they are.
- **Which set time a scoop counts for**: up to 2 hours after a set time, that one (late); otherwise the next one (early). A scoop isn't counted twice for two set times. *(Refined while building: the plan first said "looks back to the previous set time".)*
- **Changing kind or times starts fresh**: nothing already sent is sent again, and the new rules apply from the next due time.

## Checkpoint H result (2026-10-01)

**What people see now:**
- **Household page** (owner), each litter box and water spot: **"Reminders: every"** with one line per job (🚽 Scooped, ♻️ Full change; 💧 Refilled, 🧽 Cleaned, 🔄 Filter changed): Off, Twice a week (4 days), Weekly (7), Every 2 weeks (14), Twice a month (15), Monthly (30) or Custom (1 to 365 days), saved with the spot's name. A fountain turned into a bowl loses its filter interval.
- **Today page**, each litter box and water spot: "🧽 Fountain cleaned due in 4 days", "💧 Refilled due today" (amber), "🚽 Scooped 2 days overdue" (red). The viewer page shows the same.
- **Today page**, under each household's name, for the owner and caregivers: **"🔕 Reminders: off · Turn on"** / **"🔔 Reminders by LINE: on · Turn off"** (or "by email"): each person's own choice; viewers have none.
- **The reminder** (LINE, or email if they didn't sign in with LINE or the LINE push fails), in their language: "🔔 Reminders for Rita's cats", then e.g. "🧽 Fountain cleaned · Kitchen fountain: might be time. Last: 9/28 by Dad." or "💊 Aji: Clavamox 1 tablet (20:00 dose) hasn't been recorded.", and a link to the Today page.

**Main files:** `CareRoutine` (`due_on`, `apply`, presets), `CareReminder`, `HouseholdReminders` (who gets what, when), `CareReminderNotifier` (LINE or email, the text), `CareReminderJob` (hourly, `config/recurring.yml`), `CareReminderMailer`, `ReminderSettingsController`, `CareSpotsController` (intervals), `HouseholdDay#routines`, `care_events/_status`, `today/show`, `households/show`; `db/migrate/20261001120000_create_care_routines_and_reminders.rb` (checked on PostgreSQL: up, down, up).

**Decisions made while building:** as in the [build plan](#checkpoint-h-build-plan-2026-10-01), plus:
- **The job runs every hour at :05** and each person is checked against their own clock, so 9am works in every time zone.
- **A reminder is recorded after it's sent**: if LINE and email both fail, nothing is recorded and the next hour tries again.
- **Dose reminders go out any time of day** (the owner chose the dose times), only within 3 hours after the dose became late.
- **The language** of a reminder follows the person's time zone (Taipei → 繁體中文, Tokyo → 日本語, else English), as the kibble price emails do.

**Also changed:** the household page's spot rows now put the name and kind on one line, the reminder lines below, then Save; on phones each job's name has its own line.

**Checks:**
- **18 new tests** and **1 browser test**. Due dates: from the day the interval was set, from the latest record of that job only (not other jobs, not undone taps), doing it early moves the date; the household page's choices (presets, custom, off, bad numbers, a bowl has no filter). Sending: not before 9am or after 9pm, once, one follow-up 2 days later and nothing after, nothing once recorded, due again a week after it was done, the person's own time zone, only people with reminders on and never viewers, several things in one message, LINE (and email when LINE fails), the email's text and link, overdue doses once and not too late, the hourly job. Pages: the owner saves intervals with the spot, bad custom days explained, caregivers can't change them, due lines on Today and the viewer page, each person's switch (owner, caregiver, LINE or email shown), viewers and outsiders refused. The **browser test**: the owner sets "Twice a week" and a custom 10 days, sees both due on Today and turns reminders on.
- `bin/rails test`: 433 runs, 0 failures. `bin/rails test:system`: 38 runs, 0 failures. RuboCop and Brakeman clean.

## Checkpoint H build plan (2026-10-01)

| Part | Build |
|---|---|
| 1. Data | `care_routines` (a litter box or water spot, one of its jobs, every N days, the day it was set; one per spot and job); `care_reminders` (who, which routine's due day or which dose, by LINE or email, when sent, when followed up; unique per person and reminder, so nothing is sent twice); `reminders_enabled` on memberships and `owner_reminders_enabled` on households |
| 2. Settings | **Household page**, each litter box and water spot: one line per job, "every [Off · Twice a week · Weekly · Every 2 weeks · Twice a month · Monthly · Custom] (N days)", saved with the spot's name. **Today page**, each household: "🔔 Reminders: on / off" for the owner and each caregiver, their own choice |
| 3. Due on Today | Each litter box and water spot row: "🧽 Cleaning due today", "🔄 Filter changed in 6 days", "🚽 Scooping 2 days overdue", from the latest record of that job (or the day the interval was set) plus the interval |
| 4. Sending | An hourly job: for each owner and caregiver with reminders on, what's due in each household is sent **once** at or after **9am in their time zone** (until 9pm), with **one follow-up 2 days later** if still not done; overdue doses (1 hour after the dose time, nothing recorded) once, within 3 hours. One message per person per household per run, **LINE** if they signed in with LINE (email if LINE fails), else **email**, with a link to the Today page; in their language |
| 5. Checks | Tests for due dates, the job (9am, once, follow-up, none after it's done, early jobs move the date, viewers and people with reminders off never, LINE or email, meds), the settings (owner only) and the switch; a browser test |

**Decisions for H:**
- **Reminders are off until each person turns them on** (owner included), so nobody gets messages they didn't ask for.
- **Due days are counted in the household's time zone; sending waits for 9am in the person's own time zone.** Nothing is sent between 9pm and 9am.
- **Several things due at once go in one message** per person and household.
- **A dose reminder is only for a dose that was due in the last few hours**, so adding a medication mid-day doesn't send reminders for this morning's dose.
- **Stopping an interval (Off) removes its routine**; past records stay. A changed interval keeps the day it was first set.
- **Weight reminders stay as they are** (every 14 days, owner).

## Checkpoint G result (2026-10-01)

**What people see now:**
- **Live updates:** a tap, a change of time, details, an undo, a tracker, a medication or a litter box or water spot change in a household appears on everyone's **Today page** and on its **viewer pages** within a moment, without reloading; the page keeps its scroll position.
- **Your saved notice stays open** (Undo, Change time, Add details, the water checkboxes) when someone else's change refreshes your page.
- **Charts** (the cat's trackers page and the viewer page): **⚖️ weights** join the weight line (averaged with the trackers' weights that day), and a new **"Care by day"** chart: 🍽 Fed (taps), 🚽 Litter jobs and 💧 Water jobs (the household's), 💊 Doses given, 💊 Couldn't give and 🔍 Litter observations (this cat's). The public share page is unchanged.
- **Household page:** **Care records → Download care records (CSV)** (owner only): date, time, type, cat, litter box or water spot, jobs, details, weight, note, recorded by, changed; in the household's time zone, undone taps left out.
- In English, Japanese and Traditional Chinese.

**Main files:** `RefreshesHouseholdPages` (in `CareEvent`, `Tracker`, `Medication`, `CareSpot`; `CareEvent#undo!` too), `ApplicationCable::Connection`, `keep_on_refresh_controller.js`, `today/show`, `viewer_pages/show`, `CareChart`, `TrackersCalculable` (`care:`), `shared/_care_chart`, `CareRecordsCsv`, `CareRecordsController`; `db/migrate/20261001110000_create_solid_cable_messages.rb` (checked on PostgreSQL: up, down, up).

**Decisions made while building:** as in the [build plan](#checkpoint-g-build-plan-2026-10-01), plus:
- **Production had no Solid Cable table** although `config/cable.yml` named Solid Cable, so the plan's "production already runs it" was wrong; the migration adds it to the shared database.
- **A day with only a weight now has its place on the amount chart** (in date order), so ⚖️ weights recorded on days without trackers show up.
- **The refresh broadcasts are jobs** (Solid Queue in production, on the worker), sent once for many changes in a row.

**Also fixed in this round:** on the household page, the litter box and water spot rows overflowed their list on phones, and the "Add" and viewer-link forms ran off the page from 480px up: the name fields took their width from their 40-character limit. A browser test checks 320, 375, 600 and 800px.

**Checks:**
- **14 new tests** and **2 browser tests**. Refreshes: a care record (saved, changed, undone), a tracker, a medication and a care spot refresh their household only, and a refresh carries no data. Cable: a signed-in person connects as themselves, a viewer page without an account; a signed household stream is accepted and a made-up one refused. Pages: Today listens to each of its households and the notice keeps itself on others' refreshes; the viewer page listens to its household only and keeps its charts. Charts: care counted per local day (household litter and water, the cat's own feedings, doses and observations; undone taps and other cats left out; date limits), weights averaged into the weight line in date order, the care chart on the trackers and viewer pages but not on the share page or without care. CSV: columns, details, time zone, undone taps left out, caregivers refused. The **browser test** opens three browsers: the owner taps Fed, Mom scoops; the owner's Today and the viewer page show it without reloading, the owner's notice stays open; Mom moves the time back 10 minutes and the viewer page follows.
- `bin/rails test`: 415 runs, 0 failures. `bin/rails test:system`: 37 runs, 0 failures. RuboCop and Brakeman clean.

## Checkpoint G build plan (2026-10-01)

| Part | Build |
|---|---|
| 1. Live updates | Each change in a household (a care record saved, changed or undone; a tracker; a medication; a litter box or water spot) sends a **page refresh** to that household over Turbo Streams. The Today page listens to each household it shows, the viewer page to its household; they refresh in place (morphing, scroll kept) |
| 2. Production | **Solid Cable's table is created by a migration**: production's database has no `solid_cable_messages` yet (only Solid Queue's and Solid Cache's), so live updates wouldn't work there. Cable connections are allowed without signing in, for the viewer page; stream names are signed, so a page only hears the household it was given |
| 3. Charts | **Weight** from ⚖️ records joins the weight line. A **"Care by day"** chart under the amount chart (trackers page and viewer page): per day, litter jobs and water jobs (the household's), this cat's doses given and not given, and this cat's litter observations |
| 4. CSV | **Download care records (CSV)** on the household page, owner only: every record (not undone), in the household's time zone |
| 5. Checks | Tests for the broadcasts, the cable connection, the charts and the CSV; a browser test with two sessions (a caregiver taps, the owner's Today page and a viewer page show it without reloading) |

**Decisions for G:**
- **A refresh carries no data**: each page asks the server again, so everyone still sees only what their role allows (viewers no notes, no buttons).
- **Your own tap doesn't refresh your page twice**: Turbo skips the refresh a page caused itself.
- **The saved notice stays open** (Undo, Change time, Add details, the water checkboxes) when someone else's change refreshes the page; it closes when you leave the page or tap again.
- **The viewer page's chart isn't redrawn by a live update** (the status and timeline are); it updates when the page is reloaded or another cat or range is picked.
- **The public share link** (the owner's per-cat share page) stays feeding records only: no care chart.
- **Many changes at once** (a CSV import, deleting a cat) send one refresh, not one per record.

## Checkpoint F result (2026-10-01)

**What people see now:**
- **A litter record's details page** (Add details in the saved notice, or Change on the timeline) has **Litter observations**, all optional: **which cat** (the household's cats, or "Not sure"), **pee clumps** (none, few, normal, many), **poops** (0 to 10), **stool** (normal, soft, diarrhea, hard), **something unusual** (blood, very large clumps, other; "other" is explained in the note). Saving with everything empty adds nothing, and observations can be cleared again.
- **Timeline** (Today and the viewer page): "🚽 Upstairs box: scooped · Mom · Aji · pee normal · 2 poops · stool soft". **Diarrhea and anything unusual are in red.** Older records show as before.
- **The cat's history** (its feeding records page, owner and caregivers): **"Litter observations, last 30 days"**, newest first, with the note; "None in the last 30 days." when there are none.
- **Viewer page:** the observations, never the note.
- In English, Japanese and Traditional Chinese.

**Main files:** `CareEvent` (`LITTER_DETAILS`, the checks, `observations?`, `observation_warning?`; the box stays the record's subject when a cat is named), `CareEventsController#details_params`, `care_events/edit`, `_timeline`, `CareEventsHelper#litter_observations_text`, `trackers/_litter_observations`, `Pet` (keeps litter records on delete). No migration: observations use the `details` and `pet_id` columns from D.

**Decisions made while building:** as in the [build plan](#checkpoint-f-build-plan-2026-10-01), plus:
- **Naming a cat doesn't change the box's record**: the household, the repeat question and the box's "last done" still come from the box.
- **A cat can only be named on a litter record**; the form's cat is ignored on feedings and water records, and the model refuses it.
- **The poop count is stored as a number**, and the "unusual" items always in the list's order.

**Checks:**
- **14 new tests** and **1 browser test**. Model: values checked and tidied, empty fields dropped, the red warning, only litter takes observations or a cat, another household's cat refused, the repeat question unchanged, deleting a cat keeps its litter records. Pages: an old record unchanged and the form offered, a caregiver adds observations and the cat (timeline, "(changed)"), red for diarrhea and blood, clearing, another household's cat and made-up values refused, no cat on feedings or water records, the cat's history for the owner and a caregiver (30 days, its own records only, the note), the empty history, the viewer page without the note, deleting the cat. The **browser test**: Mom scoops, adds Aji, pee, poops, diarrhea and blood with a note; the timeline shows it in red; the owner finds it in Aji's history; the viewer link shows it without the note. The **CSP** browser test also loads a litter record's details page.
- `bin/rails test`: 401 runs, 0 failures. `bin/rails test:system`: 35 runs, 0 failures. RuboCop and Brakeman clean.

## Checkpoint F build plan (2026-10-01)

| Part | Build |
|---|---|
| 1. Data | No migration: observations go in the litter record's `details` (pee, poop count, stool, unusual) and "which cat" in its `pet_id`. The model checks the values, that the cat is in the box's household, and that only litter records take observations or a cat |
| 2. Add details | An "Observations" section on a litter record's details page (from the saved notice's Add details, or Change on the timeline): which cat, pee clumps, poop count, stool, something unusual, and the note |
| 3. Where they show | The timeline (Today and the viewer page): "🚽 Upstairs box: scooped · Dad · Aji · pee normal · 2 poops · stool soft", with diarrhea or anything unusual in red. The cat's history (its feeding records page, for the owner and caregivers): "Litter observations, last 30 days" |
| 4. Checks | Tests for the checks, old records, the timeline, the cat's history and the household checks; a browser test |

**Decisions for F:**
- **Every observation field is optional**, and older litter records simply show none. Saving the form with nothing filled adds nothing.
- **Pee clumps:** none, few, normal, many. **Poop count:** 0 to 10. **Stool:** normal, soft, diarrhea, hard. **Something unusual:** blood, very large clumps, other (more than one can be ticked; "other" is described in the note).
- **Which cat** lists the cats of the box's household only; a cat from another household is refused.
- **Diarrhea and anything unusual are shown in red** on the timeline and in the cat's history, so they stand out.
- **The note stays off the viewer page**, as in D; viewers see the observations themselves.
- **Deleting a cat keeps the litter records it was named on**, without the cat (the box's records are the household's).
- Observations on the charts come with G.

## Checkpoint E result (2026-10-01)

**What people see now:**
- **Medications page per cat** (owner only; from the cat's profile and the 💊 panel): add a medication with a name, dose, up to 4 times a day (none = as needed), start and optional end date; change it; **Stop** it (it leaves Today; its past doses stay, and it's listed under "Stopped").
- **On the Today page**, under each cat: every medication with today's doses, e.g. "💊 Clavamox 1 tablet: 08:00 given by Mom at 08:05 · 20:00 due", in colour: given (green), couldn't give with the reason (amber), **overdue** an hour after the dose time (red), due (grey). As-needed: "as needed, last given yesterday 21:00 by Mom".
- **💊 Meds** (cats with medications) opens the confirmation: "Give Aji Clavamox 1 tablet (20:00 dose)?" with **Given**, or a reason (refused, spat it out, vomited, other) and **Couldn't give**. Today's unrecorded doses are listed, the closest to now first, then as-needed medications. A recorded dose isn't offered again. The saved notice has Undo, the quick time changes and Add details, as for other care.
- **Double dose:** "Mom already gave Aji Clavamox 1 tablet (20:00) at 19:55. Record it again?"
- **The owner's "Other medicine"** in the 💊 panel (on any cat): a name and dose, recorded as given.
- **Timeline:** "💊 Aji: Clavamox 1 tablet (20:00), given · Mom" or "couldn't give (spat it out)". The details page can change the outcome and reason.
- **Viewer page:** the same dose statuses and timeline, without the 💊 panel.

**Main files:** `Medication` (schedule, `doses_on`, overdue), `CareEvent` (meds checks: the cat's own medication, one of its times, status and reason, one-off medicine name; `recent_dose`), `MedicationsController`, `medications/index`, `care_events/_meds_panel`, `_meds_status`; `db/migrate/20261001100000_create_medications.rb` (checked on PostgreSQL: migrate, rollback, migrate).

**Decisions made while building:** as in the [build plan](#checkpoint-e-build-plan-2026-10-01), plus:
- **A missed dose never blocks another**: only a dose recorded as **given** triggers the double-dose question.
- **A dose is matched to its day by when it was recorded**, in the household's time zone.
- **A medication with recorded doses can't be deleted**, only stopped; deleting the cat removes its medications and doses.

**Checks:**
- **18 new tests** and **1 browser test**. Model: times tidied and checked (up to 4, HH:MM), dates in order, active days, each dose due, given, couldn't give or overdue, the dose record's checks (status, reason, a time of that medication, the cat's own medication, a one-off needs a name), double doses (scheduled, as needed, one-off), stop instead of delete. Pages: the owner adds, changes and stops medications; bad input explained; caregivers, viewers and outsiders can't change the list (also two new rows in the role × page matrix); doses on Today (order, statuses, notice, timeline); couldn't give with a reason; the double-dose question; no 💊 for a caregiver on a cat without medications, the owner's one-off medicine; as-needed; another cat's or a stopped medication and a wrong time refused; changing the outcome; the viewer page. The **browser test**: the owner adds a medication with two times; Mom gives the current dose, which is then no longer offered, and records the other as "couldn't give (spat it out)"; the viewer link shows both. The **CSP** browser test also loads the medications page.
- One run of the whole browser suite failed once on the first page after sign-in (an earlier care test, passing on its own and in the next two full runs); those tests now wait up to 10 seconds for it.
- `bin/rails test`: 387 runs, 0 failures. `bin/rails test:system`: 34 runs, 0 failures. RuboCop and Brakeman clean.

## Checkpoint E build plan (2026-10-01)

| Part | Build |
|---|---|
| 1. Data | `medications` (cat, name, dose, times of day or none for "as needed", start and end dates, stopped); care events get `meds` with the medication, the dose time, **given** or **couldn't give** and a reason; the checks in the model (the medication must be that cat's, the dose time one of its times) |
| 2. Owner's medications page | Per cat: add, change and stop medications; linked from the cat's card on Today and its profile |
| 3. Today | 💊 on cats with medications opens the confirmation: "Give Aji 1 tablet Clavamox (20:00 dose)?" → **Given** or **Couldn't give** with a reason; each dose shows **due**, **given**, **couldn't give** or **overdue**; the double-dose guard; the timeline and the details page; the owner's one-off "Other medicine" |
| 4. Checks | Tests for schedules, statuses, the guard and the household and cat checks; a browser test |

**Decisions for E:**
- **Up to 4 times a day**; a medication with no times is **as needed**.
- **Overdue** = 1 hour after the dose time with nothing recorded (the same hour H will use for the reminder).
- **The 💊 confirmation lists today's doses not yet recorded**, the one closest to now first, plus as-needed medications. A dose missed earlier in the day can still be recorded.
- **Double dose:** a scheduled dose already **given** today at that time, or an as-needed medication given in the last 2 hours, asks before recording again ("Mom gave the 20:00 dose at 19:55. Record it again?").
- **Changing or stopping a medication keeps past records**: each record keeps its medication and dose time.
- **One-off medicine** (owner only): "💊 Other medicine" with a name and dose, on any cat, for something not on the list.
- **Caregivers see the medications and record doses**; only the owner adds or changes them. Viewers see the statuses and the timeline.

## Checkpoint D result (2026-09-30)

**What people see now:**
- **Today page**, per household: a row for each litter box (🚽 Scooped · ♻️ Full change) and water spot (💧 Refilled · 🧽 Bowl/Fountain cleaned, plus 🔄 Filter changed on fountains), then each cat (🍽 Fed · ⚖️ Weight). Next to each: the last time it was done and by whom ("refilled, fountain cleaned 07:30 by Mom", "Fed 08:12 by Mom", "4.2 kg (yesterday 20:10)"). Below: **today's timeline**, newest first, including the owner's trackers ("(tracker)"). Viewers with an account see the same without buttons.
- **After a tap:** a notice with **Undo** (disappears after 10 seconds), **Change time: 5 · 10 · 15 min ago**, **Add details**, and, for water, the spot's jobs as **checkboxes** that save as soon as they're ticked. A second water tap on the same spot within 2 minutes joins the same record.
- **Double-tap guard:** "Mom recorded “Aji: fed” at 08:05. Record it again?" (fed and water within 30 minutes; the same litter job within 2 hours).
- **Details page** ("Add details" or **Change** on a timeline entry): the time (up to 7 days back), the jobs, a note, the weight, and for feedings the **food type, suggestions, brand, description and amount**. Suggestions follow the food type: the household's **bags** with what's left (kibble, freeze-dried), the cat's **favorite wet foods** (score 30+, last date), its **past "other" foods**. Edited entries show "(changed)".
- **Add to trackers** (owner only): the tracker form opens prefilled with the feeding's date, time, food type, brand, description, amount and bag; the owner adds hunger and the rest, and the timeline then shows the feeding once.
- **Viewer page:** the same status rows and today's timeline, read-only, above the charts. No notes or emails.
- **Household page:** **Litter boxes and water spots**: add, rename, bowl or fountain, move up or down, remove (archived: gone from Today, past records keep the name).

**Main files:** `CareEvent` (all household checks, undo and edit rules, the repeat check), `HouseholdDay` (one household's day for Today and the viewer page), `FeedingSuggestions`, `CareEventsController`, `CareSpotsController`, `care_events/_status`, `_timeline`, `_notice`, `_repeat_prompt`, `edit`; `care_details_controller.js`, `expire_controller.js`; `db/migrate/20261001090000_create_care_events.rb` (checked on PostgreSQL: migrate, rollback, migrate).

**Decisions made while building:**
- **The tapper's page refreshes after each tap** (Turbo page refresh with morphing, so the scroll position stays). Other people see new records when they reload, until live updates in G.
- **A household's "today" and its times use the owner's time zone**, like its trackers.
- **Weight** is a care event only; the cat's profile weight and the charts don't change until G.
- **Rows show "last done"**, not "due"; due dates need the reminder intervals from H.
- **A spot's jobs are always stored in the spot's order** ("refilled, fountain cleaned"), whichever was tapped first.
- **A litter box stays a litter box**; a water spot can switch between bowl and fountain, and its past "filter changed" records keep their label.

**Found and fixed:** the **Copy** button for new viewer links (checkpoint C) did nothing, because its Stimulus controller wasn't registered in `controllers/index.js`. It's registered now, with the new ones. (`bin/rails stimulus:manifest:update` also rewrites every import to a relative path, so new controllers are added to that file by hand.)

**Checks:**
- **32 new tests** and **1 browser test**. Model: household from the cat or spot, subject and jobs per kind, time limits, feeding details and another household's bag refused, weight range, tracker of the same cat only, repeats, who may undo and change, records removed with their cat or household and kept (without a name) when a member is deleted. Pages: buttons for caregivers but not viewers; one tap; the repeat question; water records built from taps and checkboxes; litter jobs separate; quick time change; undo within 10 seconds only; weight; the owner's trackers on the timeline; another household's cat or spot, an archived spot, and a viewer refused; caregivers change only their own records for a day; a tampered request can't choose the household, person, cat, spot or tracker; details and suggestions; Add to trackers (prefilled, linked, bag stock updated, shown once, owner only); spots managed by the owner only; the viewer page's status and timeline. The **browser test** runs the whole flow: a caregiver taps Fed and adds details from a suggestion, refills and ticks "Fountain cleaned" in one record, scoops and moves it 10 minutes back, undoes an accidental tap; the owner adds the feeding to trackers; the viewer link shows the records with no buttons. The **Content-Security-Policy** browser test now also loads Today, the household page and the viewer page.
- `bin/rails test`: 369 runs, 0 failures. `bin/rails test:system`: 33 runs, 0 failures. RuboCop and Brakeman clean.

## Checkpoint D build plan (2026-09-30)

Built in five parts, each committed after `bin/rails test` passes:

| Part | Build |
|---|---|
| 1. Care events | `care_events` table (fields for D only: medications come in E, litter observations in F, both additive); `CareEvent` model with every household check in the model; `record_care` permission for owners and caregivers |
| 2. Today page buttons | Litter box and water spot rows, cat cards with 🍽 Fed and ⚖️ Weight, "last done" next to each; one-tap saving; the saved notice with **Undo** (10 s), **5 · 10 · 15 min ago**, **Add details**, and the water checkboxes; the double-tap guard; today's timeline, including the owner's trackers |
| 3. Details | A page per care event for changing the time, the water or litter actions, the feeding details (suggestions by food type, from the cat's household only), the weight and a note; "(changed)" on edited entries; the owner's **Add to trackers** |
| 4. Viewer page and spots | Status rows and today's timeline on the viewer page, without buttons; adding, renaming, choosing bowl or fountain, reordering and removing litter boxes and water spots on the household page |
| 5. Checks | A browser test of the whole flow; tests that every save refuses a household mismatch and a person without rights |

**Decisions for D:**
- **Pages refresh after each tap** (the tapper's own page, using Turbo's page refresh, which keeps the scroll position). Seeing other people's taps without reloading comes with live updates in G.
- **A household's day and times use the owner's time zone**, the same zone its trackers already use, so "today" means the same thing for everyone in the household.
- **Weight** is saved as a care event only; the cat's profile weight and the charts are unchanged until G puts care events on the charts.
- **Due dates** ("Cleaning due today") need the reminder intervals from H; until then each row shows the last time it was done.

## Checkpoint C result (2026-09-30)

**What was built**, in five commits:

| Part | What people see | Main files |
|---|---|---|
| 1. Models | Nothing yet | `household_invitations`, `viewer_links`, `ownership_transfers` tables; `SecretToken` concern (a long random token shown once, stored only as a SHA-256 digest); `HouseholdInvitation#accept!`, `ViewerLink.find_active` / `#revoke!` / `#record_use!`, `OwnershipTransfer#accept!` |
| 2. Household page (`/household`, owners only) | Members with **Remove**; **Invite a caregiver** by email; invitations waiting to join, with **Cancel**; **viewer links**: name, expiry (never, 7, 30 or 90 days), the new link shown **once** with a **Copy** button, when each was last opened, **Turn off**. Linked from the account page and the account menu as "🏠 My household" | `HouseholdsController`, `HouseholdInvitationsController`, `ViewerLinksController`, `HouseholdMembersController`, `OwnedHousehold` concern, `HouseholdMailer#invitation`, `copy_controller.js` |
| 3. Joining and landing | **Join page** (`/join/:token`): "Rita invited you to help with Aji and Umi, as a caregiver", email fixed from the invitation, name and password; or Google / LINE; or "Already have an account? Sign in". **Landing rules** (below). A first **Today page** (`/today`): the user's own cats first, then each household they help with and their role, with links to trackers and charts. **Menus:** "Today" at the top; the Trackers menu lists other households' cats under "Rita's cats (read-only)" (charts only for a viewer); someone who only helps gets the **smaller menu** (no cat list, food bags or health checks). **Account page:** "Households you help with" with **Leave**, and **🐱 Add my own cat** ("This creates your own household. Rita's cats won't change.") | `HouseholdJoinsController`, `HouseholdArrival` concern (used by password sign-in, sign-up and Google / LINE / GitHub), `TodayController`, `HouseholdMembershipsController`, `User#member_households` / `#helper_only?` |
| 4. Viewer page (`/view/:token`) | "🐾 Rita's cats · shared with Grandma", a cat picker and range, the amount and weight chart; no sign-in and no app menu. **Sign up** / **Sign in** buttons (or **Add to my account** when signed in) add the household as a viewer membership. Turned-off, expired and unknown links show "This link is no longer active" | `ViewerPagesController`, `shared/_tracker_chart` (the share page's chart, now shared by both pages), `content_for :without_app_menu` in the layouts |
| 5. Transfer ownership | On the household page: pick a member and **Offer household**; "Waiting for Mom to accept (until …)" with **Cancel**. The member gets an **email** and a notice on **Today**, and accepts on `/transfers/:id`. **Deleting an account** whose household has members goes to the household page first: hand it over, or **Delete my account, household and cats** | `OwnershipTransfersController`, `OwnershipTransferOffersController`, `HouseholdMailer#ownership_transfer`, `UsersController#destroy` |

**Where people land after signing in** (password, sign-up, Google, LINE, GitHub):

| Person | Lands on |
|---|---|
| Member of anyone else's household (caregiver or viewer), even on the first sign-in or while also owning cats | Today |
| New user with no household | Add A Cat, as before |
| Everyone else | The pet list, as before |

An invitation or viewer link opened before signing in is kept in the (encrypted) session and applied right after signing in or up, with "You've joined Rita's cats." or "Rita's cats is now in your account."

**Decisions made while building:**
- **A first, simple Today page now.** Caregivers land on Today from this checkpoint, so it exists already, listing the cats by household with links to trackers and charts. Checkpoint D adds the buttons, status and timeline.
- **The viewer page shows the charts only for now.** The status rows and today's timeline come with care events in D.
- **Following a household from a viewer link needs a click** on Sign up / Sign in / Add to my account. Just opening the link and later signing in on the same browser adds nothing.
- **Invitation emails with Google or LINE must use the invited email**; a different account gets "This invitation was sent to a different email address." and lands as usual.
- **Ownership offers are accepted by the signed-in member**, by the offer's id (`/transfers/:id`): only that member can open it, so the email link needs no secret. The token column made in part 1 stays unused for now; J can drop it.
- **The invitation token is passed to the email job** as an argument, so it's stored in the job queue table until the job is cleaned up. It's single use, expires in 7 days and works only for the invited email.
- **Pets list** keeps showing only the user's own cats; other households' cats are on Today and in the Trackers menu.
- **Error messages are shown as written** (full sentences like "That's your own email address."), not prefixed with the field name.

**Checks:**
- **38 new tests**: household page (owner-only; invite, replace and cancel invitations; viewer link shown once and turned off; removing members; another owner's records not reachable); joining (sign up with the invited email, sign in, one-button join, Google, wrong email, expired / used / made-up links); landing for new users, owners, caregivers and owners who also help; Today grouped by household; the smaller menu, "Add my own cat" and leaving; viewer page (no index, no referrer, only its household's cats, stops when turned off or expired, following by sign-in, sign-up and one button, only on request, never downgrading a caregiver); transfer (email, in-app accept, replacing and withdrawing offers, only to members, no one else can accept, account deletion asks first).
- `bin/rails test`: 337 runs, 0 failures. `bin/rails test:system`: 32 runs, 0 failures. RuboCop and Brakeman clean.

## Checkpoint B result (2026-09-30)

**What was built** (nothing visible changes for today's one-person households):

| File | What it does |
|---|---|
| `app/models/household_policy.rb` | The one place that decides: the **owner** may do everything; a **caregiver** may `view_trackers` and `view_charts`; a **viewer** may `view_charts`; anyone else nothing |
| `app/controllers/concerns/pet_access.rb` | `load_pet(id, permission)`: finds the pet among `Pet.accessible_by(user)` (their own household and those they're a member of); a pet outside those is **"not found"**, as before; a reachable pet whose action the role doesn't allow redirects to its tracker page (or the pet list) with **"Only Aji's owner can do that."** (JSON: 403) |
| Trackers, pets, health checks, share link, kibble prices controllers | Use `load_pet` with a permission per action (below) |
| `Pet.accessible_by` / `Pet.owned_by`, `User#owned_pets` / `#owned_dry_foods`, `Pet#owner` | Lookups by household |
| Vet visits | "Owner" now means the household's owner (`@pet.owner`); the vet-visit member rule is unchanged, so caregivers and viewers get nothing extra there |
| Food bags | Listed and found through the owner's household; a tracker may only use a bag of **the pet's household** (was: the pet owner's bags) |
| Trackers pages | Owner-only controls hidden for others: import, share link and share settings, "new tracker", CSV export, bulk delete, the row checkboxes, edit and delete. Viewers don't see the list at all, only the charts. The favorite list's "Kibble prices" link is owner-only |
| Navigation, account page, pets list | The user's **own** household's cats (households they help with appear there in checkpoint C) |
| `UserBackupJob` / `UserBackupMailer`, `PetWeightReminderJob` / `notifications:weigh_pets`, `KibblePriceMailer`, `KibblePrices::BrandNames` / `Lookup` | Go through the household's **owner**, so backups, weight reminders, kibble price emails and brand names never reach caregivers or viewers |
| `config/locales/{en,ja,zh-TW}.yml` | `households.owner_only` |

**Permission per action:**

| Action | Owner | Caregiver | Viewer |
|---|---|---|---|
| Trackers page with charts (`trackers#index`) | ✅ | ✅ list read-only | ✅ charts only |
| Favorite list | ✅ | ✅ | ❌ |
| New, add, edit, update, delete, bulk delete, import trackers | ✅ | ❌ | ❌ |
| **CSV export** | ✅ | ❌ | ❌ |
| Pet profile, edit, delete | ✅ | ❌ | ❌ |
| Health checks, share link, kibble prices | ✅ | ❌ | ❌ |

**Decisions made while building:**
- **CSV export is owner-only.** It's the owner's full data download (like the backups), not part of reading the list.
- **The pet profile page is owner-only**, matching "My cats … not shown" for caregivers.
- **A refused action says so** ("Only Aji's owner can do that.") and returns to what the person may see, instead of "not found"; "not found" stays for pets outside their households, so nothing reveals that another person's cat exists.

**Checks:**
- **All 290 existing tests pass unchanged**, so one-person households behave exactly as before.
- **9 new tests**, including a **role × page matrix**: owner, caregiver, viewer and an outsider on 22 pages and actions, each classified as allowed / refused / not found; refused changes leave trackers, the pet and its share link untouched; a caregiver's tracker page has the list but none of the owner's controls; a viewer's has the charts but no list; JSON refusals are 403 and outsiders get 404; food bags stay with their household; backups, brand names and owned pets never go to a caregiver.
- `bin/rails test`: 299 runs, 0 failures. `bin/rails test:system`: 32 runs, 0 failures. RuboCop and Brakeman clean.

**Found (older than this work, not changed):** the single tracker page (`GET /pets/:pet_id/trackers/:id`) always fails: its row partial expects the whole list (`@trackers`), which that page doesn't set. Nothing links to it and its test has been commented out, so it went unnoticed; its JSON version has the separate issue ARCHITECTURE.md A1 already lists. It's left out of the role matrix.

## Checkpoint A result (2026-09-30)

**What was built** (nothing visible changes for anyone):

| File | What it does |
|---|---|
| `db/migrate/20260930120000_create_households.rb` | Creates `households` (one per owner: unique `owner_id`), `household_memberships` (caregiver · viewer, once per household), `care_spots` (litter box · water bowl · water fountain), and `household_id` on `pets` and `dry_foods`. Then, in plain SQL: one household for every user with pets or food bags, a litter box and a water bowl for each, and every pet and bag moved into its owner's household; `household_id` then becomes required |
| `app/models/household.rb` | Owner, pets, food bags, care spots, memberships and members; every new household gets one litter box and one water bowl; `Household.for_owner(user)` finds or creates a user's household |
| `app/models/household_membership.rb`, `care_spot.rb` | Roles `caregiver` / `viewer` (never the owner, once each); spot kinds `litter_box` / `water_bowl` / `water_fountain`, `active` = not archived |
| `app/models/user.rb`, `pet.rb`, `dry_food.rb` | `User#owned_household` (deleted with the user, with its pets, bags and spots) and `#household_memberships`. **Until checkpoint J**, pets and bags keep `user_id`: one created through today's pages joins its owner's household automatically (the first one creates it), and a pet or bag in another owner's household is invalid |
| `test/fixtures/households.yml`, `pets.yml`, `dry_foods.yml`; `test/models/household_test.rb` | Fixture households; 8 new tests |

**Details decided while building:**
- **Names can be empty.** `households.name` and `care_spots.name` start empty and will show as "Rita's cats" and "Litter box" / "Water bowl" in each viewer's own language (checkpoints C and D), instead of storing English or Chinese text.
- **A user with no pets and no food bags has no household yet** (e.g. a new sign-up). It's created with their first cat or bag, which is also how "Add my own cat" will work.

**Checks:**
- **Local data** (development database): Rita, test2 and testuser_csv each own one household with their pets, Rita's 2 food bags, a litter box and a water bowl; the user with no pets has none; no pet or bag is in another owner's household; all 9,193 trackers still belong to their pets.
- **PostgreSQL 15** (throwaway database, deleted afterwards): from the schema before this change, with users who have pets, only a food bag, or nothing, the migration created exactly the right households, moved all pets and bags, gave each household 2 care spots, and made `household_id` required. Rolling back and migrating again both worked.
- `bin/rails test`: 290 runs, 0 failures (the 282 existing tests unchanged, plus 8 new). `bin/rails test:system`: 32 runs, 0 failures. RuboCop and Brakeman clean.

**`db/schema.rb` flavor:** the Change F commit (`4d4a454`, kibble prices) accidentally committed a `schema.rb` dumped from a throwaway PostgreSQL database, because running `db:migrate` against it rewrote the file. It's back to being dumped from the development SQLite database, as before, so the dry-food foreign key shows as `"Users"` again (ARCHITECTURE.md D1, a separate fix). PostgreSQL checks now save and restore `schema.rb` around them.

## Decisions

| Topic | Decision | Why |
|---|---|---|
| Owners | **Exactly one owner per household.** A user owns at most one household (their own cats) | Matches how the app is used; simpler rules and tests; the email rule stays clear |
| Transfer ownership | **Built in.** The owner can hand the household to one of its members; deleting an account asks to transfer first | Covers the owner leaving or losing access |
| Co-owners | **Not now.** Can be added later without a database change (memberships already store a role) | Not needed yet |
| Caregivers and viewers | **Can belong to several households** (several owners' cats) | A family member helping two households; a pet sitter with several clients; an owner who also checks a friend's cat |
| Caregiver accounts | **A caregiver needs an account.** They join through the owner's invitation: a one-step page with the **email prefilled from the invitation**, a name and password, or **Google / LINE** sign-in; the time zone is detected. Someone with an account just signs in. After joining they land on the **Today page**, **not** the "Add A Cat" first-sign-in page | Recording care needs to know who did it ("by Mom"), whose records they may change, where to send reminders, and which households to show; one person can be removed without a shared link staying live |
| Viewer access | **A personal link, no account needed.** The owner creates a link per viewer (e.g. "Grandma") and sends it by LINE or email. It opens a read-only page with the household's **status, today's timeline and charts** only. The owner can **turn each link off** at any time and set an **optional expiry**. A viewer who signs up or signs in from the page gets the household added to their account (a viewer membership) | Viewers only look, so an account is just friction; one link per person keeps each revocable |
| Food bags | **Belong to the household** | Caregivers pick from them; with one owner, "household bags" and "owner's bags" are the same bags |
| Litter and water | **Shared, per litter box or water spot**, not per cat. One box and one water spot are created for every household; the owner can add, rename or remove more | Cats share boxes and bowls; whoever scoops is caring for the box |
| Water spots | Each is a **bowl** or a **fountain**. Bowl: **💧 Refilled · 🧽 Bowl cleaned**. Fountain: **💧 Refilled · 🧽 Fountain cleaned · 🔄 Filter changed**. **Several actions can go in one record** | One visit often covers several jobs |
| Several water actions | **Buttons + checkboxes:** one tap on any button saves that action; the saved notice shows **all the spot's actions as checkboxes** (the tapped one ticked), and ticking another adds it to the **same record** at once, with no Save button. The same checkboxes are in "Add details" on the timeline entry | Keeps one tap for the everyday refill, with a checklist feel when several jobs are done together |
| Reminders | Per water spot (and litter box) and job, the owner sets **how often**: twice a week, weekly, every 2 weeks, twice a month, monthly, or every N days. **Due = last time it was recorded + that interval**, so doing it early moves the next reminder. Sent **once** when due, at **9am in the member's time zone**, with **one follow-up 2 days later** if still not done. Overdue **meds** use the same system | Follows what actually happened instead of fixed weekdays; never nags about a job already done; not overnight |
| Who gets reminders | The **owner and caregivers**, each choosing on or off; never viewers | Viewers only look |
| Reminder channels | **Checkpoint H: LINE, else email**, as weight reminders already work (`NotificationService`). **Checkpoint I: Android app push via Firebase.** Each reminder goes by **one** channel per member: the Android app if they have it installed and notifications allowed, else LINE if they signed in with LINE, else email | LINE and email work today; the Android app is the real phone notification; one channel avoids duplicates |
| Litter | **🚽 Scooped · ♻️ Full change** | The two jobs that differ |
| Litter observations | **Built in a later checkpoint (F).** Stored in **optional fields** from the start, so older records simply have none; charts and the timeline show details only where they exist | Gets the one-tap buttons into use sooner; nothing breaks when details arrive |
| "Which cat" | Optional, and **only on litter observations** (someone saw it was Aji) | Ties a health warning to the right cat without making boxes belong to cats |
| Recording care | **Option A: one tap saves "now"** | Production trackers are entered within 10 minutes of feeding, so "now" is accurate; one tap in the usual case; others see it at once; nothing lost if interrupted |
| Changing the time | **"Change time"** in the saved notice and on each timeline entry; quick picks **5 · 10 · 15 min ago** plus a full picker | Rarely needed; quick picks match the 10-minute pattern |
| Option B ("ask for the time first") | **Not built** | The data doesn't call for it |
| Adding details later | **"Add details"** is on the saved notice **and on every timeline entry**, within the edit rules | Someone can add "soft stool, Aji" at lunch to a 07:30 "Scooped" |
| Caregiver's feeding details | After a 🍽 tap, all optional: date and time, **food type**, brand, description, amount. Brand and description **suggested by food type**. Saved **on the care event** | One tap for the usual case; details when useful |
| Details into trackers | The **owner** gets **"Add to trackers"**, a tracker form prefilled from the care event | Caregivers are read-only on trackers; the owner adds leftovers, hunger and love, so favorite scores and food-bag stock stay under the owner's control |
| Undo | **10 seconds** after a tap | Fixes accidental taps |
| Double-tap guard | Asks "Mom fed Aji at 08:05; record again?" when the same care was recorded within **30 min** (fed, water) or **2 h** (litter) for that cat or spot; for meds, a dose already given in the current time slot | Prevents double feeding and double doses between members |
| Meds | One tap **plus a short confirmation** ("Give Aji 1 tablet Clavamox?"), with **"Couldn't give"** and a reason | A wrong "given" could mean a missed real dose; a missed dose should be known |
| Time storage | One timestamp, `occurred_at` (UTC), shown in the user's time zone | Avoids the date + time-of-day handling trackers need (ARCHITECTURE.md §1.7) |
| Detailed feeding | **Stays in `trackers`** (owner) | The favorite score, charts, food bags and kibble prices depend on it |
| Viewers | **Charts and today's timeline, both read-only** | "Has anyone fed the cats yet today?" is what family members check |
| Kibble prices page | **Owner only** | The owner does the buying and gets the monthly email |
| Emails (kibble prices, backups) | **Unchanged: the owner only**, never caregivers or viewers | Decided 2026-09-29 |
| Kibble price tracker | **Unchanged** (the BigGo momo shop filter is not added) | Decided 2026-09-29 |
| Where people land after signing in | By what they have, not by "first sign-in": a new user with no household → **"Add A Cat"** (as today); an owner → the pet list (as today); a caregiver, or someone who is both owner and caregiver → **Today** | "Add A Cat" stays the start for new owners, and caregivers never get sent there |
| A caregiver's own cats | **"Add my own cat" under Account**, not in the main menu, with: *"This creates your own household. Rita's cats are not affected."* It creates their household (owner, one litter box, one water bowl); they are then an owner and a caregiver | Someone helping with another's cats can still get their own, without a second account |
| Keeping households apart | **No household picker.** The household of every record comes from the **cat, litter box or water spot** it's recorded on, set by the server, never taken from the form. Pages that need a cat use a **cat list grouped by household** | Nothing to choose wrongly; a tampered request still can't mix households |

## Roles

| | Owner | Caregiver | Viewer |
|---|---|---|---|
| Record care: one-tap buttons, weight | ✅ | ✅ | ❌ |
| How they get in | Account | **Account** (invitation) | **Personal link** (or an account, if they signed in from the link) |
| **Today's timeline** (see [The Today page](#the-today-page)) | ✅ | ✅ | ✅ **read-only**, on the [viewer page](#viewer-links-and-the-viewer-page) |
| "Add details" on a care event | Any event | Own events, within 24 hours | ❌ |
| Change the time of a care event | Any event | **Own events, within 24 hours** | ❌ |
| Undo (10 s) | Own taps | Own taps | ❌ |
| "Add to trackers" from a care event | ✅ | ❌ | ❌ |
| Trackers list and favorite list | ✅ | **Read-only** | ❌ |
| **Charts** | ✅ | **Read-only** | **Read-only** |
| Kibble prices page | ✅ | ❌ | ❌ |
| Health checks, vet visits | ✅ | ❌ | ❌ |
| Food bags | ✅ | Read-only (to pick from) | ❌ |
| Edit cats, medications, litter boxes and water spots, and their reminder intervals | ✅ | ❌ | ❌ |
| Receive reminders (their own on/off choice) | ✅ | ✅ | ❌ |
| Invite caregivers, create and turn off viewer links, remove members; transfer ownership | ✅ | ❌ | ❌ |
| Public share link | ✅ | ❌ | ❌ |
| Leave the household | — (transfer first) | ✅ | ✅ |

The existing **public share link** and **vet-visit members** keep working as they do today.

**Access rule:** "pets in the user's own household or in households where they are a member, allowed by their role". A **viewer link** is separate: its token opens only that household's viewer page (like today's public share page), never the app's other pages. One place decides it, e.g. `Pet.accessible_by(user)` and a small policy object (`HouseholdPolicy.new(user, household).can?(:record_care)`), used by every controller instead of `Current.user.pets`. A pet the user may not see stays "not found", as today (ARCHITECTURE.md §4.5).

## Example

```
Rita's household (owner: Rita)              Ken's household (owner: Ken)
  cats: Aji, Umi                              cats: Mochi
  litter boxes: Upstairs box, Bathroom box    litter boxes: Litter box
  water: Kitchen fountain                     water: Water bowl
  caregiver: Mom                              caregiver: Mom
  viewer: Grandma                             viewer: Rita
```

Mom's Today page shows both households ("Rita's cats · Ken's cats") with buttons. Grandma opens her personal link and sees Rita's cats' status, today's timeline and charts, read-only, without an account. Rita sees her own cats fully, and Mochi's charts and today's timeline.

## What the app has today

| Area | Today | This plan |
|---|---|---|
| Ownership | `pets.user_id` | `pets.household_id`; `households.owner_id` |
| Food bags | `dry_foods.user_id`; a tracker may only use a bag owned by the pet's owner | `dry_foods.household_id`; a tracker may only use a bag of the pet's household |
| Sharing | A public read-only link per pet; members on a single vet visit | Plus household members with roles |
| Feeding | Detailed `trackers` | Unchanged, plus one-tap "fed" care events |
| Litter, water, meds | None | Care events on litter boxes and water spots; medications with schedules |
| Who did it | Not recorded | Every care event records the member |

**Where the code assumes one owner** (all change in checkpoint B):
- `Current.user.pets…` in `PetsController`, `TrackersController`, `HealthChecksController`, `PetSharesController`, `KibblePricesController`, and in `layouts/_navigation.html.erb` and `users/show.html.erb`.
- `@pet.user == Current.user` in `VetVisitsController` (owner vs. vet-visit member).
- `Current.user.dry_foods…` in `DryFoodsController`, and `Tracker#dry_food_belongs_to_pet_owner`.
- User → pets in jobs and services: `UserBackupJob`, `PetWeightReminderJob` / `notifications:weigh_pets`, `KibblePrices::BrandNames.for_user`, `KibblePriceMailer`. These become "the household's owner", which gives the same result, since emails stay owner-only.

## Data model

```
households              id, owner_id → users (NOT NULL, unique: one household per owner), name, timestamps
household_memberships   household_id, user_id, role (caregiver · viewer), timestamps
                        unique (household_id, user_id); the owner is not a membership row
household_invitations   household_id, email, token_digest, invited_by_id, expires_at,
                        accepted_at, timestamps                               ← caregivers only
viewer_links            household_id, name (e.g. "Grandma"), token_digest, created_by_id,
                        expires_at (optional), revoked_at, last_used_at, timestamps
                        ← one per viewer; signing in from the page adds a viewer membership
ownership_transfers     household_id, from_user_id, to_user_id, token_digest, expires_at,
                        accepted_at, timestamps
care_spots              household_id, kind (litter_box · water_bowl · water_fountain), name,
                        position, archived_at, timestamps
                        ← litter boxes and water spots; one litter box and one water bowl per household to start
pets                    + household_id (NOT NULL once filled); user_id kept until checkpoint J
dry_foods               + household_id (NOT NULL once filled); user_id kept until checkpoint J
care_events             household_id, actor_id → users, kind, occurred_at,
                        pet_id        (fed, meds, weight; optional "which cat" on litter observations)
                        care_spot_id  (litter, water)
                        actions       (list: litter scooped · full_change;
                                       water refilled · cleaned · filter_changed)
                        details       (optional fields, empty on older records:
                                       fed: food_type, brand, description, amount_g
                                       litter observations (checkpoint F): pee, poop_count, stool, unusual)
                        medication_id, dose_status (given · couldnt_give), reason   (meds)
                        value (kg, weight), note,
                        tracker_id (set when the owner uses "Add to trackers"),
                        edited_by_id, edited_at, undone_at, timestamps
                        indexes (pet_id, kind, occurred_at), (care_spot_id, occurred_at)
                        kind: fed · litter · water · meds · weight
medications             pet_id, name, dose (text, e.g. "1 tablet"), times (e.g. ["08:00", "20:00"]
                        or none for "as needed"), starts_on, ends_on, active, timestamps
care_routines           care_spot_id, action (cleaned · filter_changed · refilled · scooped · full_change),
                        every_days, enabled, started_on, timestamps          ← reminder intervals (checkpoint H)
care_reminders          household_id, care_routine_id or medication_id, due_on (or dose time),
                        user_id, channel (android · line · email), sent_at, follow_up_sent_at
                        unique (reminder subject, due, user)                  ← "sent once" record
                        + household_memberships.reminders_enabled, households.owner_reminders_enabled
device_tokens           user_id, platform (android), token (unique), last_used_at, timestamps   (checkpoint I)
```

**Why `details` is optional fields:** the litter observations in checkpoint F add form fields and their display, not columns to existing rows. Records made before F simply have no observations, and the charts and timeline show observations only where they exist. A new detail later (say "litter brand") is also additive.

**Moving existing data (checkpoint A):** one migration creates a household for every user who has pets or food bags ("Rita's household"), with that user as **owner**, one litter box and one water bowl, and sets `household_id` on their pets and food bags. Nothing changes for current users. The migration is checked on a throwaway PostgreSQL database first, as in the kibble price work.

## Care events

**Recording (Option A):** one tap saves the care with `occurred_at = now` and the tapping member. A notice appears with **Change time**, **Add details** (where the kind has any) and **Undo**, and the household's timelines update.

| Care | Where | One tap | In the saved notice |
|---|---|---|---|
| 🍽 Fed | Each cat | Saves "fed" now | Change time · Add details (food type, brand, description, amount) · Undo |
| ⚖️ Weight | Each cat | Opens a small form (a number; "now" prefilled) | — |
| 💊 Meds | Each cat with medications | Confirmation: **Given** or **Couldn't give** (reason: refused, spat out, vomited, other) | Change time · Undo |
| 🚽 Scooped / ♻️ Full change | Each litter box | Saves that action now | Change time · Add details (observations, from checkpoint F) · Undo |
| 💧 Refilled / 🧽 Cleaned / 🔄 Filter changed | Each water spot (filter only on fountains) | Saves that action now | **Checkboxes for the spot's actions**, ticking one adds it to the same record · Change time · Undo |

**Several actions in one record (water): buttons + checkboxes**
```
✔ Kitchen fountain · 07:30   ☑ Refilled  ☐ Fountain cleaned  ☐ Filter changed   [Change time]  [Undo]
```
One tap on a button saves that action; the notice lists all of the spot's actions as checkboxes with the tapped one ticked. Ticking another box adds it to the **same record** straight away (no Save button); unticking removes it, as long as one action stays ticked. The same checkboxes are in "Add details" on the timeline entry, for adding actions later. A second tap on a water button for the same spot within 2 minutes also adds to the open record instead of creating a new one.

**Feeding details ("Add details" after 🍽), all optional:**
- Date and time (prefilled with the saved time).
- **Food type**: kibble, freeze-dried, wet, other. Picking one changes the suggestions for brand and description, the same way today's tracker form does (`tracker_form_controller.js`):

| Food type | Suggestions |
|---|---|
| Kibble / freeze-dried | The **household's food bags** of that type, with how much is left |
| Wet | The cat's **favorite wet foods** (score 30+) with the last fed date |
| Other | The cat's **past "other" foods** |

  Picking a suggestion fills in brand and description; typing something new is always allowed.
- Amount in grams.
- The timeline shows the details: "Fed 08:12 by Mom · 曙光 無穀滋養鴨肉 · 40 g".

**"Add to trackers" (owner):** opens the tracker form prefilled with the care event's date, time, food type, brand, description and amount (and the food bag, if picked). Saving it links the tracker to the care event (`tracker_id`), so the timeline shows it once. Food-bag stock and the favorite score update from the tracker, as today.

**Litter observations (checkpoint F), all optional, via "Add details":** pee clumps (none, few, normal, many), poop count, stool (normal, soft, diarrhea, hard), something unusual (blood, very large clumps, other), a note, and **which cat**, if known. With a cat chosen, the observation also shows on that cat's charts and history.

**Rules:**
- **Time limits:** `occurred_at` can't be more than 2 minutes in the future (clock drift) or more than 7 days ago.
- **Edits:** changing the time, actions or details sets `edited_by` and `edited_at`; the timeline shows "(changed)".
- **Undo:** within 10 seconds, by the member who tapped; sets `undone_at` (kept, hidden from timelines).
- **Double-tap guard:** as in [Decisions](#decisions).
- **Trackers in the timeline:** a tracker the owner logs directly also shows as feeding on the Today timeline (the timeline reads both), so the owner doesn't need to tap "Fed" too.

## The Today page

```
Rita's cats
┌ Upstairs box ─── 🚽 Scooped  ♻️ Full change                    Last: 07:30 by Dad
├ Kitchen fountain 💧 Refilled  🧽 Fountain cleaned  🔄 Filter changed   🧽 Cleaning due today · 🔄 Filter in 6 days
├ Aji ──────────── 🍽 Fed  💊 Meds  ⚖️ Weight                    Fed 08:12 by Mom · Clavamox due 20:00
└ Umi ──────────── 🍽 Fed  ⚖️ Weight                             Fed 08:15 by Mom

Today · Rita's cats
20:02  💊 Aji: Clavamox 1 tablet, given · Mom
19:10  🍽 Umi: fed · Mom · 樂倍 貓罐 · 80 g
12:40  🚽 Upstairs box: scooped · Dad · Aji: soft stool (changed)
08:15  🍽 Umi: fed · Mom
08:12  🍽 Aji: fed · Mom
07:30  💧 Kitchen fountain: refilled, fountain cleaned · Dad
```

- **Rows for each litter box and water spot**, then **one card per cat**, grouped by household when the user belongs to several ("Rita's cats · Ken's cats").
- **Next to each row:** the last time it was done and by whom, or, for a job with a reminder interval, when it's **due** ("Cleaning due today", "Filter in 6 days"). **Meds** show **due**, **given** (by whom, when), **couldn't give** or **overdue** for today's times. The 💊 button is hidden for a cat with no medications.
- **Today's timeline** below: everything recorded today in the household, newest first, with who did it, including the owner's trackers.
- **Viewers** don't use this page; they have their own read-only [viewer page](#viewer-links-and-the-viewer-page) with the same status and timeline, plus charts.
- Works in the browser, the installable web app and the Android app (Hotwire Native; a `:native` variant if the layout needs it). Caregivers land here after sign-in.

## Litter boxes and water spots

- Every household gets **one litter box ("Litter box") and one water bowl ("Water bowl")** automatically, so a one-box home never sets anything up.
- The owner can **add, rename, reorder or remove** them in the household settings, and choose bowl or fountain for each water spot.
- **Removing** one archives it: it disappears from the Today page, and past records still show its name.

## Medications

1. The **owner** adds a medication to a cat: name, dose ("1 tablet", "0.5 ml"), times (08:00 and 20:00) or **as needed**, start and end dates.
2. The cat's card shows each dose for today: **due**, **given**, **couldn't give** or **overdue**.
3. **Tap 💊** → "Give Aji 1 tablet Clavamox (20:00 dose)?" → **Given** or **Couldn't give** with a reason. Saved now, with Change time and Undo.
4. **Double-dose guard:** "Mom gave the 20:00 dose at 19:55".
5. A cat with no medications has no 💊 button; the owner can still add a one-off "Gave medicine" with a name and dose.

## Caregiver invitations and members

1. The owner enters the caregiver's email.
2. The caregiver gets an email with a link: random token stored as a digest, **single use**, expires in **7 days**, only for that email address.
3. The link opens a **join page**:
   ```
   ┌──────────────────────────────────────────────┐
   │  🐾 Rita invited you to help with            │
   │     Aji and Umi, as a caregiver              │
   │                                              │
   │  Email      mom@example.com   (from invite)  │
   │  Your name  [ Mom            ]               │
   │  Password   [ ••••••••       ]               │
   │             [ Join Rita's household ]        │
   │                                              │
   │  or  [G Continue with Google]  [LINE]        │
   │                                              │
   │  Already have an account? Sign in            │
   └──────────────────────────────────────────────┘
   ```
   The email is prefilled and fixed; the time zone is detected, as sign-up already does. Someone who already has an account signs in and gains this household.
4. After joining, the caregiver lands on the **Today page**, not the "Add A Cat" page that every first sign-in shows today (see [Where people land](#where-people-land-after-signing-in)). Their menu is smaller: **Today · Trackers (read-only) · Charts · Account**, with no food bags, health checks, vet visits or kibble prices. "Add my own cat" is under Account (see [People in several households](#people-in-several-households)).
5. The owner can remove a caregiver; caregivers can leave.

## Viewer links and the viewer page

1. The owner adds a viewer by **name** ("Grandma") and optionally an expiry date, and gets a **personal link** to send by LINE or email.
2. The link opens the **viewer page**, with no sign-in and no app menu:
   ```
   ┌──────────────────────────────────────────────────────┐
   │ 🐾 Rita's cats · shared with Grandma                 │
   ├──────────────────────────────────────────────────────┤
   │ Litter box      last scooped 07:30 by Dad            │
   │ Kitchen fountain  refilled 07:30 · cleaning due today│
   │ Aji   fed 08:12 by Mom · Clavamox given 20:02        │
   │ Umi   fed 19:10 by Mom                               │
   ├──────────────────────────────────────────────────────┤
   │ Today                                                │
   │ 20:02  💊 Aji: Clavamox, given · Mom                 │
   │ 19:10  🍽 Umi: fed · Mom · 80 g                      │
   │ 12:40  🚽 Upstairs box: scooped · Dad                │
   ├──────────────────────────────────────────────────────┤
   │ Charts   [Aji ▾]  [7 days ▾]                         │
   ├──────────────────────────────────────────────────────┤
   │ Want to see all the cats you follow in one place?    │
   │ Sign up or sign in                                   │
   └──────────────────────────────────────────────────────┘
   ```
3. **Sign up or sign in** from the page adds the household to the viewer's account as a viewer membership, so it appears with any other households they follow. The link keeps working too.
4. The owner sees each viewer link with its name and when it was last used, and can **turn it off** (it stops working immediately) or change its expiry.
5. **Safety:** a long random token stored only as a digest; turned-off and expired links show "This link is no longer active"; the page is marked not to be indexed by search engines; it never shows health checks, vet visits, notes, kibble prices or anyone's email; each viewer link is separate from the pet's existing public share link.

## Where people land after signing in

Today the rule is "first sign-in → Add A Cat; after that → the pet list". It becomes a rule about what the person has:

| Person | Lands on |
|---|---|
| New user who signed up on their own (no invitation, no household) | **"Add A Cat"**, as today: they're starting their own household |
| Owner (only their own cats) | The pet list, as today |
| Caregiver (joined through an invitation), even on the first sign-in | **Today** |
| Owner who is also a caregiver or viewer elsewhere | **Today**, showing all their households |
| Viewer with a link | Doesn't sign in; the link opens the viewer page |

## People in several households

Example: **Mom** is a caregiver for Rita's cats (Aji, Umi), then adds her own cat **Kuro** with "Add my own cat".

**Before Kuro (caregiver only):**
- Menu: **Today · Trackers · Charts · Account** (trackers and charts read-only).
- Account page: name, email, password, time zone, LINE; reminders on/off per household; **Households**: "Rita's cats · caregiver [Leave]"; and **🐱 Add my own cat**, with *"This creates your own household. Rita's cats are not affected."*

**After Kuro (owner of her own household, caregiver in Rita's):**
- "Add my own cat" opens the normal Add a cat form. Saving it creates **Mom's household** with her as owner, one litter box and one water bowl.
- Menu: the full owner menu, **Today · My cats · Trackers · Charts · Dry food · Health · Vet visits · Account**, because she now owns cats.
- Account page: "Add my own cat" is gone (a user owns at most one household); **My household** (invite caregivers, viewer links, transfer ownership) and **Rita's cats · caregiver [Leave]**.
- Rita's household is unaffected: Rita still owns it, and Mom's rights there don't change.

**Each page works per household, with the person's own role in each:**

| Page | Kuro (Mom's own) | Aji and Umi (Rita's) |
|---|---|---|
| Today | Buttons, as owner | Buttons, as caregiver |
| My cats, Health, Vet visits, Kibble prices | ✅ Kuro only | Not shown |
| Trackers | Full (add, edit) | Read-only |
| Charts | ✅ | ✅ read-only |
| Food bags | Mom's bags, for Kuro | Rita's bags, read-only, only as suggestions when recording "Fed" for Aji or Umi |
| Owner-only emails (kibble prices, backups) | Sent to Mom, for Kuro | Not sent to Mom (Rita gets them) |

**Today page:** her own household first, then the others:
```
Today
── My cats ─────────────────────────────────────────────
Litter box        🚽 Scooped  ♻️ Full change
Water bowl        💧 Refilled  🧽 Cleaned
Kuro  🍽 Fed  💊 Meds  ⚖️ Weight
── Rita's cats (you're a caregiver) ───────────────────
Upstairs box      🚽 Scooped  ♻️ Full change   07:30 Dad
Aji   🍽 Fed  💊 Meds  ⚖️ Weight              Clavamox due 20:00
Umi   🍽 Fed  ⚖️ Weight
```

**Cat lists on other pages** are grouped by household, with the role shown:
```
Trackers ▾
  My cats
    Kuro
  Rita's cats (read-only)
    Aji
    Umi
```

## Keeping households apart

**For the person: the tap says which cat.** Every button sits on one cat's card or one litter box or water spot row. Tapping 🍽 on Kuro's card means "Kuro was fed"; on Aji's card, "Aji was fed". There is no household to choose. Pages that are per cat (trackers, charts) are reached by choosing a cat from the grouped list, as today, and the household follows from the cat.

**Suggestions come from the cat's household:** "Add details" → kibble on **Kuro** lists **Mom's** bags; on **Aji**, **Rita's** bags. A mixed list never appears.

**For the data: the server checks every save**, so even a tampered request can't mix households:

| Check | Refused if |
|---|---|
| The record's household | It isn't the household of the cat, litter box or water spot; the server sets it and never accepts it from the form |
| The person's permission | They aren't the owner or a caregiver **of that household** |
| A food bag on a feeding or tracker | The bag belongs to a different household from the cat (today's rule "bag of the pet's owner" becomes "bag of the pet's household") |
| A litter box or water spot | It belongs to a different household |
| A medication | It belongs to a different cat |
| "Add to trackers" | The care event's cat isn't in the owner's own household |

## Transfer ownership

1. The owner picks a **member** of the household and confirms.
2. The member gets an email and an in-app prompt, and **accepts** (single-use link, expires in 7 days).
3. On acceptance, in one transaction: the member becomes the owner (their membership row is removed); the **former owner becomes a caregiver** (they can then leave). Cats, food bags, litter boxes, water spots, trackers, care events, health records and vet visits all stay with the household.
4. The new owner must not already own a household (a user owns at most one). If they do, the transfer is refused with an explanation.
5. **Deleting an account** that owns a household with cats first asks: transfer to a member, or delete the household and its cats (as happens today).
6. After a transfer, owner-only emails (kibble prices, backups) go to the new owner.

## Reminders (checkpoint H, then I for the Android app)

**Setting it up (owner):** in each water spot's or litter box's settings, one line per job:
```
Kitchen fountain
  🧽 Fountain cleaned   every  [Twice a week ▾]   (every 4 days)
  🔄 Filter changed     every  [Twice a month ▾]  (every 15 days)
  💧 Refilled           every  [Off ▾]
```
Choices and their day counts: twice a week (4 days), weekly (7), every 2 weeks (14), twice a month (15), monthly (30), or custom (every N days). Medications need no setup: their schedule already says when a dose is due.

**When it's due:**
- **Due = the latest record with that action + the interval.** Cleaned Monday with "twice a week" (4 days) → due Friday. Cleaned again early on Wednesday → due moves to Sunday.
- Never recorded yet → counted from the day the interval was set.
- Recording the job (one tap on the Today page) resets the countdown.

**Sending:**
- An hourly job (Solid Queue, like the existing scheduled jobs) finds routines that are due for members whose local time has reached **9am**, and sends each reminder **once**: "🧽 Kitchen fountain might be time to clean. Last cleaned Monday by Dad."
- If it's still not done **2 days** later, **one follow-up**, then nothing more until someone records it.
- Meds: "💊 Aji's 20:00 Clavamox hasn't been recorded" shortly after the dose time (e.g. 1 hour), once.
- The job remembers what it sent for each due date, so a restart or a second run never sends twice.
- **Who:** the owner and caregivers who have reminders on (a switch per member per household). Never viewers.

**Channels, one per member per reminder:**
1. **Android app** (checkpoint I), if the member has the app installed, signed in, and notifications allowed.
2. Else **LINE**, if they signed in with LINE (the app already sends LINE pushes for weight reminders).
3. Else **email**.

Tapping the notification or the link opens the **Today page**, where one tap records the job.

## Android app push notifications (checkpoint I)

The Android app (`pet_tracker_android/`, Hotwire Native) has **no Firebase or notification setup yet**; it only asks for internet access. It already opens `pet-feeding-tracker-v4.up.railway.app` links inside the app, which a notification can use to open the Today page.

**In the Android app:**
- Add the **Firebase Cloud Messaging** SDK and the Firebase project's `google-services.json` (from the Firebase console).
- Ask for the **notification permission** (required on Android 13+, which `targetSdk 35` covers) at a sensible moment: when the user turns reminders on, not at first launch.
- After sign-in, send the device's **FCM token** to the server; send it again when Firebase rotates it. Remove it on sign-out.
- Tapping a notification opens the Today page URL in the app.

**On the server:**
- A `device_tokens` table: user, platform (`android`), token, last used.
- Sending through the **FCM HTTP v1 API** with a Firebase service account (its key in credentials or an environment variable, never in git).
- A token that FCM reports as no longer valid is deleted, and that member falls back to LINE or email.
- An endpoint for the app to register and remove its token, for the signed-in user only.

**Also needed:** a Firebase project for the app (the free tier is enough for this volume), with the app's package name `com.pettracker.v4` registered in it.

## Live updates (checkpoint G)

- A tap broadcasts the new event to the household with **Turbo Streams over Solid Cable**, which production already runs (`config/cable.yml`), so other members' Today pages, including viewers', update without reloading.
- Care events appear on the **charts** (markers for litter, water and meds; litter observations with a cat on that cat's chart), and in the owner's CSV export.

## Build order and checkpoints

| # | Build | Checkpoint |
|---|---|---|
| 0 | Decisions | ✅ Done |
| A | `households`, `household_memberships`, `care_spots` (one box, one bowl each), `pets.household_id`, `dry_foods.household_id`; data migration | ✅ Done — existing tests unchanged; migration and rollback checked on PostgreSQL; every current user with pets or bags owns one household with them, a litter box and a water bowl |
| B | `Pet.accessible_by`, `HouseholdPolicy`; replace every lookup listed above; food-bag rule by household; jobs, mailers and brand names via the household's owner | ✅ Done — role × page matrix (owner, caregiver, viewer, outsider on 22 pages and actions); all existing tests unchanged |
| C | ✅ Done — Caregiver invitations and the join page (prefilled email, Google / LINE); the new landing rules (caregivers and people in several households land on Today; new users with no household still get "Add A Cat"); "Add my own cat" under Account; menus and cat lists grouped by household; the caregiver menu; viewer links (create, name, expiry, turn off) and the viewer page with charts; member list, removing, leaving; transfer ownership; account deletion asks to transfer | Invite → join → caregiver role applies; expired, reused and wrong-email invitations refused; a viewer link opens only its household's viewer page, and stops at once when turned off or expired; signing in from a viewer link adds a viewer membership; transfer swaps owner and caregiver in one transaction |
| D | ✅ Done — `care_events`; Today page with litter-box and water-spot rows and cat cards; one-tap fed, scooped, full change, refilled, cleaned, filter changed (several actions in one record, with checkboxes in the notice); weight form; change time; feeding "Add details" with suggestions by food type; "Add to trackers"; undo; double-tap guard; status and today's timeline on the viewer page; managing boxes and water spots | Browser test: caregiver taps Fed and adds details, refills and cleans the fountain in one record, changes a time, undoes a tap; owner adds a feeding to trackers; the viewer link shows the new records with no buttons; tests that every save refuses a household mismatch (record, food bag, box, water spot, medication) and a person without rights in that household |
| E | ✅ Done — `medications`; meds button with Given / Couldn't give; due / given / overdue | Doses shown per schedule; double dose guarded |
| F | ✅ Done — Litter observations in "Add details" (optional fields; which cat) | Old records unchanged; observations show on the timeline and, with a cat, in that cat's history |
| G | ✅ Done — Turbo Streams broadcast (Today pages and viewer pages); care events on charts and in CSV | Two browser sessions: a tap in one appears in the other, including on a viewer page |
| H | ✅ Done — `care_routines`, `care_reminders`; interval settings per spot and job; "due" on the Today page; hourly reminder job; LINE, else email; per-member on/off; overdue meds | A due routine is sent once at 9am local time, one follow-up 2 days later, none after it's recorded; viewers never get one; doing the job early moves the due date |
| H2 | ✅ Done — Per job, the owner picks **A. every …** (now also in hours: 3 times a day, twice a day, daily, custom) or **B. at set times** (up to 6); due times and reminders for both; "3× today" and set-time statuses on the Today row; the litter double-tap guard at 30 minutes | A: "Twice a day", scooped at 08:00, due and reminded at 20:00; scooped at 15:00 instead, due 03:00, reminded at 9am. B: 08:00 and 20:00, a scoop at 19:40 covers 20:00, an uncovered 20:00 is reminded once at 20:00 with one follow-up at 22:00. Existing day intervals unchanged |
| H3 | ✅ Done — **Delete** on timeline entries and the details page (owner any record, caregiver their own for 24 hours), with a confirmation; hidden like Undo with who deleted it; a linked tracker unlinked | An accidental "Fed" deleted by the caregiver who tapped it disappears from everyone's Today, the charts, the CSV and reminders; another caregiver's record and viewers refused |
| I | Firebase in the Android app (FCM SDK, notification permission, token registration); `device_tokens`; sending through FCM HTTP v1; fallback to LINE or email | A reminder arrives as an Android notification and opens the Today page; an invalid token falls back to LINE or email |
| J | Remove `pets.user_id` / `dry_foods.user_id`; docs (README, ARCHITECTURE, USAGE) | CI green; merged into `main` when you ask |

## Risks

| Risk | How it's handled |
|---|---|
| **Access checks change on every page** (checkpoint B) | One policy used everywhere; a role × page test matrix; single-member households behave exactly as today |
| Data migration on production | Additive columns first, backfilled by a migration tested on PostgreSQL; old `user_id` columns removed only in J |
| Caregivers or viewers seeing private data | Health checks, vet visits, kibble prices, the Gemini API key, the share link and owner emails stay owner-only; viewers see charts and today's timeline only |
| Owner leaves or deletes their account | Transfer ownership; account deletion asks to transfer first |
| Invitation or transfer links forwarded | Single use, 7-day expiry, bound to the invited email / chosen member (a transfer is accepted only by that member, signed in) |
| Invitation tokens in the job queue | The token is an argument of the email job, so it sits in the queue table until cleanup; it's single use, expires in 7 days and works only for the invited email |
| Viewer link forwarded | One link per viewer, turned off by the owner at any time, optional expiry; read-only; shows no private data; not indexed by search engines |
| New caregivers sent to "Add A Cat" | Landing depends on what the person has: caregivers land on Today; only a new user with no household gets "Add A Cat" |
| Records ending up in the wrong household | No household picker; the server sets the household from the cat, box or spot and refuses any mismatch (see [Keeping households apart](#keeping-households-apart)) |
| Double feeding / double doses | Live timeline, double-tap guard, meds confirmation |
| Wrong times | "Now" by default (entries are made within 10 minutes), quick picks, 7-day limit, edits shown |
| Details added in a later checkpoint | Optional fields from the start; older records simply have none |
| Inconsistent food names from caregivers | Suggestions by food type from the household's bags and the cat's favorites |
| Too many reminders | Once per due date plus one follow-up; 9am local time; per-member switch; one channel per member |
| Push setup secrets | Firebase service-account key only in credentials or an environment variable; device tokens tied to the signed-in user and removed on sign-out |
| Android notification permission refused | Reminders fall back to LINE or email |
| Kibble price check | Unchanged; it keeps using the owner's trackers and favorites. Brand names and the email come from the household's owner in B |

## Change log

- **H3 follow-up (2026-10-02):** the Today and viewer timeline shows the **last 24 hours** instead of stopping at midnight, so a late-night tap can still be changed or deleted the next morning.
- **Checkpoints H2 and H3 (2026-10-02):** reminders per job either **every …** (hours or days) or **at set times** (up to 6), with set-time statuses, due times and "N× today" on the Today row, and the litter "Record it again?" question after 30 minutes; **Delete** for a mistaken record (owner any, caregiver their own for 24 hours), hidden everywhere with who deleted it.
- **v8 (2026-10-02):** planned **H3**: a **Delete** button on today's records (and the details page) for the owner (any record) and caregivers (their own, for 24 hours), with a confirmation, for taps made by mistake; the record is hidden everywhere, and a feeding added to trackers leaves the tracker in place.
- **v7 (2026-10-01):** planned **H2**: litter boxes scooped several times a day. Per job the owner picks **every …** (now also 3 times a day, twice a day, daily or custom hours, counted from the last time it was done) or **at set times** (up to 6, e.g. 08:00 and 20:00, like medications); every tap still records the actual time and person; "3× today" and set-time statuses on the Today row; the litter "Record it again?" question after 30 minutes instead of 2 hours.

- **Checkpoint H (2026-10-01):** reminder intervals per litter box and water spot job, due dates on Today, each owner's and caregiver's reminders switch, and the hourly job sending due jobs at 9am local time (one follow-up after 2 days) and overdue doses, by LINE or email.
- **Checkpoint G (2026-10-01):** live updates on Today and viewer pages (Solid Cable, with its missing production table added), the saved notice kept open on others' refreshes, ⚖️ weights on the weight line, the "Care by day" chart, and the owner's care records CSV. Fixed the household page's forms overflowing on small screens.
- **Checkpoint F (2026-10-01):** litter observations (which cat, pee, poops, stool, something unusual) on a litter record's details page, on the timeline and viewer page (diarrhea and anything unusual in red), and in the cat's history for 30 days.
- **Checkpoint E (2026-10-01):** medications per cat (owner), 💊 with Given / Couldn't give and a reason, due / given / couldn't give / overdue on Today and the viewer page, the double-dose question, and the owner's one-off medicine.
- **Checkpoint D (2026-09-30):** one-tap care on the Today page (fed, weight, litter, water), undo, quick time changes, water checkboxes, the double-tap guard, today's timeline with trackers, details with suggestions by food type, Add to trackers, status and timeline on the viewer page, and managing litter boxes and water spots. Fixed the viewer link Copy button.
- **Checkpoint C (2026-09-30):** household page (members, invitations, viewer links), join page with Google / LINE, landing rules, a first Today page, grouped and smaller menus, leaving and "Add my own cat", the viewer page with charts, transfer ownership, and account deletion asking to hand over first. Today's buttons and the viewer page's status and timeline come in D.
- **Checkpoint B (2026-09-30):** access by household and role on every page; CSV export and the pet profile are owner-only; refused actions say "Only Aji's owner can do that."
- **Checkpoint A (2026-09-30):** households, memberships and care spots built; existing pets and food bags moved into their owner's household. Names stored empty and shown in each viewer's language; users without pets or bags get a household with their first one.
- **v6 (2026-09-30):** landing after sign-in depends on what the person has (new user with no household → "Add A Cat"; caregivers → Today). Caregivers can create their own household with **"Add my own cat" under Account** ("This creates your own household. Rita's cats are not affected."), becoming owner and caregiver. Pages for someone in several households: owner menu once they own cats, Today grouped by household (own first), cat lists grouped by household with the role shown. **Keeping households apart:** no household picker; the household comes from the cat, box or spot and is set by the server, which refuses any mismatch.
- **v5 (2026-09-29):** caregivers **need an account**, joining through a one-step invitation page (prefilled email, or Google / LINE), landing on Today instead of "Add A Cat", with a smaller menu. Viewers use a **personal link** with no account: a read-only viewer page with status, today's timeline and charts; one link per viewer, revocable, optional expiry; signing in from it adds the household to their account. Invitations are for caregivers only; new `viewer_links` table.
- **v4 (2026-09-29):** water spots use **buttons + checkboxes** (one tap saves; the notice's checkboxes add the other actions to the same record). **Reminders** per spot and job, counted from the last time it was done (twice a week, twice a month, …), once at 9am local time plus one follow-up, to the owner and caregivers who turn them on; meds overdue too. Channels: **LINE, else email (H)**, then **Android app push via Firebase (I)**. Clean-up moves to J.
- **v3 (2026-09-29):** litter and water are shared per litter box or water spot (one of each created automatically; owners add more); water spots are bowls or fountains, fountains with 💧 Refilled · 🧽 Fountain cleaned · 🔄 Filter changed, and several actions in one record; litter 🚽 Scooped · ♻️ Full change; litter observations in a later checkpoint (F), stored as optional fields from the start; optional "which cat" only on observations; "Add details" also on timeline entries; meds "Couldn't give"; viewers see charts and today's timeline read-only; kibble prices owner-only. Checkpoints renumbered (F observations, G live updates, H notifications, I clean-up).
- **v2 (2026-09-29):** one owner per household with transfer ownership; caregivers and viewers can belong to several households; household food bags; caregiver read-only on trackers and charts; owner-only emails; caregiver feeding details with suggestions by food type, saved on the care event, and the owner's "Add to trackers".
- **v1 (2026-09-29):** first plan.
