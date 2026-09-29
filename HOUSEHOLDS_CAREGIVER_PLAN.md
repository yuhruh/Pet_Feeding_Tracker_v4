# Households and Caregivers — Implementation Plan (v2)

**Goal:** Let several people look after the same cats. Each **owner** has a **household**: their cats, their food bags, and the people they let help. A **caregiver** records care with **one tap** (fed, litter, water, meds given) and everyone in the household sees it right away. A **viewer** only looks at the charts. Caregivers and viewers can belong to **several owners' households**.

## Status

| Checkpoint | Status |
|---|---|
| 0 — Decisions | ✅ Done (2026-09-29), except [one open question](#open-question) |
| A — Households and memberships (no visible change) | Not started |
| B — Access by household and role | Not started |
| C — Invitations, members, transfer ownership | Not started |
| D — Care events and the Today page (fed, litter, water, weight) | Not started |
| E — Medications | Not started |
| F — Live updates and care events on the charts | Not started |
| G — Notifications (optional) | Not started |
| H — Clean-up, docs, CI, merge | Not started |

**Commits:** each checkpoint is committed on `feature/households` once `bin/rails test` passes, then pushed. Merged into `main` only when you ask.

## Decisions

| Topic | Decision | Why |
|---|---|---|
| Owners | **Exactly one owner per household.** A user owns at most one household (their own cats) | Matches how the app is used; simpler rules and tests; the email rule stays clear |
| Transfer ownership | **Built in.** The owner can hand the household to one of its members; deleting an account asks to transfer first | Covers the owner leaving or losing access, which co-owners would otherwise solve |
| Co-owners | **Not now.** Can be added later without a database change (memberships already store a role) | Not needed yet; more rules (last owner, who removes whom, emails) |
| Caregivers and viewers | **Can belong to several households** (several owners' cats) | A family member helping two households; a pet sitter with several clients; an owner who also checks a friend's cat |
| Food bags | **Belong to the household** | Caregivers pick from them; with one owner, "household bags" and "owner's bags" are the same bags |
| Recording care | **Option A: one tap saves "now"** | Production trackers are entered within 10 minutes of feeding, so "now" is accurate; one tap in the usual case; others see it at once; nothing lost if interrupted |
| Changing the time | **"Change time"** in the saved notice and on each timeline entry; quick picks **5 · 10 · 15 min ago** plus a full picker | Rarely needed; quick picks match the 10-minute pattern |
| Option B ("ask for the time first") | **Not built** | The data doesn't call for it |
| Caregiver's optional details | **"Add details"** after a tap: date and time, **food type**, brand, description, amount, **all optional**. Brand and description are **suggested by food type** (see below). Saved **on the care event** | Keeps one tap for the usual case; details when useful |
| Details into trackers | The **owner** gets **"Add to trackers"**, a tracker form prefilled from the care event | Caregivers are read-only on trackers; the owner adds leftovers, hunger and love, so favorite scores and food-bag stock stay under the owner's control |
| Undo | **10 seconds** after a tap | Fixes accidental taps |
| Double-tap guard | Asks "Mom fed Aji at 08:05; record again?" when the same care for that cat was recorded within **30 min** (fed, water) or **2 h** (litter); for meds, a dose already given in the current time slot | Prevents double feeding and double doses between members |
| Meds | One tap **plus a short confirmation** ("Give Aji 1 tablet Clavamox?") | A wrong "given" could mean a missed real dose |
| Time storage | One timestamp, `occurred_at` (UTC), shown in the user's time zone | Avoids the date + time-of-day handling trackers need (ARCHITECTURE.md §1.7) |
| Detailed feeding | **Stays in `trackers`** (owner) | The favorite score, charts, food bags and kibble prices depend on it |
| Emails (kibble prices, backups) | **Unchanged: the owner only**, never caregivers or viewers | Decided 2026-09-29 |
| Kibble price tracker | **Unchanged** (the BigGo momo shop filter is not added) | Decided 2026-09-29 |

## Roles

| | Owner | Caregiver | Viewer |
|---|---|---|---|
| Today page: one-tap fed / litter / water / meds, weight | ✅ | ✅ | ❌ |
| "Add details" on a care event | ✅ | ✅ (own events) | ❌ |
| Change the time of a care event | Any event | **Own events, within 24 hours** | ❌ |
| Undo (10 s) | Own taps | Own taps | ❌ |
| "Add to trackers" from a care event | ✅ | ❌ | ❌ |
| **Trackers list** and favorite list | ✅ | **Read-only** | ❌ |
| **Charts** | ✅ | **Read-only** | **Read-only** (the only thing a viewer sees) |
| Kibble prices page | ✅ | See [open question](#open-question) | ❌ |
| Health checks, vet visits | ✅ | ❌ | ❌ |
| Food bags | ✅ | Read-only (to pick from) | ❌ |
| Edit cats and medications | ✅ | ❌ | ❌ |
| Invite, change roles, remove members; transfer ownership | ✅ | ❌ | ❌ |
| Public share link | ✅ | ❌ | ❌ |
| Leave the household | — (transfer first) | ✅ | ✅ |

The existing **public share link** and **vet-visit members** keep working as they do today.

**Access rule:** "pets in the user's own household or in households where they are a member, allowed by their role". One place decides it, e.g. `Pet.accessible_by(user)` and a small policy object (`HouseholdPolicy.new(user, pet).can?(:record_care)`), used by every controller instead of `Current.user.pets`. A pet the user may not see stays "not found", as today (ARCHITECTURE.md §4.5).

## Example

```
Rita's household (owner: Rita)        Ken's household (owner: Ken)
  cats: Aji, Umi                        cats: Mochi
  food bags: Rita's bags                food bags: Ken's bags
  caregiver: Mom                        caregiver: Mom
  viewer: Grandma                       viewer: Rita
```

Mom's Today page shows Aji and Umi under "Rita's cats" and Mochi under "Ken's cats". Rita sees her own cats fully, and Mochi's charts only.

## What the app has today

| Area | Today | This plan |
|---|---|---|
| Ownership | `pets.user_id` | `pets.household_id`; `households.owner_id` |
| Food bags | `dry_foods.user_id`; a tracker may only use a bag owned by the pet's owner | `dry_foods.household_id`; a tracker may only use a bag of the pet's household |
| Sharing | A public read-only link per pet; members on a single vet visit | Plus household members with roles |
| Feeding | Detailed `trackers` | Unchanged, plus one-tap "fed" care events |
| Litter, water, meds | None | Care events; medications with schedules |
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
pets                    + household_id (NOT NULL once filled); user_id kept until checkpoint H
dry_foods               + household_id (NOT NULL once filled); user_id kept until checkpoint H
care_events             pet_id, household_id, actor_id → users, kind, occurred_at,
                        food_type, brand, description, amount (g)     ← optional "Add details" (fed)
                        medication_id (meds), value (kg, weight), note,
                        tracker_id (set when the owner uses "Add to trackers"),
                        edited_by_id, edited_at, undone_at, timestamps
                        index (pet_id, kind, occurred_at)
                        kind: fed · litter · water · meds · weight
medications             pet_id, name, dose (text, e.g. "1 tablet"), times (e.g. ["08:00", "20:00"]),
                        starts_on, ends_on, active, timestamps
```

**Moving existing data (checkpoint A):** one migration creates a household for every user who has pets or food bags ("Rita's household"), with that user as **owner**, and sets `household_id` on their pets and food bags. Nothing changes for current users. The migration is checked on a throwaway PostgreSQL database first, as in the kibble price work.

## Care events

**Recording (Option A):**
1. The caregiver taps **🍽 Fed** on Aji's card.
2. The server saves a care event with `occurred_at = now` and the tapping member as `actor`.
3. A notice appears: `✔ Fed Aji · 08:12  [Change time]  [Add details]  [Undo]`.
4. The household's timelines update ("Fed 08:12 by Mom").

**"Add details" (fed), all optional:**
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

**Rules:**
- **Time limits:** `occurred_at` can't be more than 2 minutes in the future (clock drift) or more than 7 days ago.
- **Edits:** changing the time or details sets `edited_by` and `edited_at`; the timeline shows "(changed)".
- **Undo:** within 10 seconds, by the member who tapped; sets `undone_at` (kept, hidden from timelines).
- **Double-tap guard:** as in [Decisions](#decisions).
- **Weight** is a small form (a number, with "now" prefilled), not one tap.
- **Trackers in the timeline:** a tracker the owner logs directly also shows as feeding on the Today timeline (the timeline reads both), so the owner doesn't need to tap "Fed" too.

## The Today page

- **One card per cat**, grouped by household when the user belongs to several ("Rita's cats · Ken's cats"): photo, name, and buttons **🍽 Fed · 🚽 Litter · 💧 Water · 💊 Meds · ⚖️ Weight**.
- **Under the buttons:** the last time of each ("Fed 08:12 by Mom · Litter 07:30 by Dad · Water yesterday 21:00 by Rita").
- **Meds:** each active medication shows **due**, **given** (by whom, when) or **overdue** for today's times.
- **A day timeline** below, newest first, including trackers.
- For owners and caregivers only. Works in the browser, the installable web app and the Android app (Hotwire Native; a `:native` variant if the layout needs it). Caregivers land here after sign-in.

## Invitations and members

1. The owner enters an email and picks **caregiver** or **viewer**.
2. The invitee gets an email with a link: random token stored as a digest, **single use**, expires in **7 days**, only for that email address.
3. They sign up or sign in (email, Google, LINE or GitHub) and join with that role. Someone already in other households just gains this one.
4. The owner can change a member's role or remove them; members can leave.

## Transfer ownership

1. The owner picks a **member** of the household and confirms.
2. The member gets an email and an in-app prompt, and **accepts** (single-use link, expires in 7 days).
3. On acceptance, in one transaction: the member becomes the owner (their membership row is removed); the **former owner becomes a caregiver** (they can then leave). Cats, food bags, trackers, health records and vet visits all stay with the household.
4. The new owner must not already own a household (a user owns at most one). If they do, the transfer is refused with an explanation.
5. **Deleting an account** that owns a household with cats first asks: transfer to a member, or delete the household and its cats (as happens today).
6. After a transfer, owner-only emails (kibble prices, backups) go to the new owner.

## Live updates (checkpoint F)

- A tap broadcasts the new event to the household with **Turbo Streams over Solid Cable**, which production already runs (`config/cable.yml`), so other members' Today pages update without reloading.
- Care events appear on the **charts** (e.g. markers for litter and meds), which viewers also see, and in the owner's CSV export.

## Notifications (checkpoint G, optional)

Using the existing `NotificationService` (LINE push or email), to the owner and caregivers:
- "Meds overdue for Aji (due 09:00)".
- "No litter logged for Aji in 2 days".

## Build order and checkpoints

| # | Build | Checkpoint |
|---|---|---|
| 0 | Decisions | ✅ Done, except the open question below |
| A | `households`, `household_memberships`, `pets.household_id`, `dry_foods.household_id`; data migration | All existing tests pass unchanged; migration checked on PostgreSQL; every current user owns one household with their pets and bags |
| B | `Pet.accessible_by`, `HouseholdPolicy`; replace every lookup listed above; food-bag rule by household; jobs, mailers and brand names via the household's owner | A test matrix of **each role on each page** (allowed and refused); single-member households behave exactly as today |
| C | Invitations, member list, role changes, leaving; transfer ownership; account deletion asks to transfer | Invite → accept → role applies; expired, reused and wrong-email links refused; transfer swaps owner and caregiver in one transaction |
| D | `care_events`; Today page; one-tap fed, litter, water; weight form; change time; "Add details" with suggestions by food type; "Add to trackers"; undo; double-tap guard | Browser test: caregiver taps Fed, adds details, changes the time, undoes; owner adds it to trackers; viewer can't open Today |
| E | `medications`; meds button with confirmation; due / given / overdue | Doses shown per schedule; double dose guarded |
| F | Turbo Streams broadcast; care events on charts and in CSV | Two browser sessions: a tap in one appears in the other |
| G | Reminders (optional) | Overdue meds and missing litter reminders sent once |
| H | Remove `pets.user_id` / `dry_foods.user_id`; docs (README, ARCHITECTURE, USAGE) | CI green; merged into `main` when you ask |

## Risks

| Risk | How it's handled |
|---|---|
| **Access checks change on every page** (checkpoint B) | One policy used everywhere; a role × page test matrix; single-member households behave exactly as today |
| Data migration on production | Additive columns first, backfilled by a migration tested on PostgreSQL; old `user_id` columns removed only in H |
| Caregivers or viewers seeing private data | Health checks, vet visits, the Gemini API key, the share link and owner emails stay owner-only; viewers see charts only |
| Owner leaves or deletes their account | Transfer ownership; account deletion asks to transfer first |
| Invitation or transfer links forwarded | Single use, 7-day expiry, bound to the invited email / chosen member |
| Double feeding / double doses | Live timeline, double-tap guard, meds confirmation |
| Wrong times | "Now" by default (entries are made within 10 minutes), quick picks, 7-day limit, edits shown |
| Inconsistent food names from caregivers | Suggestions by food type from the household's bags and the cat's favorites |
| Kibble price check | Unchanged; it keeps using the owner's trackers and favorites. Brand names and the email come from the household's owner in B |

## Open question

**Kibble Prices page for caregivers:** you decided caregivers get read-only **trackers and charts**. Should they also see the pet's **Kibble Prices** page (read-only, no "Refresh now")? *Recommended: no*, keep it owner-only, since the owner does the buying and gets the monthly email. Until you decide, the plan treats it as owner-only.

## Change log

- **v2 (2026-09-29):** one owner per household with transfer ownership; caregivers and viewers can belong to several households; household food bags; caregiver read-only on trackers and charts, viewer charts only; owner-only emails; caregiver "Add details" with suggestions by food type, saved on the care event, and the owner's "Add to trackers". All v1 open questions answered.
- **v1 (2026-09-29):** first plan.
