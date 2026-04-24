# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/ritahuang/Library/Android/sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.

# Hotwire Native / Turbo rules
-keep class dev.hotwire.navigation.** { *; }
-keep class dev.hotwire.core.** { *; }

# Keep your model classes if they are used for JSON serialization
-keep class com.pettracker.v4.models.** { *; }
-dontwarn javax.lang.model.element.Modifier
