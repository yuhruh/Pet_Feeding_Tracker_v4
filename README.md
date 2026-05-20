# Pet Tracker v4

Pet Tracker v4 is a web application designed to help you accurately monitor your pet's health and daily dietary preference. Keep track of your pet's food intake, activities, and more.

## Features

*   **Pet Management:** Add and manage profiles for multiple pets.
*   **Health Record Management:** Track your pet's annual health checkups and blood test results.
*   **AI Data Extraction:** Upload health checkup images and let Gemini AI automatically extract medical data.
*   **Smart Inventory Management:** Track dry food inventory with automatic calculation of remaining food and predicted run-out dates based on consumption patterns.
*   **Dietary Tracking & Preference Analysis:** Log daily feeding records and identify your pet's favorite foods using a custom scoring algorithm based on their reactions and intake.
*   **Comprehensive Data Visualization:** Interactive charts for monitoring food consumption (dry/wet) and weight trends over time, including specialized tracking for boarding stays.
*   **Sharing:** Generate shareable links to let others (like vets or sitters) view your pet's records.
*   **User Authentication:** Secure accounts with email/password or third-party providers (Google, LINE).
*   **Data Portability & Bulk Operations:** Import/export tracker data from CSV and efficiently manage large datasets with bulk deletion features.
*   **Automated Backups:** Receive automated CSV backups via email every 5 days.
*   **Smart Notifications:** Stay informed with weight reminders and important updates via email or LINE messenger.
*   **Multilingual Support:** Fully localized interface with support for multiple languages and accurate timezone-based tracking.
*   **Progressive Web App (PWA):** Install the application on your mobile device for easy access.

## Technical Highlights

*   **Rails 8 Foundation:** Built with the latest Rails 8 features for performance and reliability.
*   **Modern Database Adapters:** Utilizes `Solid Cache`, `Solid Queue`, and `Solid Cable` for database-backed caching, background jobs, and real-time features.
*   **Gemini AI Integration:** Leverages Google's Gemini AI for intelligent medical data extraction from health records.
*   **Deployment Ready:** Includes `Kamal` configuration for easy deployment and `Thruster` for HTTP asset caching and acceleration.
*   **Localized Experience:** Full internationalization (i18n) support for global usability.

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
5.  **Monitor diet:** Use the "Trackers" section to log daily feeding records. View interactive charts to monitor intake trends and use the **Favorite Food** analysis to identify your pet's most loved meals.
6.  **Manage food storage:** Use the "Dry Foods" section to track inventory. The system automatically predicts when you'll run out of food based on current feeding habits.
7.  **Share records:** Generate a shareable link for your pet to allow others (like vets or sitters) to view their dietary and health history.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License.