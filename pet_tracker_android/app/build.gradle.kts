import java.util.Properties
import java.io.FileInputStream

plugins {
    id("org.jetbrains.kotlin.android")
    id("com.android.application")
}

android {
    namespace = "com.pettracker.v4"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.pettracker.v4"
        minSdk = 28
        targetSdk = 35
        versionCode = 4
        versionName = "1.0.3"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    signingConfigs {
        create("release") {
            val keystorePropertiesFile = rootProject.file("keystore.properties")
            val keystoreProperties = Properties()
            
            if (keystorePropertiesFile.exists()) {
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
                
                storeFile = rootProject.file(keystoreProperties["RELEASE_STORE_FILE"] ?: "pet-tracker-key.jks")
                storePassword = keystoreProperties["RELEASE_STORE_PASSWORD"]?.toString()
                keyAlias = keystoreProperties["RELEASE_KEY_ALIAS"]?.toString()
                keyPassword = keystoreProperties["RELEASE_KEY_PASSWORD"]?.toString()
            }
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            signingConfig = signingConfigs.getByName("release")
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
    buildFeatures {
        viewBinding = true
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.11.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    
    // Hotwire Native dependencies
    implementation("dev.hotwire:core:1.2.6")
    implementation("dev.hotwire:navigation-fragments:1.2.6")

    // Chrome Custom Tabs
    implementation("androidx.browser:browser:1.7.0")
    
    // Splash Screen
    implementation("androidx.core:core-splashscreen:1.0.1")

    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}
