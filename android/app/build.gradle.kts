// In android/app/build.gradle.kts

import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Function to read version info from Flutter's generated properties
fun getFlutterVersionCode(): Int {
    val props = Properties()
    val propertiesFile = rootProject.file("local.properties")
    if (propertiesFile.exists()) {
        propertiesFile.inputStream().use { props.load(it) }
    }
    return props.getProperty("flutter.versionCode")?.toInt() ?: 1
}

fun getFlutterVersionName(): String {
    val props = Properties()
    val propertiesFile = rootProject.file("local.properties")
    if (propertiesFile.exists()) {
        propertiesFile.inputStream().use { props.load(it) }
    }
    return props.getProperty("flutter.versionName") ?: "1.0"
}

android {
    // *** CHANGED FOR LUC APP ***
    namespace = "com.example.luc"
    compileSdk = 36 // A stable, modern SDK version
    ndkVersion = "27.0.12077973" // A standard ndkVersion

    // Using Java 17 configuration from your example
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // *** CHANGED FOR LUC APP ***
        applicationId = "com.example.luc"
        minSdk = 24  // Fixed syntax
        targetSdk = 34
        versionCode = getFlutterVersionCode()
        versionName = getFlutterVersionName()
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    
    // APK Renaming Logic - We will add this AFTER the build succeeds.
    // For now, the goal is to fix the build error.
}

dependencies {
    // --- DEPENDENCIES FOR LUC APP ---

    // Firebase Bill of Materials (BOM) - Manages versions for all Firebase libs
    implementation(platform("com.google.firebase:firebase-bom:33.1.1"))

    // Add the Firebase products your app needs
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-storage")
    implementation("com.google.firebase:firebase-messaging")
    implementation("com.google.firebase:firebase-analytics")
    
    // AndroidX & Kotlin
    implementation("androidx.core:core-ktx:1.10.1")
    implementation("androidx.multidex:multidex:2.0.1")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.8.0") // From your example
}

flutter {
    source = "../.."
}