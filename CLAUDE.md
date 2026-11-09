# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Pet Tracker v4: a server-rendered Rails 8.1 monolith (Ruby 3.4.1, Hotwire: Turbo + Stimulus, Importmap, Tailwind CSS 3) for logging cats' feeding, health, vet visits, food stock, household care and monthly kibble prices. UI in `en` (default), `zh-TW` and `ja`. [ARCHITECTURE.md](ARCHITECTURE.md) is the full design doc (endpoints, schema, security, jobs); the `*_PLAN.md` files record decisions and test results for each feature, checkpoint by checkpoint.

## Commands

```bash
bundle install && npm install
bin/rails db:prepare                 # dev and test use SQLite (storage/development.sqlite3); production is PostgreSQL
bin/dev                              # foreman + Procfile.dev: web (Thruster :80 → Puma :3000), tailwindcss:watch[always], i18n:export, bin/jobs
bin/rails i18n:export                # regenerate app/javascript/translations.{json,js} after changing JS-visible locale keys

bin/rails test                                       # unit + integration (parallel, fixtures :all)
bin/rails test test/models/pet_test.rb               # one file
bin/rails test test/models/pet_test.rb:42            # one test by line
bin/rails test:system                                # Selenium headless Chrome
bin/rubocop                                          # rubocop-rails-omakase
bin/brakeman --no-pager -w2                          # what CI runs
bin/importmap audit
```

If you start `bin/dev` in the background, sending SIGINT/SIGTERM to the foreman process alone leaves Puma, Thruster, Tailwind and Solid Queue running; kill them too (check ports 80 and 3000 afterwards).

CI (`.github/workflows/ci.yml`) runs Brakeman, importmap audit, RuboCop and `bin/rails db:test:prepare test test:system` on PRs and pushes to `main`.

Test helpers: `log_in_as(user)` (integration, `test/test_helper.rb`) and `sign_in_as(user)` (system, `test/application_system_test_case.rb`); fixture users' password is `password123`.

## Architecture

- **One HTML, three clients.** Browsers, the PWA and the Android app (`pet_tracker_android/`, Hotwire Native, Gradle) get the same server-rendered pages. `ApplicationController#hotwire_native_app?` (User-Agent) sets a `:native` request variant, so `*.html+native.erb` templates (e.g. `layouts/application.html+native.erb`) override the web ones. All routes are inside `scope "(:locale)"`.
- **Households and roles are the access model.** Every cat, food bag, litter box and water spot belongs to a `Household` (one owner; caregivers and viewers via `HouseholdMembership`). `HouseholdPolicy#can?` is the single place that decides permissions. Pet-scoped controllers include `PetAccess` and call `load_pet(id, permission)` (built on `Pet.accessible_by(user)`); cats outside the user's households are "not found". Take the household from the cat/box/spot, never from form params. Don't re-declare `before_action :require_authentication` in a controller: `ApplicationController` already runs it, and re-declaring moves it after `set_pet`. `VetVisitsController` intentionally uses unscoped `Pet.find` with its own owner/member checks. New pet-scoped controllers need a cross-user test like `test/controllers/pet_ownership_test.rb`.
- **Trackers (feeding log) are the core.** Favorite-food scoring and ranking live in `Pet#favorite_foods` / `#favorite_kibbles` and `TrackersCalculable` (concerns in both controllers and models; chart series, the hotel/boarding split by note keywords). `Tracker after_commit` drives `DryFood#update_used_amount!` (inventory and run-out date). `feed_time` is stored on the 2000-01-01 placeholder date, so sort with `Tracker.local_feed_time_sql`, not the raw column.
- **Care and live updates.** One-tap `CareEvent`s (fed, weight, litter, water, meds) on the Today page (`TodayController`, `HouseholdDay`); deletion is soft (`undone_at`, `deleted_by_id`). Models including `RefreshesHouseholdPages` broadcast a Turbo page-refresh (no data) to the household's stream; pages morph in place. Edit/delete rules: `CareEvent#editable_by?` / `#deletable_by?`.
- **Background jobs** run on Solid Queue (Solid Cache and Solid Cable too; no Redis). Production schedule is `config/recurring.yml`: hourly `CareReminderJob`, `PetWeightRemindersJob` and `DriveBackupJob` (each works out the person's local time; `CareReminder` rows make each reminder send once), daily `UserBackupJob`, monthly `MonthlyKibblePriceJob` → `PetKibblePriceJob`. Recurring entries must be job classes, not rake commands (`Rake::Task#invoke` runs once per worker process). `test/jobs/recurring_schedule_test.rb` checks the schedules parse.
- **Notifications** pick one channel per person: Android app (`FcmClient`, `DeviceToken`; off without `FIREBASE_SERVICE_ACCOUNT_JSON`), LINE, or email, falling through on failure (`ReminderChannels`, `*Notifier` models).
- **Kibble prices** (`app/services/kibble_prices/`): `PoliteHttp` is the only network client allowed for scraping (allow-listed BigGo/PChome hosts and paths, no redirects, rate-limited); `Matcher`/`BagSize`/`BrandNames` decide whether a listing is the pet's kibble. feebee must not be used (its terms forbid it).
- **Other services:** `GeminiOcrService` (health-report photos, synchronous, user's own encrypted API key), `CsvImportTrackersService`, `GmailApiDelivery` (production mail via Gmail API, SendGrid fallback), `GoogleDriveClient`.

## Conventions

- **i18n:** every user-facing string goes in all three `config/locales/{en,zh-TW,ja}.yml`. The in-app guide `/doc` (`app/views/pages/doc.html.erb`) takes most feature sections from `doc_page.feature_sections` in the locale files, so documenting a feature means adding a section in each language; `USAGE.md` mirrors the guide. Strings used by Stimulus come from `app/javascript/translations.js` (patterns in `config/i18n-js.yml`), committed and regenerated by `bin/rails i18n:export` (also hooked into `assets:precompile`).
- **Migrations:** dev/test are SQLite but production is PostgreSQL. Never verify a migration on PostgreSQL with `db:create`/`db:schema:load`/`db:migrate` and an env var set earlier in a shell chain: if the setup fails, those commands hit `storage/development.sqlite3` (this wiped dev tables once). Use `bin/rails runner` with a guard that aborts unless the adapter is PostgreSQL and the database is a throwaway one.
- **Deploy:** Railway auto-deploys every push to `main` (web service `Pet_Feeding_Tracker_v4` and worker `pet-tracker-worker`, per `Procfile`). It doesn't wait for CI and has skipped a commit before, so confirm the deployed commit after pushing. `config/deploy.yml` (Kamal) is unused.
