# Households and Caregivers — Implementation Plan (v1)

**Goal:** Let several people look after the same cats. A **household** owns the cats; its **members** have roles. A new **caregiver** role can record care with **one tap** (fed, litter, water, meds given), and everyone in the household sees it right away.

## Status

| Checkpoint | Status |
|---|---|
| 0 — Open questions answered | ⏳ Waiting for you (see [Open questions](#open-questions)) |
| A — Households and memberships (no visible change) | Not started |
| B — Access by household and role | Not started |
| C — Invitations and member management | Not started |
| D — Care events and the Today page (fed, litter, water) | Not started |
| E — Medications | Not started |
| F — Live updates and the timeline elsewhere | Not started |
| G — Notifications (optional) | Not started |
| H — Docs, tests, CI, merge | Not started |

**Commits:** each checkpoint is committed on `feature/households` once `bin/rails test` passes, then pushed.

## Decisions (made 2026-09-28/29)

| Topic | Decision | Why |
|---|---|---|
| Who owns cats | A **household**, not a single user | Several people care for the same cats |
| Roles | **Owner**, **caregiver**, **viewer** | Owners manage everything; caregivers record care; viewers only look |
| Recording care | **Option A: one tap saves "now"** | Production trackers are entered within 10 minutes of feeding, so "now" is accurate. One tap for the usual case, a saved record others see at once, nothing lost if the caregiver is interrupted |
| Changing the time | **"Change time"** link in the saved notice and on each timeline entry, with quick picks **5 · 10 · 15 min ago** and a full picker | Rarely needed; quick picks match the 10-minute pattern |
| Option B ("ask for the time before saving") | **Not built** | The data doesn't call for it; one fewer setting. Can be added if someone asks |
| Undo | **10 seconds** after a tap | Fixes accidental taps |
| Double-tap guard | "Mom fed Aji at 08:05; record again?" when the same care was recorded for that cat recently | Prevents double feeding and double doses between members |
| Meds | One tap **plus a short confirmation** ("Give Aji 1 tablet Clavamox?") | A wrong "given" record could mean a missed real dose |
| Time storage | One timestamp, `occurred_at` (UTC), shown in the user's time zone | Avoids the date + time-of-day handling trackers need (ARCHITECTURE.md §1.7) |
| Detailed feeding | **Stays in `trackers`** | The favorite score, charts, food bags and kibble prices depend on it |
| Kibble price tracker | **Unchanged** | Decided 2026-09-29: keep it as it is (the BigGo momo filter is not added) |

## What the app has today

| Area | Today | This plan |
|---|---|---|
| Ownership | `pets.user_id`: one owner per cat | `pets.household_id` |
| Sharing | A public read-only link per pet; members on a single vet visit | Household members with roles. The public link and vet-visit members stay as they are |
| Feeding | Detailed `trackers` | Unchanged, plus a one-tap "fed" care event |
| Litter, water, meds | None | Care events; medications with schedules |
| Who did it | Not recorded | Every care event records the member |
| Weight | A column on trackers and pets | Also a "weight" care event (a small form, as it needs a number) |

**Where the code assumes one owner** (all change in checkpoint B):
- `Current.user.pets…` in `PetsController`, `TrackersController`, `HealthChecksController`, `PetSharesController`, `KibblePricesController`, and in `layouts/_navigation.html.erb` and `users/show.html.erb`.
- `@pet.user == Current.user` in `VetVisitsController` (owner vs. vet-visit member).
- `Current.user.dry_foods…` in `DryFoodsController`, and `Tracker#dry_food_belongs_to_pet_owner` (a tracker may only use a bag owned by the pet's owner).
- User → pets in jobs and services: `UserBackupJob`, `PetWeightReminderJob` / `notifications:weigh_pets`, `KibblePrices::BrandNames.for_user`, `KibblePriceMailer` (emails `pet.user`).

## Data model

```
households              id, name, timestamps
household_memberships   household_id, user_id, role (owner · caregiver · viewer), timestamps
                        unique (household_id, user_id)
household_invitations   household_id, email, role, token_digest, invited_by_id, expires_at,
                        accepted_at, timestamps
pets                    + household_id (NOT NULL once filled); user_id kept until checkpoint H
dry_foods               + household_id (see open question 1); user_id kept until checkpoint H
care_events             pet_id, household_id, actor_id → users, kind, occurred_at,
                        medication_id (meds only), value (weight kg), note,
                        edited_by_id, edited_at, undone_at, timestamps
                        index (pet_id, kind, occurred_at)
                        kind: fed · litter · water · meds · weight
medications             pet_id, name, dose (text, e.g. "1 tablet"), times (e.g. ["08:00", "20:00"]),
                        starts_on, ends_on, active, timestamps
```

**Moving existing data (checkpoint A):** one migration creates a household for every user who has pets ("Rita's household"), makes that user its **owner**, and sets `household_id` on their pets (and food bags). Nothing changes for current users: they are the only member of their household. The migration is checked on a throwaway PostgreSQL database first, as in the kibble price work.

## Roles

| | Owner | Caregiver | Viewer |
|---|---|---|---|
| Today page: one-tap fed / litter / water / meds | ✅ | ✅ | ❌ (sees the timeline) |
| Change the time of a care event | Any event | **Own events, within 24 hours** | ❌ |
| Undo (10 s) | Own taps | Own taps | ❌ |
| Trackers, charts, favorite list, kibble prices | ✅ | See [open question 2](#open-questions) | Read-only |
| Health checks, vet visits | ✅ | ❌ | ❌ |
| Food bags | ✅ | Read-only | ❌ |
| Edit cats, medications; invite and remove members | ✅ | ❌ | ❌ |
| Public share link | ✅ | ❌ | ❌ |

A household can have **more than one owner**. It must always keep at least one.

**Access rule:** "pets in the user's households, allowed by the user's role". One place decides it, e.g. `Pet.accessible_by(user)` and a small policy object (`HouseholdPolicy.new(user, pet).can?(:record_care)`), used by every controller instead of `Current.user.pets`. Anyone else's pet stays "not found", as today (§4.5 of ARCHITECTURE.md).

## Care events

**Recording (Option A):**
1. The caregiver taps **🍽 Fed** on Aji's card.
2. The server saves a care event with `occurred_at = now`, the tapping member as `actor`.
3. A notice appears: `✔ Fed Aji · 08:12  [Change time]  [Undo]`.
4. The household's timelines update ("Fed 08:12 by Mom").

**Rules:**
- **Time limits:** `occurred_at` can't be more than 2 minutes in the future (clock drift) or more than 7 days ago.
- **Edits:** changing the time sets `edited_by` and `edited_at`; the timeline shows "(time changed)".
- **Undo:** within 10 seconds, by the member who tapped; sets `undone_at` (kept for the record, hidden from timelines).
- **Double-tap guard:** if the same kind of care for the same cat was recorded within **30 minutes** (fed, water) or **2 hours** (litter), the tap asks first: "Mom fed Aji at 08:05; record again?". For meds, the guard uses the medication's schedule: a dose already given in the current time slot.
- **Weight** is a small form (a number, with "now" prefilled), not one tap.
- **Trackers and care events:** a detailed tracker counts as feeding in the Today timeline (the timeline reads both), so an owner who logs a full tracker doesn't also need to tap "Fed".

## The Today page

- **One card per cat** in the household: photo, name, and buttons **🍽 Fed · 🚽 Litter · 💧 Water · 💊 Meds · ⚖️ Weight**.
- **Under the buttons:** the last time of each ("Fed 08:12 by Mom · Litter 07:30 by Dad · Water yesterday 21:00 by Rita").
- **Meds:** each active medication shows **due**, **given** (by whom, when) or **overdue** for today's times.
- **A day timeline** below, newest first, including trackers.
- Works in the browser, the installable web app and the Android app (Hotwire Native; a `:native` variant if the layout needs it). It becomes the landing page for caregivers after sign-in.

## Invitations

1. An owner enters an email and picks a role.
2. The invitee gets an email with a link (random token, stored as a digest, **single use**, expires in **7 days**, only for that email address).
3. They sign up or sign in (email, Google, LINE or GitHub) and join the household with that role.
4. Owners can change a member's role or remove them; members can leave. The last owner can't leave or be demoted.

This follows the existing vet-visit member pattern, but with an invitation, as the invitee may not have an account yet.

## Live updates (checkpoint F)

- A tap broadcasts the new event to the household with **Turbo Streams over Solid Cable**, which production already runs (`config/cable.yml`), so other members' Today pages update without reloading.
- Care events also appear on the tracker charts page (e.g. markers for litter and meds) and in the CSV export.

## Notifications (checkpoint G, optional)

Using the existing `NotificationService` (LINE push or email):
- "Meds overdue for Aji (due 09:00)" to caregivers and owners.
- "No litter logged for Aji in 2 days".
- A daily summary for owners who want one.

## Build order and checkpoints

| # | Build | Checkpoint |
|---|---|---|
| 0 | — | You answer the open questions |
| A | `households`, `household_memberships`, `pets.household_id`, `dry_foods.household_id`; data migration | All existing tests pass unchanged; migration checked on PostgreSQL; every current user owns one household with their pets |
| B | `Pet.accessible_by`, `HouseholdPolicy`; replace every lookup listed above; jobs, mailers and brand names by household | Tests for **each role on each page** (allowed and refused); existing behavior unchanged for single-member households |
| C | Invitations, member list, role changes | Invite → accept → role applies; expired, reused and wrong-email links refused |
| D | `care_events`; Today page; one-tap fed, litter, water; weight form; change time; undo; double-tap guard | Browser test: caregiver taps Fed, changes the time, undoes; owner sees it; viewer can't tap |
| E | `medications`; meds button with confirmation; due / given / overdue | Doses shown per schedule; double dose guarded |
| F | Turbo Streams broadcast; care events on charts and in CSV | Two browser sessions: a tap in one appears in the other |
| G | Reminders (optional) | Overdue meds and missing litter reminders sent once |
| H | Remove `pets.user_id` / `dry_foods.user_id`; docs (README, ARCHITECTURE, USAGE) | CI green; merged into `main` |

## Risks

| Risk | How it's handled |
|---|---|
| **Access checks change on every page** (checkpoint B) | One policy used everywhere; a test matrix of role × page; single-member households behave exactly as today |
| Data migration on production | Additive columns first, backfilled by a migration tested on PostgreSQL; old `user_id` columns removed only in H |
| Caregivers seeing private data | Health checks, vet visits, the Gemini API key and the share link stay owner-only |
| Invitation links forwarded | Single use, 7-day expiry, bound to the invited email |
| Double feeding / double doses | Live timeline, double-tap guard, meds confirmation |
| Wrong times | "Now" by default (entries are made within 10 minutes), quick picks, 7-day limit, edits shown |
| Kibble price check | Unchanged; it keeps using the pet's favorites. Brand names and the email move from "the user" to "the household's owners" in B |

## Open questions

1. **Food bags:** should bags belong to the **household** (everyone feeds from the same bags) or stay with each **user**? *Recommended: household*, since caregivers feed from the same bags and trackers already link to them.
2. **Caregivers and trackers:** can a caregiver **see** trackers, charts and the favorite list (read-only), or only the Today page? *Recommended: read-only.*
3. **Viewer role:** keep it, or start with owner and caregiver only? *Recommended: keep it*; it's small, and useful for family who only want to check in.
4. **Emails:** the monthly kibble price email and backups go to **every owner**, or only the household's first owner? *Recommended: every owner.*
5. **One household per user,** or can a user belong to several (e.g. their own cats plus a friend's while pet-sitting)? *Recommended: several.* It costs a household switcher on the Today page, but it's what pet-sitting needs.
