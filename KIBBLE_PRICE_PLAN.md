# Monthly Kibble Price Ranking — Implementation Plan (v4)

**Goal:** On the 1st of each month, find current Taiwan prices for the kibbles each pet loves, rank them by **NT$ per kg from cheapest to most expensive**, and show the list **in the app and in an email**. Gemini, using **each user's own key**, is only a backup.

## Status

| Checkpoint | Status |
|---|---|
| 0 — Terms check | ✅ Done (2026-09-28). **feebee rejected** (its terms forbid automated collection). **BigGo confirmed as the main source.** See [Checkpoint 0 result](#checkpoint-0-result-2026-09-28). |
| A — Refactor | ✅ Done (2026-09-28). Committed as `cb5ea94` on `feature/kibble-prices` and pushed to GitHub. See [Checkpoint A result](#checkpoint-a-result-2026-09-28). |
| B — Price sources and lookup | ✅ Done (2026-09-28). Committed on `feature/kibble-prices` and pushed. See [Checkpoint B result](#checkpoint-b-result-2026-09-28). Its four review questions were answered the same day. |
| C — Gemini backup, models, jobs | ✅ Done (2026-09-28). Committed on `feature/kibble-prices` and pushed. See [Checkpoint C result](#checkpoint-c-result-2026-09-28). |
| D — Page, email, translations | ✅ Done (2026-09-28). Committed on `feature/kibble-prices` and pushed. See [Checkpoint D result](#checkpoint-d-result-2026-09-28). |
| E — Tests, lint, CI, merge | ✅ Done (2026-09-28). Merged into `main` directly (no pull request, at your request) as `8d34a86`; tests, lint and CI passed. **The first monthly run is 2026-10-01 at 06:00 UTC (14:00 Taiwan).** |

**Decisions**

| Topic | Decision |
|---|---|
| Ranking | Price per kg, cheapest first |
| Region / currency | Taiwan, TWD |
| Delivery | In-app page + monthly email |
| Gemini key | Each user's own key (backup source only) |
| Favorite window | Kibbles fed in the last 4 months (also the window for learning brand names) |
| Ranking ties to bag size | None: ranked purely by NT$/kg, so a small bag can come first |
| Multi-flavor "series" listings | Kept when the owner's flavor is among them |
| No BigGo/PChome listings | Ask Gemini (owner's key), label "unverified" |
| Main price source | **BigGo** price-comparison site read with Nokogiri (confirmed 2026-09-28; was feebee until checkpoint 0) |

## Background: why this approach

Findings from plain HTTP requests (no JavaScript), the way Nokogiri sees a page:

| Site | Result |
|---|---|
| Shopee | 200, 173 KB, **0 prices**. The page is an empty shell; prices come from an anti-bot-protected internal API. No JSON-LD or built-in page data. |
| PChome (HTML) | **429** on the first request. Its JSON search endpoint works, though. |
| momo | 200, JSON-LD and prices in the HTML. |
| **feebee / BigGo / FindPrice** | 200, **prices in the HTML, Shopee listings included**. feebee page 1 had 36 `li.items` listings from momo, ETMall, Yahoo, Shopee, Rakuten, SKM. |

Rejected options:
- **Visiting each store page with Nokogiri** — fails on Shopee and PChome, and needs selectors for every store.
- **Headless browser** — heavy on Railway and still blocked by anti-bot measures.
- **Shopee Affiliate Open API** — not available to individual accounts.
- **Gemini as the main source** — prices come from Google's index and may be outdated or made up.
- **feebee** — its terms forbid automated collection and storing its data (see below).

## Checkpoint 0 result (2026-09-28)

I read each site's full published terms and its robots.txt. This is a reading of the terms, not legal advice.

### feebee — ❌ rejected
[Terms](https://feebee.com.tw/terms/), last updated 2026-08-19:
- **§4.1.15:** 「不得以自動化登入及操作方式蒐集本服務提供的資訊」 — no collecting the service's information by automated means.
- **§12.5:** without prior written consent, no use of the service's data for commercial purposes, and no "copying or storing any part of the service in any other system" (our monthly cache and `kibble_prices` table would do exactly that).
- **§12.8:** 「請勿未經本公司事先書面同意，大量、有系統地抓取本服務相關資訊」 — no systematic scraping without prior written consent, with a **NT$1,000,000 penalty**.
- robots.txt disallows `/rd/` (its store redirect links), `/product/`, `/query/`, `/compare/` and others. `/s/` (search) is not disallowed, but the terms override that.
- **The only way back in:** feebee's written permission (service@firstweb.com.tw). Not worth waiting on for now.

### BigGo — ✅ confirmed main source
[Terms page](https://biggo.com.tw/official/disclaimers) (用戶條款 / privacy / disclaimer / cashback terms), last updated 2026-01-09:
- **No clause about automated access, scraping or storing data** in the published text. The disclaimer says its own data is collected "via Datafeed, API and other technologies" and may be inaccurate or outdated.
- robots.txt: `Allow: /`, only `Disallow: /r/` (its store redirect links). The search pages are allowed.
- No explicit ban isn't the same as permission. So the plan keeps the load tiny (see Step 4), never fetches `/r/` links, and shows BigGo as the source on the page.

### PChome JSON endpoint — ✅ keep as optional
[Member terms](https://member.pchome.com.tw/law.html):
- No explicit scraping clause. They forbid disrupting or interfering with the system (§7), which the plan's low volume avoids.
- robots.txt only disallows `v3.3` category and `.com` queries. The `v4.3` search endpoint isn't listed.
- The endpoint is undocumented and may change without notice. It stays optional.

### FindPrice — not used
Its terms page couldn't be found. robots.txt disallows `/go/` and `/json/`. Not needed while BigGo works.

### Decision
- **BigGo confirmed as the main source** (2026-09-28). feebee is not used and not contacted.
- Checkpoint B starts by inspecting BigGo's listing HTML to write the selectors. Only BigGo's page-level data has been checked so far (200 OK, prices present, Shopee and momo listings included).

## Checkpoint A result (2026-09-28)

**Changed files** (commit `cb5ea94` on `feature/kibble-prices`, pushed to GitHub; no pull request yet):
- `app/models/pet.rb` — adds `favorite_foods`, `favorite_kibbles` and the private helpers they share (`rated_trackers`, `group_favorites`, `favorite_summary`).
- `app/controllers/trackers_controller.rb` — `favorite_food` calls `@pet.favorite_foods`; about 30 lines removed.
- `test/controllers/favorite_food_test.rb` (new) — pins down the favorite-food JSON and page. **Written and passing before the refactor**, then still passing after it:
  - grouping, with trailing counts like `x2` / `（x3）` joining the same food;
  - five best-scored days per food, one per day, latest first;
  - most-loved-first order;
  - the `food_type` filter;
  - the HTML page renders.
- `test/models/pet_test.rb` — `favorite_kibbles`: kibble only, order, `min_score`, `since`, `limit`, and the linked bag.

**Results:**
- `bin/rails test`: 226 runs, 0 failures.
- `bin/rails test:system`: 29 runs, 0 failures.
- `bin/rubocop` on the changed files: no offenses.

**Found while writing the tests (existing behavior, kept as is):**
- The favorite-food list leaves a feeding out only when **both** its hungry and love ratings are blank. A feeding with just one of them still counts. The test pins this.
- "Most loved" means the score of the food's **latest** listed day, not its best day. `favorite_kibbles` uses the same score for `min_score`, so the ranking matches the favorite-food page.

**Commits:** each checkpoint is committed on `feature/kibble-prices` once `bin/rails test` passes, then pushed.

## Checkpoint B result (2026-09-28)

All code lives under `KibblePrices::` in `app/services/kibble_prices/`. It isn't used by any page or job yet; that's checkpoints C and D.

| File | What it does |
|---|---|
| `bag_size.rb` | `BagSize.parse` → `{ kg:, label: }`. kg, g, 公斤, 公克, 克, lb, 磅; full-width digits; pack counts (`2包組`, `x 2`, `*2`, `【3包】`, `2入`); shipping limits (`超取最多2件`) are not packs; several sizes → nil |
| `query.rb` | Search texts, most specific first: `"{brand} {description}"`, then `"{brand} 貓飼料"` (or `狗飼料` / `飼料`) |
| `matcher.rb` | Decides whether a listing is the pet's kibble, and why not (see the rules below) |
| `brand_names.rb` | The names each brand goes by, learned from the owner's own entries (added 2026-09-28, see below) |
| `polite_http.rb` | The only network access: HTTPS GET to `biggo.com.tw/s/…` and `ecshweb.pchome.com.tw/search/v4.3/…` only, 2 s between requests per host, 10 s timeouts, 2 MB limit, no redirects, no retries, honest User-Agent `PetTrackerKibblePrices/1.0` |
| `big_go_search.rb` | Reads BigGo's first result page (30 listings) with Nokogiri; cached for the month |
| `pchome_search.rb` | Reads PChome's JSON search; cached for the month; any failure → no PChome rows |
| `listing.rb` | The shape both sources return: source, store, title, variant, price, url |
| `source_alert.rb` + `DiagnosticsMailer#price_source_alert` | Logs and emails the app's own address, at most once a day per source, when a source answers in an unexpected shape |
| `lookup.rb` | `Lookup.new(pet).call` → per favorite kibble: the searches made, the ranked prices (top 8, NT$/kg ascending) and how many listings each rule left out |

**What BigGo's page turned out to look like:**
- Search URL: `https://biggo.com.tw/s/{query}/` (the `?q=` form redirects there).
- Class names carry a build hash (`ProductItemListPC_product-price__ETFme`), so selectors match the stable prefix: `[class*="ProductItemListPC_product-price"]`.
- A listing with several variants shows a range (`$1,800 ~ $3,450`) and one priced variant (`4kg 1個 雞` → `$1,800`). The variant's own price and size are used.
- Store links are `/r/?…&purl=<shop URL>`. The shop's own URL is taken from `purl`, so people are sent straight to the shop and `/r/` is never fetched (robots.txt disallows it).
- A search with no results says `搜尋不到符合…`. Only an empty page *without* that notice triggers the admin alert.

**Matching rules** (real shop wording differs from owners': 室內貓**雙響宴** vs 室內**雙饗宴**), in order:
1. **Reject words:** 即期, 效期, 過期, 分裝, 二手, 試吃 (short-dated or repacked stock).
2. **Brand** in the listing under any of its names (see *Brand names* below). Chinese names match anywhere; Latin names only as whole words, so `go` doesn't match "GoGo".
3. **Species:** a dog-only listing is rejected for a cat and vice versa. The pet's species is inferred from its kibble names (貓 vs 犬/狗); pets don't store a species.
4. **Protein:** every protein in the description (鴨, 火雞, 雞, 鮭, …) must be in the listing. 火雞 (turkey) never counts as 雞 (chicken).
5. **Product code** (IN27, K36, …) must appear when the description has one.
6. **Coverage:** ≥ 70% of the description's characters must appear in the listing (filler such as 貓, 配方, 食譜, 飼料 doesn't count).
7. **Variant agreement:** when a listing prices a variant, ≥ 50% of the variant's characters must come from the kibble's name, so `(原野收穫)` or `L40` isn't taken for another food.

**Brand names (changed 2026-09-28, at your request):** the first version had a hard-coded list of Chinese/English pairs taken from the local data (and it was already wrong for you: `希爾思` where you write `希爾斯`). It's replaced by `KibblePrices::BrandNames`, built per owner on each run:
1. **Collect** the brand names on the owner's kibble trackers dated in the **last 4 months**, plus the bags (`DryFood`) those trackers used.
2. **Split** each into its Chinese and Latin names: `喵皇奴 purrsuit` → 喵皇奴 / purrsuit; `mon petit 貓倍麗` → mon petit / 貓倍麗. A Chinese name split by a space stays one name (`加拿大 楓沛` → 加拿大楓沛), so a word like 加拿大 alone never counts as a brand.
3. **Expand** by merging entries that share a name: `超躍` + `超躍 hyperr` → 超躍 / hyperr.
4. A kibble older than 4 months still matches under the names in its own brand field.

Locally the 4-month list is empty (the local copy ends 2026-04-29); from 2026-01-01 it has 21 brands. The real-data run below gave identical results after the change.

**Console run on real data** (pet 1, Aji, local database, `since: 2.years.ago`; 24 s, live requests):

| Favorite kibble | Found | Cheapest |
|---|---|---|
| 璞斯 體態管理全齡貓 鴨肉 | 2 | NT$975/kg — 2kg, Yahoo拍賣 / 蝦皮購物 (variant 鴨肉｜體態管理配方) |
| 璞斯 無穀營養雞肉配方 | 3 | NT$780/kg — 2KG, 蝦皮商城艾爾發寵物商城 |
| 天然密碼 無穀鴨肉&火雞肉 全齡貓配方 | 0 | Only salmon (鮭魚) variants listed; correctly none |
| 吶一口 室內貓雙響宴 | 4 | NT$460/kg — 150g 2包, 酷澎 Coupang; then momo 4kg NT$663/kg |
| 曙光 無穀滋養鴨肉食譜 | 3 | NT$444/kg — 12LB, PChome; then 3磅 NT$507/kg, 300克 NT$663/kg |

Before the protein rule, 曙光's list wrongly included the chicken (雞肉) and turkey (火雞肉) versions; the rule removed them.

**Results:**
- `bin/rails test`: 254 runs, 0 failures (29 new, under `test/services/kibble_prices/` plus one mailer test).
- `bin/rails test:system`: 29 runs, 0 failures.
- `bin/rubocop`: no offenses. `bin/brakeman -w2`: no warnings.
- Test fixtures are trimmed real BigGo pages (`test/fixtures/files/kibble_prices/`); no test touches the network.

**✅ Review questions — answered 2026-09-28:**
1. **Time window → 4 months.** `favorite_kibbles` now defaults to kibbles fed in the last **4 months** (`Pet::FAVORITE_KIBBLE_WINDOW`), the same window `BrandNames` uses for brand names. Locally this still finds nothing: Aji's latest kibble tracker is 2026-04-26 and the local copy ends 2026-04-29.
2. **Small bags → rank purely by NT$/kg.** A small bag stays first when it's cheapest per kg (e.g. 吶一口 150g × 2 at NT$460/kg). No change needed.
3. **Series listings → keep.** A listing that sells several flavors at one price is kept when the owner's flavor is among them (e.g. PChome's 曙光 12LB, `雞肉/鴨肉/白鮭魚/火雞肉`). No change needed.
4. **Nothing found → try Gemini.** For a kibble with no BigGo or PChome listings (e.g. 天然密碼 鴨肉&火雞肉), checkpoint C asks Gemini with the owner's key and labels its prices "unverified", as planned in Step 6.

## Checkpoint C result (2026-09-28)

**New and changed files:**

| File | What it does |
|---|---|
| `db/migrate/20260928120000_create_kibble_price_checks_and_prices.rb` | `kibble_price_checks` and `kibble_prices` tables (Step 2), plus a `variant` column on prices and a `kibbles` JSON column on checks |
| `app/models/kibble_price_check.rb`, `kibble_price.rb`, `pet.rb` | Models, scopes (`ranked`, `flagged`), `verified?`, `Pet has_many :kibble_price_checks` |
| `app/services/kibble_prices/gemini_search.rb` | The Gemini backup (Step 6) |
| `app/services/kibble_prices/lookup.rb` | Calls Gemini when nothing is listed, and flags suspicious Gemini prices |
| `app/jobs/pet_kibble_price_job.rb`, `monthly_kibble_price_job.rb` | The jobs (Step 8) |
| `config/recurring.yml` | `monthly_kibble_prices` under `production:` |
| `config/environments/test.rb` | Fixed, non-secret Active Record encryption keys for tests only, so tests can save `User#gemini_api_key` (encrypted); CI has no credentials file |

**How it works, as built:**
- **`KibblePrices::GeminiSearch`** follows `GeminiOcrService` (same `gemini-flash-latest` endpoint; key in `x-goog-api-key`; 60 s read timeout) and turns on `tools: [{ google_search: {} }]`. It asks for a JSON array of up to 8 offers `{store, url, price_twd, product_title}` and cuts the array out of the answer (Gemini often wraps it in ```json fences). Offers without an http(s) product page, a title or a price are dropped. Answers are cached for the month; failures (e.g. a quota error) aren't.
- **When Gemini is asked:** only for a kibble where both searches (exact name, then brand) found nothing on BigGo and PChome, with the exact-name search, using the **owner's** key. With no key it's skipped and recorded as `no_key`, so the page can say so. Gemini's offers pass the same matching rules as listed ones (brand, species, protein, code, coverage, bag size, price range).
- **Suspicious check, changed from the plan:** the plan compared a Gemini price with the same kibble's listed prices, but Gemini only runs when there are none, so that could never fire. As built, a Gemini price more than ±40% from a **reference NT$/kg** is flagged (`suspicious_reason` like `-78% from NT$507/kg`) and listed after the others. The reference is the median listed price from the pet's **latest earlier check** that had listed prices for that kibble, or else the median of Gemini's own offers when there are at least 3.
- **`PetKibblePriceJob`** creates the day's check (the unique index makes a second run that day a no-op), runs the lookup, saves the prices and a per-kibble summary (`brand`, `description`, `favorite_score`, `queries`, `found`, `gemini`) in one transaction, and marks it `done`. On an error it marks the check `failed` with the message and re-raises, so Solid Queue records the failure. `limits_concurrency key: "kibble_price_search", duration: 15.minutes` runs one pet at a time across all users.
- **`MonthlyKibblePriceJob`** queues one `PetKibblePriceJob` per pet with a kibble tracker in the last 30 days, and logs the count.
- **Schedule:** `every month on the 1st at 6am` (cron `0 6 1 * *`). The plan's wording, `at 6am on the 1st of every month`, is read by Fugit as a single date, and Solid Queue rejects it (`Schedule is not a supported recurring schedule`); a new test now checks every production schedule. Like the existing entries it runs in the server's time zone (UTC), i.e. 2 pm in Taiwan.
- The email is not sent yet; `KibblePriceMailer` comes in checkpoint D.

**End-to-end run** (local database, pet 1 Aji, with the clock set to 2026-05-01 because the local copy ends in April; live BigGo and PChome requests; 10 s):
- Check #1 on 2026-05-01: `done`, 7 prices, 3 favorite kibbles in the 4-month window.
- 天然密碼 無穀鴨肉&火雞肉: nothing listed → `gemini: "no_key"` (the local user has no Gemini key).
- 曙光 無穀滋養鴨肉食譜: 3 listed prices, Gemini not asked. 吶一口 室內貓雙響宴: 4 listed prices, Gemini not asked.
- A second run the same day didn't add a check.
- The check is still in the local development database, so checkpoint D's page can show it.

To try the Gemini path yourself, add your Gemini API key in your local user profile, then run `bin/rails runner 'PetKibblePriceJob.perform_now(Pet.find(1))'` (today's check) — note the default 4-month window finds no favorites in the local copy.

**Results:**
- `bin/rails test`: 280 runs, 0 failures (21 new: Gemini search, models, lookup's Gemini path, both jobs, schedules).
- `bin/rails test:system`: 29 runs, 0 failures.
- `bin/rubocop`: no offenses. `bin/brakeman -w2`: no warnings.

## Checkpoint D result (2026-09-28)

**New and changed files:**

| File | What it does |
|---|---|
| `app/controllers/kibble_prices_controller.rb`, `config/routes.rb` | `GET /pets/:pet_id/kibble_prices` (the page) and `POST` ("Refresh now"); owner only |
| `app/views/kibble_prices/index.html.erb`, `app/helpers/kibble_prices_helper.rb` | The page, and helpers for NT$ amounts, bag sizes and safe shop links |
| `app/mailers/kibble_price_mailer.rb`, `app/views/kibble_price_mailer/monthly_report.{html,text}.erb` | The monthly email |
| `test/mailers/previews/kibble_price_mailer_preview.rb` | Preview at `/rails/mailers/kibble_price_mailer/monthly_report` (uses the latest finished check) |
| `app/jobs/pet_kibble_price_job.rb`, `monthly_kibble_price_job.rb` | The monthly run passes `notify: true`, which sends the email |
| `app/views/pets/show.html.erb`, `app/views/trackers/favorite_food.html.erb` | Links to the page |
| `config/locales/{en,ja,zh-TW}.yml` | `kibble_prices.*`, `kibble_price_mailer.*`, and the two link labels |

**The page, as built:**
- Shows the pet's **latest check**: the date it ran, then one card per favorite kibble in favorite order, including kibbles with no prices ("No shop listings found this time").
- Each card ranks prices cheapest NT$/kg first, with the cheapest highlighted. Columns: shop, product (linked to the shop's page, with the priced variant under it), price, bag size (the shop's label, plus the kg total when they differ: `3磅 (1.361 kg)`), NT$/kg, and a source badge: **✔ Listed · BigGo / PChome** or **Unverified** (Gemini).
- **On phones** the table becomes one card per price, since seven columns don't fit.
- A note under each list says where the prices came from and when; Gemini prices say they may be out of date.
- **Suspicious prices** sit in a collapsed "⚠ N suspicious prices" section with their reason (`-78% from NT$507/kg`), not in the ranking.
- A kibble that fell back to Gemini without a key shows "Add your Gemini API key in your profile…" with a link to the profile page.
- States: no check yet, checking now (pending), last check didn't finish (failed; the error stays in the logs), no favorite kibble in the last 4 months.
- **Links to shops** only become links when they're http(s), and open in a new tab with `rel="noopener noreferrer nofollow"`.
- **Refresh now** queues `PetKibblePriceJob` unless the pet was already checked today (then the button is replaced by "Checked today; you can refresh again tomorrow"). Also rate-limited to 5 per user per 10 minutes. A refresh doesn't send the email.
- Owner only: another user's pet redirects to the pet list, like the tracker pages.

**The email, as built:**
- Sent by the monthly run only, and only when the check found at least one ranked price.
- Same ranked lists per kibble (HTML with inline styles, plus a plain-text part); suspicious prices only as a count; a link to the page; the disclaimer.
- **Language:** users don't store a language (the site takes it from the URL), so the email follows the user's time zone: Asia/Taipei → 繁體中文, Asia/Tokyo → 日本語, otherwise English.
- **Not CC'd to the app's address**, unlike the backup and welcome emails: it's the owner's own price list, and nothing in it needs the admin.

**Checked in a browser:** a throwaway browser test (not committed) signed in as a test user with Aji's real prices from the local check, and took screenshots of the page in English and 繁體中文 on desktop, on a 390 px phone screen, and of the email. Two things were fixed from them: the intro printed `%{petname}` literally, and on phones the table squeezed product names into a narrow column and pushed the badge off screen (now cards).

**Results:**
- `bin/rails test`: 290 runs, 0 failures (10 new: page, refresh, owner-only, links, email languages, email rules).
- `bin/rails test:system`: 29 runs, 0 failures.
- `bin/rubocop`: no offenses. `bin/brakeman -w2`: no warnings.

## After merging: extra checks (2026-09-28)

| Check | Result |
|---|---|
| **Migration on PostgreSQL** (production's database; development, tests and CI use SQLite) | ✅ On a throwaway local PostgreSQL 15 database: loaded the schema from before this feature (`main` at `e1c5fb4`), ran `db:migrate` → both tables, the unique `(pet_id, checked_on)` index and the foreign keys were created. |
| **Whole test suite on PostgreSQL** | ✅ 290 runs, 0 failures (single process, against that database). The throwaway database was then dropped. |
| **Browser test for the page** (`test/system/kibble_prices_test.rb`, committed) | ✅ Profile → "Kibble Prices" → ranked table, badges, "no listings" and Gemini-key notes, opening the suspicious section; "Refresh now" queues a check and is replaced after a check that day; phones get cards instead of the table. |
| **"Refresh now" rate limit** (`test/controllers/rate_limit_test.rb`) | ✅ Over the limit: no search queued, redirected with the "Too many refreshes" alert. |
| **Gemini with a real API key** | ⏳ **Not run yet**: the local user has no Gemini key. Add one in the local profile, then run the lookup for 天然密碼 (the kibble BigGo and PChome found nothing for) to see a real Gemini answer. |

Totals after these: `bin/rails test` 291 runs and `bin/rails test:system` 32 runs, 0 failures; rubocop clean.

**Found along the way (older than this feature, not changed):** `db/schema.rb` has `add_foreign_key "dry_foods", "Users", column: "user_id"` with a capital `U`. SQLite ignores the case; PostgreSQL treats `"Users"` as a different table, so `db:schema:load` (or `db:prepare` on an **empty** PostgreSQL database, e.g. a new environment) fails with `relation "Users" does not exist`. Existing production isn't affected, as it's updated by migrations, not by loading the schema.

## How it works

```
MonthlyKibblePriceJob (1st of month, 6am)
  └─ per pet → PetKibblePriceJob   (one at a time across all users)
        1. Pet#favorite_kibbles                → top 5 kibbles by favorite score
        2. For each kibble, build a search query, e.g. "皇家 室內成貓 IN27"
        3. KibblePrices::BigGoSearch  (Nokogiri)   → listings: title, variant, price, store, link   [cached for the month]
        4. KibblePrices::PchomeSearch (JSON.parse) → listings (optional)                            [cached for the month]
        5. Gemini backup                           → only if steps 3 and 4 found nothing (checkpoint C)
        6. KibblePrices::Lookup                    → match, check bag size, flag suspicious prices, calculate NT$/kg, rank
        7. Save KibblePriceCheck + KibblePrices → email + in-app page
```

| Source | How it's read | Badge | When it's used |
|---|---|---|---|
| **BigGo** search page | Nokogiri, `[class*="ProductItemListPC_…"]` | ✔ Listed price | Always, the main source |
| **PChome** `ecshweb.pchome.com.tw/search/v4.3/all/results` | `JSON.parse` | ✔ Listed price | Always, optional extra |
| **Gemini** + Google Search | `JSON.parse` on its reply | Unverified | Only when both of the above found nothing for that kibble |
| Any unverified price ±40% from the listed prices | — | ⚠ Suspicious, not ranked | — |

---

## Steps

### 1. Share the "favorite kibble" logic ✅
- The grouping and scoring moved out of `TrackersController#favorite_food` into `Pet` (`app/models/pet.rb`):
  - `Pet#favorite_foods(food_type: nil)` — the full list the favorite-food page and its JSON use, unchanged.
  - `Pet#favorite_kibbles(min_score: 30, since: 4.months.ago, limit: 5)` (was 3 months until 2026-09-28; `Pet::FAVORITE_KIBBLE_WINDOW`) — kibble only (`Tracker.kibble`), fed on or after `since`, latest-day score ≥ `min_score`, most loved first. Each entry is the same hash as `favorite_foods` plus `dry_food:` — the bag it was last fed from, or `nil`.
- The controller now calls `@pet.favorite_foods(food_type: params[:food_type])`. Its output is unchanged.

### 2. Migration and models ✅ — see [Checkpoint C result](#checkpoint-c-result-2026-09-28) (adds `variant` and the check's `kibbles` summary)
- **`kibble_price_checks`**: `pet_id`, `checked_on` (date), `status` (pending / done / failed), `error_message`, timestamps.
  - Unique index on `[pet_id, checked_on]` to prevent a duplicate run for the same date.
- **`kibble_prices`**: `kibble_price_check_id`, `brand`, `description`, `favorite_score`, `store`, `url`, `product_title`, `price_twd`, `bag_size_label`, `bag_size_kg`, `price_per_kg`, `source` (enum: `biggo` / `pchome` / `gemini`), `suspicious` (boolean), `suspicious_reason`, timestamps.
  - `bag_size_label` (string) is the exact size the shop sells, as written in the listing (e.g. `"2kg x 2"`, `"3.3lb"`, `"4KG"`), for display.
  - `bag_size_kg` (decimal) is the total in kg (e.g. `4.0`, `1.5`), used only to calculate NT$/kg.
  - "Verified" is derived from `source`: biggo and pchome rows count as verified.
- Associations: `Pet has_many :kibble_price_checks`, `KibblePriceCheck has_many :kibble_prices`, both `dependent: :destroy`.
- Scopes:
  - `ranked` — not suspicious, ordered by `price_per_kg ASC`.
  - `flagged` — suspicious.

### 3. Shared helpers ✅
Built as `KibblePrices::Query`, `KibblePrices::Matcher`, `KibblePrices::BagSize` and `KibblePrices::PoliteHttp`; see [Checkpoint B result](#checkpoint-b-result-2026-09-28) for the rules as built. As planned:
- **`KibbleQuery.for(kibble)`** builds the search text from a `favorite_kibbles` entry: the linked bag's brand and description when `dry_food` is present, otherwise the tracker's. Strips noise ("x2", brackets, full-width characters — same cleanup as the current `favorite_food`) and keeps product-line codes like `IN27`.
- **`KibbleMatcher.match?(title, kibble)`** requires the brand (Chinese **or** English name, e.g. 皇家 / Royal Canin) **and** the product line or code to appear in the listing title.
- **`BagSize.parse(title)`** returns `{ kg:, label: }` — the total in kg plus the exact text matched in the title (`"1.5kg"` → 1.5, `"2公斤"` → 2, `"500g"` → 0.5, `"3.3lb"` → 1.5, `"2kg x 2"` → 4) — or **nil if the title has several different sizes** (multi-variant listings).
- **`PoliteHttp`**: small Net::HTTP wrapper — fixed User-Agent, 10-second timeouts, 2 MB read limit, no retries, and **only allows fixed host + path pairs** (`biggo.com.tw` search pages, `ecshweb.pchome.com.tw/search/v4.3/`). Paths disallowed by robots.txt (BigGo `/r/`) are rejected.

### 4. `BigGoSearchService` (Nokogiri, main source) ✅ — built as `KibblePrices::BigGoSearch`
- Request BigGo's search page for `{query}` (exact URL pattern confirmed in checkpoint B), **page 1 only**.
- For each listing: title, price (digits only → integer), store name, link. **As built:** the link is the shop's own URL taken from the `purl` parameter of BigGo's `/r/…` redirect, which is never fetched. A multi-variant listing uses its priced variant's price.
- Selectors are written in checkpoint B from a saved copy of a real page and kept in constants so they're easy to fix.
- **Cache:** `Rails.cache.fetch("biggo:#{query}:#{month}", expires_in: 35.days)` (Solid Cache, database-backed), so many users feeding the same kibble cause **one request per month**.
- **0 listings with HTTP 200** (a sign the layout changed): log a warning and send at most one alert per day to the admin via the existing `DiagnosticsMailer`.

### 5. `PchomeSearchService` (JSON, optional) ✅ — built as `KibblePrices::PchomeSearch`
- Request `ecshweb.pchome.com.tw/search/v4.3/all/results?q={query}&page=1`, read `Prods[]` → `Name`, `Price`, link built from `Id`.
- Same monthly cache. **As built:** an empty result is normal (PChome's search is loose), so the admin alert only fires when the answer isn't JSON or has no `Prods` list.
- Undocumented endpoint: any error means no PChome results, and the run carries on.

### 6. `GeminiKibbleSearchService` (backup) ✅ — built as `KibblePrices::GeminiSearch`
- Follows `GeminiOcrService`: key in `x-goog-api-key`, timeouts.
- Request uses `tools: [{ google_search: {} }]` and asks for **JSON only**: `[{store, url, price_twd, product_title}]`.
- **Only called when steps 4 and 5 found nothing** for a kibble.
- No user key: skip this step (with a note on the page); don't fail the run.

### 7. `KibblePriceLookup` (combine and check) ✅ — built as `KibblePrices::Lookup`, except the Gemini parts (checkpoint C)
For each kibble: collect BigGo and PChome listings, then fall back to Gemini if both are empty.

- **Filter:**
  - `KibbleMatcher.match?` must pass.
  - `BagSize.parse` must return one size.
  - Price between NT$50 and NT$20,000.
  - Gemini rows must also have a URL and a title.
- **Remove duplicates:** keep the cheapest listing per store and bag size.
- **Check Gemini rows** ✅ *(changed in checkpoint C)*: an unverified row more than ±40% from a reference NT$/kg is marked `suspicious`, with the reason saved. The reference is the median listed price from the pet's latest earlier check, or else the median of Gemini's own offers when there are at least 3 (same-check listed prices never exist when Gemini runs).
- **Calculate and rank:** `price_per_kg = price_twd / bag_size_kg` (1 decimal place), keep the **top 8** per kibble.

### 8. Jobs and schedule ✅ — email step waits for checkpoint D
- **`MonthlyKibblePriceJob`**: users with kibble trackers in the last 30 days → one `PetKibblePriceJob` per pet. Logs a count, like `UserBackupJob`. No Gemini key required.
- **`PetKibblePriceJob`**:
  - `limits_concurrency to: 1, key: "kibble_price_search"` — only one search at a time across all users; about 2 seconds between uncached requests.
  - Creates the check (skips if one already exists for that date), runs the lookup, saves the results.
  - Marks the check done or failed; with `notify: true` (the monthly run) sends the email when done and there are ranked prices.
- `config/recurring.yml` under `production:`:
  ```yaml
  monthly_kibble_prices:
    class: MonthlyKibblePriceJob
    schedule: every month on the 1st at 6am   # as built; the original wording isn't a valid repeating schedule
  ```

### 9. In-app page ✅ — see [Checkpoint D result](#checkpoint-d-result-2026-09-28)
- Route: `resources :pets { resources :kibble_prices, only: [:index, :create] }`.
- **`index`** — latest check, grouped by kibble with its favorite score:
  - **Ranked table**, cheapest NT$/kg first: store, product title (linked), price, bag size (shop's label with the kg total, e.g. "2kg x 2 (4 kg)"), NT$/kg, source badge (✔ Listed price — BigGo/PChome, or Unverified).
  - Source note: "Listed price via BigGo on {date}" or "From Google search results, may be outdated".
  - Collapsed **"⚠ Suspicious prices"** section with reasons.
  - "No listings found" for kibbles with no results.
- **`create`** — "Refresh now" button, limited to once a day per pet, queues `PetKibblePriceJob` (monthly cache still applies).
- Links from the pet page and the favorite-food page.
- Owner-only access, like the other pet pages. Tailwind styling to match.

### 10. Email ✅ — language follows the user's time zone; not CC'd to the admin
- `KibblePriceMailer#monthly_report(check)`: HTML ranked table in the user's locale with source badges. Suspicious rows only as a count, with a link to the in-app page.
- Follows the `UserBackupMailer` pattern.

### 11. Translations ✅
- Keys in `config/locales/en.yml`, `ja.yml`, `zh-TW.yml` for the page, badges, source notes and email.

### 12. Tests (no real network calls; saved copies of real pages)
- **Model:** `Pet#favorite_kibbles`; existing `favorite_food` tests still pass.
- **Helpers:**
  - `KibbleQuery` cleanup.
  - `KibbleMatcher`: Chinese and English brand names; rejects a different product line.
  - `BagSize`: kg, g, 公斤, lb, multi-packs, several sizes (nil), no size; label keeps the shop's original text.
  - `PoliteHttp` rejects hosts and paths not on its list, including BigGo `/r/`.
- **`BigGoSearchService`:** parses a saved real BigGo page into rows (title, price, store, link); cache prevents a second request; empty page triggers the alert.
- **`PchomeSearchService`:** saved JSON response; error returns an empty list.
- **`GeminiKibbleSearchService`:** stubbed reply, JSON in a code block, missing fields.
- **Lookup:** matching and filters; multi-variant rows dropped; duplicates removed; Gemini only called when nothing is listed; ±40% suspicious flag; NT$/kg math and top-8 ranking.
- **Jobs:** which users qualify, unique check per date, concurrency limit, one failure doesn't stop the others.
- **Controller:** index sections, owner-only access, once-a-day refresh limit.
- **Mailer:** subject, locale, badges, suspicious count.

---

## Build order and checkpoints

| # | Build | Checkpoint |
|---|---|---|
| 0 | Terms review | ✅ Done — feebee rejected; BigGo confirmed |
| A | Step 1 (refactor) | ✅ Done — all tests pass and `favorite_food` behaves the same |
| B | Inspect BigGo listing HTML, then Steps 3 → 4 → 5 → 7 (Gemini skipped for now) | ✅ Done — console run on Aji's 5 kibbles; 4 review questions answered |
| C | Step 6 (Gemini backup), then Steps 2 and 8 | ✅ Done — job ran end to end locally; Gemini path taken only for the kibble with nothing listed |
| D | Steps 9, 10, 11 | ✅ Done — screenshots of the page (desktop, phone, 2 languages) and the email reviewed; 2 layout fixes made |
| E | Step 12 + `bin/rubocop` + CI | ✅ Done — 290 tests and 29 browser tests pass on the merged `main`; GitHub CI on `main` passed (scan_ruby, test, scan_js, lint) |

## Risks and how the plan handles them

| Risk | How it's handled |
|---|---|
| Comparison site's terms | Checked at checkpoint 0: feebee dropped, BigGo has no scraping clause; re-check BigGo's terms before each release |
| Being blocked | One request per query per month shared across users; one search at a time; never fetch disallowed paths (`/r/`) |
| BigGo's layout changes | Selectors in constants; tests against a saved page; admin alert on 0 listings; Gemini fallback |
| Wrong product matched | Brand plus product line must both appear in the title; product title shown |
| Multi-variant or multi-pack listings | `BagSize` drops titles with several sizes and handles multiplied packs |
| Comparison site's price slightly out of date | "Listed price via BigGo on {date}" shown, with a link to the store |
| Wrong Gemini prices | Backup only, labelled unverified, ±40% suspicious check |
| PChome endpoint changing | Optional; fails without breaking anything |
| Security | Fixed list of allowed hosts and paths; owner-only pages; Gemini key sent in a header |
