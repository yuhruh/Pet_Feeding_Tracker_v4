# Households and Caregivers — Implementation Plan (v6)

**Goal:** Let several people look after the same cats. Each **owner** has a **household**: their cats, food bags, litter boxes and water spots, and the people they let help. A **caregiver** records care with **one tap** (fed, litter, water, meds given) and everyone in the household sees it right away. A **viewer** sees the charts and today's timeline, read-only, through a **personal link** with no account needed. A caregiver **needs an account**, joining through the owner's invitation. Caregivers and viewers can belong to **several owners' households**. **Reminders** say when a job "might be time" (clean the fountain, change the filter, give meds), by LINE or email first and later as Android app notifications.

## Status

| Checkpoint | Status |
|---|---|
| 0 — Decisions | ✅ Done (2026-09-29). No open questions |
| A — Households and memberships (no visible change) | ✅ Done (2026-09-30). Committed on `feature/households` and pushed. See [Checkpoint A result](#checkpoint-a-result-2026-09-30) |
| B — Access by household and role | ✅ Done (2026-09-30). Committed on `feature/households` and pushed. See [Checkpoint B result](#checkpoint-b-result-2026-09-30) |
| C — Caregiver invitations, viewer links, members, transfer ownership | ✅ Done (2026-09-30). Committed on `feature/households` in five parts and pushed. See [Checkpoint C result](#checkpoint-c-result-2026-09-30) |
| D — Care events and the Today page (fed, litter, water, weight) | Not started |
| E — Medications | Not started |
| F — Litter observations | Not started |
| G — Live updates and care events on the charts | Not started |
| H — Reminders by LINE and email | Not started |
| I — Android app push notifications (Firebase) | Not started |
| J — Clean-up, docs, CI, merge | Not started |

**Commits:** each checkpoint is committed on `feature/households` once `bin/rails test` passes, then pushed. Merged into `main` only when you ask.

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
| D | `care_events`; Today page with litter-box and water-spot rows and cat cards; one-tap fed, scooped, full change, refilled, cleaned, filter changed (several actions in one record, with checkboxes in the notice); weight form; change time; feeding "Add details" with suggestions by food type; "Add to trackers"; undo; double-tap guard; status and today's timeline on the viewer page; managing boxes and water spots | Browser test: caregiver taps Fed and adds details, refills and cleans the fountain in one record, changes a time, undoes a tap; owner adds a feeding to trackers; the viewer link shows the new records with no buttons; tests that every save refuses a household mismatch (record, food bag, box, water spot, medication) and a person without rights in that household |
| E | `medications`; meds button with Given / Couldn't give; due / given / overdue | Doses shown per schedule; double dose guarded |
| F | Litter observations in "Add details" (optional fields; which cat) | Old records unchanged; observations show on the timeline and, with a cat, in that cat's history |
| G | Turbo Streams broadcast (Today pages and viewer pages); care events on charts and in CSV | Two browser sessions: a tap in one appears in the other, including on a viewer page |
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

- **Checkpoint C (2026-09-30):** household page (members, invitations, viewer links), join page with Google / LINE, landing rules, a first Today page, grouped and smaller menus, leaving and "Add my own cat", the viewer page with charts, transfer ownership, and account deletion asking to hand over first. Today's buttons and the viewer page's status and timeline come in D.
- **Checkpoint B (2026-09-30):** access by household and role on every page; CSV export and the pet profile are owner-only; refused actions say "Only Aji's owner can do that."
- **Checkpoint A (2026-09-30):** households, memberships and care spots built; existing pets and food bags moved into their owner's household. Names stored empty and shown in each viewer's language; users without pets or bags get a household with their first one.
- **v6 (2026-09-30):** landing after sign-in depends on what the person has (new user with no household → "Add A Cat"; caregivers → Today). Caregivers can create their own household with **"Add my own cat" under Account** ("This creates your own household. Rita's cats are not affected."), becoming owner and caregiver. Pages for someone in several households: owner menu once they own cats, Today grouped by household (own first), cat lists grouped by household with the role shown. **Keeping households apart:** no household picker; the household comes from the cat, box or spot and is set by the server, which refuses any mismatch.
- **v5 (2026-09-29):** caregivers **need an account**, joining through a one-step invitation page (prefilled email, or Google / LINE), landing on Today instead of "Add A Cat", with a smaller menu. Viewers use a **personal link** with no account: a read-only viewer page with status, today's timeline and charts; one link per viewer, revocable, optional expiry; signing in from it adds the household to their account. Invitations are for caregivers only; new `viewer_links` table.
- **v4 (2026-09-29):** water spots use **buttons + checkboxes** (one tap saves; the notice's checkboxes add the other actions to the same record). **Reminders** per spot and job, counted from the last time it was done (twice a week, twice a month, …), once at 9am local time plus one follow-up, to the owner and caregivers who turn them on; meds overdue too. Channels: **LINE, else email (H)**, then **Android app push via Firebase (I)**. Clean-up moves to J.
- **v3 (2026-09-29):** litter and water are shared per litter box or water spot (one of each created automatically; owners add more); water spots are bowls or fountains, fountains with 💧 Refilled · 🧽 Fountain cleaned · 🔄 Filter changed, and several actions in one record; litter 🚽 Scooped · ♻️ Full change; litter observations in a later checkpoint (F), stored as optional fields from the start; optional "which cat" only on observations; "Add details" also on timeline entries; meds "Couldn't give"; viewers see charts and today's timeline read-only; kibble prices owner-only. Checkpoints renumbered (F observations, G live updates, H notifications, I clean-up).
- **v2 (2026-09-29):** one owner per household with transfer ownership; caregivers and viewers can belong to several households; household food bags; caregiver read-only on trackers and charts; owner-only emails; caregiver feeding details with suggestions by food type, saved on the care event, and the owner's "Add to trackers".
- **v1 (2026-09-29):** first plan.
