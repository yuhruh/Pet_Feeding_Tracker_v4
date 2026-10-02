# Pet Tracker v4 Usage Guide

This guide provides detailed instructions on how to use the key features of Pet Tracker v4.

## Table of Contents

- [User Account](#user-account)
  - [Creating an Account](#creating-an-account)
  - [Signing In](#signing-in)
  - [Third-Party Sign-In](#third-party-sign-in)
  - [Timezone](#timezone)
- [Pet Management](#pet-management)
  - [Adding a Pet](#adding-a-pet)
  - [Viewing and Editing Pets](#viewing-and-editing-pets)
  - [Deleting a Pet](#deleting-a-pet)
- [Dry Food Management](#dry-food-management)
  - [Adding Dry Food](#adding-dry-food)
  - [Managing Inventory](#managing-inventory)
- [Trackers](#trackers)
  - [Creating a Tracker](#creating-a-tracker)
  - [Favorite Food](#favorite-food)
  - [Importing Trackers from CSV](#importing-trackers-from-csv)
- [Households: Caregivers and Viewers](#households-caregivers-and-viewers)
  - [Inviting a Caregiver](#inviting-a-caregiver)
  - [Viewer Links](#viewer-links)
  - [Litter Boxes and Water Spots](#litter-boxes-and-water-spots)
  - [Members, Leaving and Handing Over](#members-leaving-and-handing-over)
- [The Today Page](#the-today-page)
  - [Recording Care](#recording-care)
  - [Fixing a Record: Undo, Change, Delete](#fixing-a-record-undo-change-delete)
  - [Litter Observations](#litter-observations)
  - [Medications](#medications)
- [Reminders](#reminders)
- [Care Records CSV](#care-records-csv)
- [Android App](#android-app)
- [Kibble Prices](#kibble-prices)
  - [Which Kibbles Are Checked](#which-kibbles-are-checked)
  - [Reading the Prices Page](#reading-the-prices-page)
  - [Refreshing and the Monthly Email](#refreshing-and-the-monthly-email)
- [Progressive Web App (PWA)](#progressive-web-app-pwa)

## User Account

Your user account is the central hub for managing your pets and tracking their activities.

### Creating an Account

1.  **Sign Up:** Navigate to the "Sign Up" page.
2.  **Enter Your Details:** Provide your email address and a secure password.
3.  **Register:** Click the "Sign Up" button to create your account.

### Signing In

1.  **Sign In:** Go to the "Sign In" page.
2.  **Enter Your Credentials:** Enter your email and password.
3.  **Access Your Account:** Click the "Sign In" button to access your dashboard.

### Third-Party Sign-In

You can also sign in with **Google**, **LINE** or **GitHub**. If you sign in with LINE, weight and care reminders are sent to you on LINE instead of by email (unless you get them in the Android app). In the Android app, these buttons open a Chrome tab over the app; after choosing your account you're back in the app, signed in.

### Timezone

The app will automatically detect your local timezone when setting up your account to ensure all tracking data is accurate. You can also manually update your timezone in your user settings.

## Pet Management

The "Pets" section allows you to create and manage profiles for each of your pets.

### Adding a Pet

1.  **Go to Pets:** Navigate to the "Pets" section from the main menu.
2.  **New Pet:** Click the "New Pet" button.
3.  **Enter Pet Details:** Fill in your pet's name, species, and other relevant information.
4.  **Save:** Click "Create Pet" to save the profile.

### Viewing and Editing Pets

-   **View:** Click on a pet's name to see their detailed profile.
-   **Edit:** From the pet's profile page, click "Edit" to update their information.

### Deleting a Pet

-   **Delete:** From the pet's profile page, click "Delete" to remove their profile.

## Dry Food Management

The "Dry Food Management" feature helps you keep track of your pet's dry food inventory.

### Adding Dry Food

1.  **Go to Dry Foods:** Navigate to the "Dry Foods" section.
2.  **New Dry Food:** Click the "New Dry Food" button.
3.  **Enter Food Details:** Provide the brand, name, and quantity of the dry food.
4.  **Save:** Click "Create Dry Food" to add it to your inventory.

### Managing Inventory

-   **View:** See a list of all your dry foods and their current quantities.
-   **Show:** Click on a dry food item to see more details.
-   **Edit:** Update the details or quantity of a dry food entry.
-   **Delete:** Remove a dry food entry from your inventory.

## Trackers

Trackers are used to log your pet's daily activities, such as feeding times, walks, and health observations.

### Creating a Tracker

1.  **Go to Trackers:** Navigate to the "Trackers" section for a specific pet.
2.  **New Tracker:** Click the "New Tracker" button.
3.  **Enter Details:** Fill in the activity details, such as the type of activity, time, and any notes.
4.  **Save:** Click "Create Tracker" to log the activity.

### Favorite Food

The "Favorite Food" list ranks every food your pet has eaten by how much it loved it. Each meal gets a **favorite score** from how hungry your pet was, how much it loved the food, how much it left, and how often it came back to eat. The list shows each food's five best days.

1.  **Open the list:** In the menu, open "Trackers" → "*Pet*'s Favorite List".
2.  **Filter** by food type if you only want to see, for example, kibble.
3.  **See prices:** use the "Kibble prices" link at the top to see where your pet's favorite kibbles are cheapest (see [Kibble Prices](#kibble-prices)).

### Importing Trackers from CSV

For bulk data entry, you can import trackers from a CSV file.

1.  **Go to Trackers:** Navigate to the "Trackers" section for a specific pet.
2.  **Import CSV:** Click the "Import CSV" button.
3.  **Choose File:** Select the CSV file you want to import.
4.  **Upload:** Click "Import" to upload and process the file.

The file must be **semicolon-separated** (`;`), in the same format as the CSV you download from the Trackers page, so the easiest start is to export first and edit that file. Its columns are:

`date; feed_time; come_back_to_eat; food_type; brand; description; amount; left_amount; total_ate_amount; hungry; love; result; note; weight`

Every row is checked before anything is saved: dates must be valid and not before your pet's birthday, and amounts and weight must be numbers. If any row has a problem, nothing is imported and you'll see which rows to fix.

## Households: Caregivers and Viewers

Your cats, food bags, litter boxes and water spots form your **household**. You're its **owner**: you manage everything. You can let others help:

-   **Caregivers** (family, a pet sitter) record feeding, litter, water and medicine, and can read your trackers and charts. They need an account.
-   **Viewers** (say, Grandma) see today's status, the timeline and the charts, read-only. They use a personal link and don't need an account.

Open the household page from the menu (**🏠 My household**) or your account page.

### Inviting a Caregiver

1.  **Enter their email** under "Invite a caregiver" and send the invitation.
2.  **They open the link** in the email, create an account (or sign in with Google or LINE using the same email) and join. The link works once, for 7 days, and only for that email.
3.  **They land on Today**, with buttons for your cats.

### Viewer Links

1.  **Create a link** under "Viewer links", with a name (e.g. "Grandma") and, if you like, an expiry.
2.  **Copy it** and send it by LINE or email. Each viewer gets their own link.
3.  **Turn it off** at any time; it stops working at once. A viewer who signs up or signs in from the page gets your household in their account.

### Litter Boxes and Water Spots

Under "Litter boxes and water spots": add, rename, choose bowl or fountain, move up or down, and remove. Each one has a line per job for **reminders** (see [Reminders](#reminders)): Off, every few hours or days, or at set times. Save with the spot's **Save** button.

### Members, Leaving and Handing Over

-   **Remove** a caregiver or viewer from the household page; they can also **Leave** from their account page.
-   **Hand the household over** to a member under "Hand the household to someone else": once they accept, they become the owner and you stay on as a caregiver.
-   **Your own cats too:** someone who only helps can add their own cat from their account page ("Add my own cat"), which creates their own household.

## The Today Page

**Today** shows each household you're in: a row per litter box and water spot, a card per cat, and a **timeline of the last 24 hours**. Everyone's changes appear without reloading.

### Recording Care

-   **One tap** records what you did, now: 🍽 **Fed**, ⚖️ **Weight** (enter the kg), 💊 **Meds**, 🚽 **Scooped** / ♻️ **Full change**, 💧 **Refilled** / 🧽 **Cleaned** / 🔄 **Filter changed**.
-   **A notice** appears with **Undo** (10 seconds), **5 · 10 · 15 min ago** to change the time, and **Add details**. For water, tick the other jobs you did in the same notice.
-   **"Record it again?"** appears if the same care was just recorded (by anyone): feeding and water within 30 minutes, the same litter job within 30 minutes.
-   **Feeding details** (food type, brand, amount) suggest your household's food bags and your cat's favorites. The owner can turn a feeding into a full tracker with **Add to trackers**.

### Fixing a Record: Undo, Change, Delete

-   **Undo** right after a tap (10 seconds).
-   **Change** on the timeline: the time (up to 7 days back), the jobs, the details or a note.
-   **Delete** on the timeline or the details page removes a mistaken record from Today, the charts, the CSV and reminders, after you confirm.
-   **Who:** the owner can change and delete any record; a caregiver their own records, for 24 hours.

### Litter Observations

In a litter record's **Add details**: which cat (if you know), pee clumps, the number of poops, the stool, and anything unusual (blood, very large clumps, other). Diarrhea and anything unusual show in red. With a cat chosen, they also appear on that cat's trackers page for 30 days.

### Medications

1.  **The owner adds medications** per cat (cat profile → **Medications**): name, dose, up to 4 times a day (or none for "as needed"), and dates.
2.  **💊 Meds** on Today offers today's doses not yet recorded: **Given**, or **Couldn't give** with a reason.
3.  **Each dose shows** due, given (green), couldn't give (amber) or overdue (red, an hour after its time). Recording a dose already given asks first.

## Reminders

-   **Set them up (owner):** on the household page, for each litter box and water spot job, choose how often: **3 times a day, twice a day, daily, twice a week, weekly, every 2 weeks, twice a month, monthly, custom** (hours or days), counted from the last time it was done; or **at set times** (up to 6, e.g. 08:00 and 20:00).
-   **See them on Today:** "🧽 Fountain cleaned due in 4 days", "🚽 Scooped due at 20:00", or for set times "08:00 ✓ 07:55 by Mom · 20:00 due".
-   **Get them:** under your household's name on Today, tap **Turn on** next to 🔔 Reminders. Each owner and caregiver chooses for themselves; viewers don't get reminders.
-   **When:** a job due on a day is sent at **9am** in your time zone; a shorter interval when it's due, between 9am and 9pm; a set time at that time. If it's still not done, there's one follow-up. Overdue doses are reminded once.
-   **How:** in the **Android app** if you use it, else on **LINE** if you signed in with LINE, else by **email**.

## Care Records CSV

The owner can download every care record (feeding taps, weight, litter, water, medicine) from the household page: **Download care records (CSV)**, in your household's time zone.

## Android App

-   **Sign in** with email, or with Google, LINE or GitHub (a Chrome tab opens over the app and brings you back signed in).
-   **Notifications:** turning on 🔔 Reminders on Today asks to allow notifications (Android 13+). Reminders then arrive as notifications; tapping one opens Today. You can adjust the "Reminders" channel in Android's settings.
-   **Signing out** of the app stops notifications on that phone.

## Kibble Prices

Pet Tracker checks what your pet's favorite kibbles cost in Taiwan's online shops, so you can buy the one your pet loves at the best price.

### Which Kibbles Are Checked

-   Kibbles on your pet's Favorite Food list with a **favorite score of 30 or more**, fed in the **last 4 months** (up to 5 kibbles).
-   Prices come from **BigGo**, a price-comparison site that covers shops such as Shopee, momo, Yahoo, Coupang and Rakuten, and from **PChome 24h**.
-   Name the food the way it's sold: brand plus product name, e.g. brand `曙光`, description `無穀滋養鴨肉食譜`. Include the flavor (鴨肉, 雞肉…) and any product code (IN27…). The app uses these to tell the right product from similar ones. If you use both a Chinese and an English brand name (`喵皇奴 purrsuit`), either one is matched.

### Reading the Prices Page

1.  **Open it:** go to your pet's profile and click **Kibble Prices**, or use the link on the Favorite List.
2.  **One card per kibble**, in favorite order. Prices are ranked by **price per kg**, cheapest first, so bags of different sizes compare fairly. The bag size shows as the shop writes it, with the total in kg when they differ, e.g. `3磅 (1.361 kg)`.
3.  **Click a product** to open the shop's page. Each price shows where it was found (BigGo or PChome) and when.
4.  **"Can't find this kibble in shops right now."** means neither BigGo nor PChome lists it at the moment. Check the brand and description spelling in your trackers.

Prices are approximate and shops change them often, so check the shop before buying.

### Refreshing and the Monthly Email

-   Prices are checked automatically on the **1st of every month**, and you get an email with the results when prices were found. The email is in 繁體中文, 日本語 or English, based on your time zone.
-   Click **Refresh now** on the page to check today. You can refresh once a day per pet; the results appear after a minute or so, so reload the page.

## Progressive Web App (PWA)

You can install Pet Tracker v4 on your mobile device for easy access.

1.  **Open in Browser:** Open the application in a supported browser on your mobile device.
2.  **Add to Home Screen:** Follow the browser's prompts to "Add to Home Screen" or "Install."
3.  **Launch:** Launch the app from your home screen like a native app.