# Pet Tracker v4

Pet Tracker v4 is a web application designed to help you accurately monitor your pet's health and daily dietary preference. Keep track of your pet's food intake, activities, and more.

## Features

*   **Pet Management:** Add and manage profiles for multiple pets.
*   **Health Record Management:** Track your pet's annual health checkups and blood test results.
*   **AI Data Extraction:** Upload health checkup images and let Gemini AI automatically extract medical data.
*   **Food Tracking:** Monitor dry food consumption and inventory levels.
*   **Dietary Tracking:** Log daily feeding records, including food types, amounts, and your pet's reactions.
*   **Sharing:** Generate shareable links to let others (like vets or sitters) view your pet's records.
*   **User Authentication:** Secure accounts with email/password or third-party providers (Google, LINE).
*   **Data Portability:** Import tracker data from CSV and export records for local backup.
*   **Automated Backups:** Receive automated CSV backups via email every 5 days.
*   **Timezone Support:** Fully localized time tracking for accurate feeding schedules.
*   **Progressive Web App (PWA):** Install the application on your mobile device for easy access.

## Getting Started

To get started with Pet Tracker v4, you'll need to have the following installed:

*   Ruby
*   Rails
*   PostgreSQL

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/pet_tracker_v4.git
    ```
2.  **Install dependencies:**
    ```bash
    bundle install
    npm install
    ```
3.  **Create and set up the database:**
    ```bash
    rails db:create
    rails db:migrate
    ```
4.  **Start the server:**
    ```bash
    rails server
    ```

## How to Use

1.  **Create an account:** Sign up for a new account or sign in with a third-party provider (Google/LINE).
2.  **Configure Timezone:** Set your local timezone in your profile to ensure feeding times are recorded accurately.
3.  **Add a pet:** Go to the "Pets" section and add a new pet profile.
4.  **Track health:** In the "Health Checks" section, upload lab results and use Gemini AI to automatically populate your pet's medical data.
5.  **Monitor diet:** Use the "Trackers" section to log daily feeding records. You can also import existing data from a CSV file.
6.  **Manage food storage:** Track dry food inventory to know when it's time to restock.
7.  **Share records:** Generate a shareable link for your pet to allow others to view their dietary and health history.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License.