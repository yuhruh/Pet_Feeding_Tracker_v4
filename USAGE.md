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

You can also sign in with **Google**, **LINE** or **GitHub**. If you sign in with LINE, weight reminders are sent to you on LINE instead of by email.

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