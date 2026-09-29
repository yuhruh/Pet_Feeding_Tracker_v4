# Households and Caregivers — Implementation Plan (v4)

**Goal:** Let several people look after the same cats. Each **owner** has a **household**: their cats, food bags, litter boxes and water spots, and the people they let help. A **caregiver** records care with **one tap** (fed, litter, water, meds given) and everyone in the household sees it right away. A **viewer** sees the charts and today's timeline, read-only. Caregivers and viewers can belong to **several owners' households**. **Reminders** say when a job "might be time" (clean the fountain, change the filter, give meds), by LINE or email first and later as Android app notifications.

## Status

| Checkpoint | Status |
|---|---|
| 0 — Decisions | ✅ Done (2026-09-29). No open questions |
| A — Households and memberships (no visible change) | Not started |
| B — Access by household and role | Not started |
| C — Invitations, members, transfer ownership | Not started |
| D — Care events and the Today page (fed, litter, water, weight) | Not started |
| E — Medications | Not started |
| F — Litter observations | Not started |
| G — Live updates and care events on the charts | Not started |
| H — Reminders by LINE and email | Not started |
| I — Android app push notifications (Firebase) | Not started |
| J — Clean-up, docs, CI, merge | Not started |

**Commits:** each checkpoint is committed on `feature/households` once `bin/rails test` passes, then pushed. Merged into `main` only when you ask.

## Decisions

| Topic | Decision | Why |
|---|---|---|
| Owners | **Exactly one owner per household.** A user owns at most one household (their own cats) | Matches how the app is used; simpler rules and tests; the email rule stays clear |
| Transfer ownership | **Built in.** The owner can hand the household to one of its members; deleting an account asks to transfer first | Covers the owner leaving or losing access |
| Co-owners | **Not now.** Can be added later without a database change (memberships already store a role) | Not needed yet |
| Caregivers and viewers | **Can belong to several households** (several owners' cats) | A family member helping two households; a pet sitter with several clients; an owner who also checks a friend's cat |
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

## Roles

| | Owner | Caregiver | Viewer |
|---|---|---|---|
| Record care: one-tap buttons, weight | ✅ | ✅ | ❌ |
| **Today's timeline** (see [The Today page](#the-today-page)) | ✅ | ✅ | ✅ **read-only** (no buttons, no change time, add details or undo) |
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
| Invite, change roles, remove members; transfer ownership | ✅ | ❌ | ❌ |
| Public share link | ✅ | ❌ | ❌ |
| Leave the household | — (transfer first) | ✅ | ✅ |

The existing **public share link** and **vet-visit members** keep working as they do today.

**Access rule:** "pets in the user's own household or in households where they are a member, allowed by their role". One place decides it, e.g. `Pet.accessible_by(user)` and a small policy object (`HouseholdPolicy.new(user, household).can?(:record_care)`), used by every controller instead of `Current.user.pets`. A pet the user may not see stays "not found", as today (ARCHITECTURE.md §4.5).

## Example

```
Rita's household (owner: Rita)              Ken's household (owner: Ken)
  cats: Aji, Umi                              cats: Mochi
  litter boxes: Upstairs box, Bathroom box    litter boxes: Litter box
  water: Kitchen fountain                     water: Water bowl
  caregiver: Mom                              caregiver: Mom
  viewer: Grandma                             viewer: Rita
```

Mom's Today page shows both households ("Rita's cats · Ken's cats") with buttons. Grandma sees Rita's charts and today's timeline, read-only. Rita sees her own cats fully, and Mochi's charts and today's timeline.

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
household_invitations   household_id, email, role, token_digest, invited_by_id, expires_at,
                        accepted_at, timestamps
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
- **Viewers** see the same page **without any buttons or links** (no change time, add details or undo): just the last-done times and today's timeline.
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

## Invitations and members

1. The owner enters an email and picks **caregiver** or **viewer**.
2. The invitee gets an email with a link: random token stored as a digest, **single use**, expires in **7 days**, only for that email address.
3. They sign up or sign in (email, Google, LINE or GitHub) and join with that role. Someone already in other households just gains this one.
4. The owner can change a member's role or remove them; members can leave.

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
| A | `households`, `household_memberships`, `care_spots` (one box, one bowl each), `pets.household_id`, `dry_foods.household_id`; data migration | All existing tests pass unchanged; migration checked on PostgreSQL; every current user owns one household with their pets, bags, a litter box and a water bowl |
| B | `Pet.accessible_by`, `HouseholdPolicy`; replace every lookup listed above; food-bag rule by household; jobs, mailers and brand names via the household's owner | A test matrix of **each role on each page** (allowed and refused); single-member households behave exactly as today |
| C | Invitations, member list, role changes, leaving; transfer ownership; account deletion asks to transfer | Invite → accept → role applies; expired, reused and wrong-email links refused; transfer swaps owner and caregiver in one transaction |
| D | `care_events`; Today page with litter-box and water-spot rows and cat cards; one-tap fed, scooped, full change, refilled, cleaned, filter changed (several actions in one record, with checkboxes in the notice); weight form; change time; feeding "Add details" with suggestions by food type; "Add to trackers"; undo; double-tap guard; viewers' read-only Today page; managing boxes and water spots | Browser test: caregiver taps Fed and adds details, refills and cleans the fountain in one record, changes a time, undoes a tap; owner adds a feeding to trackers; viewer sees the timeline with no buttons |
| E | `medications`; meds button with Given / Couldn't give; due / given / overdue | Doses shown per schedule; double dose guarded |
| F | Litter observations in "Add details" (optional fields; which cat) | Old records unchanged; observations show on the timeline and, with a cat, in that cat's history |
| G | Turbo Streams broadcast; care events on charts and in CSV | Two browser sessions: a tap in one appears in the other, including a viewer's |
| H | `care_routines`, `care_reminders`; interval settings per spot and job; "due" on the Today page; hourly reminder job; LINE, else email; per-member on/off; overdue meds | A due routine is sent once at 9am local time, one follow-up 2 days later, none after it's recorded; viewers never get one; doing the job early moves the due date |
| I | Firebase in the Android app (FCM SDK, notification permission, token registration); `device_tokens`; sending through FCM HTTP v1; fallback to LINE or email | A reminder arrives as an Android notification and opens the Today page; an invalid token falls back to LINE or email |
| J | Remove `pets.user_id` / `dry_foods.user_id`; docs (README, ARCHITECTURE, USAGE) | CI green; merged into `main` when you ask |

## Risks

| Risk | How it's handled |
|---|---|
| **Access checks change on every page** (checkpoint B) | One policy used everywhere; a role × page test matrix; single-member households behave exactly as today |
| Data migration on production | Additive columns first, backfilled by a migration tested on PostgreSQL; old `user_id` columns removed only in J |
| Caregivers or viewers seeing private data | Health checks, vet visits, kibble prices, the Gemini API key, the share link and owner emails stay owner-only; viewers see charts and today's timeline only |
| Owner leaves or deletes their account | Transfer ownership; account deletion asks to transfer first |
| Invitation or transfer links forwarded | Single use, 7-day expiry, bound to the invited email / chosen member |
| Double feeding / double doses | Live timeline, double-tap guard, meds confirmation |
| Wrong times | "Now" by default (entries are made within 10 minutes), quick picks, 7-day limit, edits shown |
| Details added in a later checkpoint | Optional fields from the start; older records simply have none |
| Inconsistent food names from caregivers | Suggestions by food type from the household's bags and the cat's favorites |
| Too many reminders | Once per due date plus one follow-up; 9am local time; per-member switch; one channel per member |
| Push setup secrets | Firebase service-account key only in credentials or an environment variable; device tokens tied to the signed-in user and removed on sign-out |
| Android notification permission refused | Reminders fall back to LINE or email |
| Kibble price check | Unchanged; it keeps using the owner's trackers and favorites. Brand names and the email come from the household's owner in B |

## Change log

- **v4 (2026-09-29):** water spots use **buttons + checkboxes** (one tap saves; the notice's checkboxes add the other actions to the same record). **Reminders** per spot and job, counted from the last time it was done (twice a week, twice a month, …), once at 9am local time plus one follow-up, to the owner and caregivers who turn them on; meds overdue too. Channels: **LINE, else email (H)**, then **Android app push via Firebase (I)**. Clean-up moves to J.
- **v3 (2026-09-29):** litter and water are shared per litter box or water spot (one of each created automatically; owners add more); water spots are bowls or fountains, fountains with 💧 Refilled · 🧽 Fountain cleaned · 🔄 Filter changed, and several actions in one record; litter 🚽 Scooped · ♻️ Full change; litter observations in a later checkpoint (F), stored as optional fields from the start; optional "which cat" only on observations; "Add details" also on timeline entries; meds "Couldn't give"; viewers see charts and today's timeline read-only; kibble prices owner-only. Checkpoints renumbered (F observations, G live updates, H notifications, I clean-up).
- **v2 (2026-09-29):** one owner per household with transfer ownership; caregivers and viewers can belong to several households; household food bags; caregiver read-only on trackers and charts; owner-only emails; caregiver feeding details with suggestions by food type, saved on the care event, and the owner's "Add to trackers".
- **v1 (2026-09-29):** first plan.
