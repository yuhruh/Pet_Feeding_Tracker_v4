# Pet Tracker v4

Pet Tracker v4 helps pet owners keep an accurate record of what their pets eat, how they feel about it, and how healthy they are. Log each meal, see which foods your pet really loves, keep track of the food in the cupboard, prepare for vet visits, and every month get the current Taiwan prices for the kibbles your pet loves most.

## Overview

**Who it's for:** people caring for cats (or other pets) who want more than memory and receipts: what was served, how much was left, how eagerly it was eaten, and how weight and blood results change over time. It works in English, 繁體中文 and 日本語.

**How it fits together:**

- **Feeding is the heart of it.** Each meal is a *tracker*: food type, brand, amount served and left, how hungry the pet was and how much it loved the food. From these the app scores every food, charts intake and weight over time, and keeps a **Favorite Food** list of the foods your pet loves most.
- **Everything else builds on that record.** Dry food bags are drawn down by each tracker, so the app knows how much is left and when it will run out. The favorite list decides which kibbles get a monthly **price check**. Health checks, weight and vet visits sit alongside, so a vet can see the whole picture.
- **Sharing is opt-in.** Owners can create a read-only link to a pet's feeding dashboard (for a sitter or vet), or invite other members to a specific vet visit.
- **It runs itself in the background.** Daily jobs send backups and weight reminders; a monthly job checks kibble prices and emails the results.

**Under the hood:** a server-rendered **Rails 8.1** app (Hotwire: Turbo and Stimulus, Tailwind CSS). The same pages serve desktop and mobile browsers, an installable PWA, and an **Android app** (`pet_tracker_android/`, Hotwire Native). Background jobs, caching and real-time updates run on the database through Solid Queue, Solid Cache and Solid Cable, so no Redis is needed. Production runs on **Railway** with PostgreSQL and deploys every push to `main`. For the full design, see [ARCHITECTURE.md](ARCHITECTURE.md).

## Features

*   **Pet Management:** Add and manage profiles for multiple pets.
*   **Dietary Tracking & Preference Analysis:** Log daily feeding records and identify your pet's favorite foods using a scoring algorithm based on their hunger, how much they loved the food, how much they left and how often they came back to it.
*   **Kibble Price Check:** On the 1st of every month, the app finds current Taiwan prices for the kibbles your pet has loved over the last 4 months, ranks them by **price per kg**, and emails you the list. See [Kibble Price Check](#kibble-price-check) below.
*   **Smart Inventory Management:** Track dry food bags with automatic calculation of the food left and a predicted run-out date based on how fast your pet eats.
*   **Comprehensive Data Visualization:** Interactive charts of food consumption (dry and wet) and weight over time, including separate tracking for boarding stays.
*   **Health Record Management:** Track your pet's checkups and blood test results.
*   **AI Data Extraction:** Upload photos of health checkup reports and let Google Gemini fill in the results, using your own Gemini API key.
*   **Vet Visit Preparation & Q&A:** Prepare questions before a vet visit and record the vet's answers afterward, with the vet's name, the purpose of the visit (vaccination, checkup, dental cleaning, surgery, and more), and how long you waited versus how long you spent with the vet.
*   **Sharing:** Create a read-only link to a pet's records for others such as sitters or vets, or invite specific members to view and answer vet questions.
*   **User Authentication:** Email and password, or sign in with Google, LINE or GitHub.
*   **Data Portability & Bulk Operations:** Import and export trackers as CSV, and delete many records at once.
*   **Automated Backups:** A CSV backup of your trackers by email every day you've changed them.
*   **Smart Notifications:** Weight reminders by email, or through LINE if you signed in with LINE.
*   **Multilingual Support:** English, 繁體中文 and 日本語, with feeding times shown in your own time zone.
*   **Mobile:** Install it on your phone as a Progressive Web App, or use the Android app.

## Kibble Price Check

Pet Tracker compares what your pet's favorite kibbles cost in Taiwan's online shops, so you can buy the one your pet loves at the best price.

- **Which kibbles:** the ones on your pet's favorite list with a favorite score of 30 or more, fed in the last 4 months (up to 5).
- **Where prices come from:**
  - **BigGo** (biggo.com.tw), a price-comparison site that lists many shops at once, including Shopee, momo, Yahoo, Coupang and Rakuten.
  - **PChome 24h**'s own search.

  Other price-comparison sites such as feebee were ruled out because their terms forbid automated collection.
- **Matching the right product:** shops name products differently from owners (e.g. 室內貓雙響宴 vs 室內雙饗宴). The app compares names character by character, and also checks the brand (under any name you've used for it, e.g. 喵皇奴 / Purrsuit), the species, every protein you named (鴨肉 is never taken for 雞肉), product-line codes like IN27, and the exact variant a price is for.
- **Fair comparison:** each listing's bag size is read from its title (`2kg`, `300克`, `3.3lb`, `4kg 2包組`…) and prices are ranked by **NT$ per kg**, cheapest first. Short-dated or repacked stock is left out.
- **Where to see it:** open a pet's profile → **Kibble Prices**, or the link on the favorite list. **Refresh now** checks again, once a day. On the 1st of each month the results are also emailed to you, in 繁體中文, 日本語 or English depending on your time zone.
- **When nothing is found:** if neither BigGo nor PChome lists a kibble, the page says **"Can't find this kibble in shops right now."**
- **Being a good neighbor:** each search is made at most once a month (shared across users), requests are spaced 2 seconds apart and one pet is checked at a time, and BigGo's redirect links, which its robots.txt disallows, are never fetched.

Prices are approximate. Pet Tracker doesn't sell anything and isn't paid by these shops. The design, decisions and test results are recorded in [KIBBLE_PRICE_PLAN.md](KIBBLE_PRICE_PLAN.md).

## Scheduled Jobs

Defined in `config/recurring.yml` and run by Solid Queue in production (server time, UTC):

| Job | When | What it does |
|---|---|---|
| `UserBackupJob` | Every day at 3am | Emails a CSV backup to users who changed a tracker in the last day |
| `pet_weight_reminder` | Every day at 9am | Reminds owners to weigh their pets, by email or LINE |
| `purge_expired_sessions` | Every day at 4am | Deletes expired sign-in sessions |
| `MonthlyKibblePriceJob` | The 1st of every month at 6am | Checks kibble prices for every pet fed kibble in the last 30 days and emails the results |
| `clear_solid_queue_finished_jobs` | Every hour | Clears finished background jobs |

## Technical Highlights

*   **Rails 8.1 monolith** with Hotwire (Turbo and Stimulus), Importmap and Tailwind CSS; the same views serve browsers, the PWA and the Hotwire Native Android app.
*   **Solid Queue, Solid Cache and Solid Cable** for database-backed background jobs, caching and real-time features.
*   **Gemini AI Integration** for reading health-check reports, with each user's own API key.
*   **Price lookups with Nokogiri** over a small, allow-listed HTTP client (only BigGo's and PChome's search pages; no redirects; size and time limits).
*   **Internationalization** with `rails-i18n` and `i18n-js` (translations shared with Stimulus controllers).
*   **Deployment:** Railway in production (PostgreSQL, a web process and a `bin/jobs` worker, see `Procfile`), with `Thruster` for HTTP caching and compression. A `Kamal` configuration is also included.
*   **Testing:** Minitest unit, integration and browser (system) tests, plus Brakeman, RuboCop and importmap audits, all run by GitHub Actions on pull requests and pushes to `main`.

## Getting Started

You'll need **Ruby 3.4.1** and Node.js (for Tailwind CSS and i18n-js). Development and tests use **SQLite**, so no database server is needed locally; production uses PostgreSQL.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yuhruh/Pet_Feeding_Tracker_v4.git
    cd Pet_Feeding_Tracker_v4
    ```
2.  **Install dependencies:**
    ```bash
    bundle install
    npm install
    ```
3.  **Create and set up the database:**
    ```bash
    bin/rails db:prepare
    ```
4.  **Start the app** (web server, Tailwind watcher, translation export and job worker, from `Procfile.dev`):
    ```bash
    bin/dev
    ```
5.  **Run the tests:**
    ```bash
    bin/rails test          # unit and integration tests
    bin/rails test:system   # browser tests (needs Chrome)
    ```

Sign-in with Google, LINE or GitHub needs their client IDs and secrets in the environment; email sign-in works without them.

## How to Use

1.  **Create an account:** Sign up, or sign in with Google, LINE or GitHub.
2.  **Set your time zone** in your profile so feeding times are recorded correctly.
3.  **Add a pet** in the "Pets" section.
4.  **Log meals** in "Trackers". Charts show intake and weight trends, and the **Favorite Food** list shows your pet's most loved foods.
5.  **Check kibble prices:** open your pet's profile → **Kibble Prices** to see where its favorite kibbles are cheapest per kg. Prices are checked on the 1st of every month and emailed to you; press **Refresh now** to check today.
6.  **Manage food storage** in "Dry Foods". The app predicts when each bag will run out based on current feeding.
7.  **Track health** in "Health Checks". Add your Gemini API key in your profile to have report photos read for you.
8.  **Prepare for vet visits** in "Vet Visits": note questions before the appointment, then record the answers, the vet, the purpose, and consultation and waiting times. Invite other members to help.
9.  **Share records:** create a link so others, like vets or sitters, can see your pet's feeding and health history.

For step-by-step instructions, see [USAGE.md](USAGE.md).

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License.
