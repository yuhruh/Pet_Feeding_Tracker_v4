// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    id("com.android.application") version "9.1.1" apply false
    id("org.jetbrains.kotlin.android") version "2.2.10" apply false
    // Firebase Cloud Messaging (checkpoint I); applied by the app only when google-services.json is there.
    id("com.google.gms.google-services") version "4.4.2" apply false
}
