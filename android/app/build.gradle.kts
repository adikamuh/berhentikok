import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// keystore config
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

// def localProperties = new Properties()
// def localPropertiesFile = rootProject.file('local.properties')
// if (localPropertiesFile.exists()) {
//     localPropertiesFile.withReader('UTF-8') { reader ->
//         localProperties.load(reader)
//     }
// }

// def flutterRoot = localProperties.getProperty('flutter.sdk')
// if (flutterRoot == null) {
//     throw GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
// }

// def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
// if (flutterVersionCode == null) {
//     flutterVersionCode = '1'
// }

// def flutterVersionName = localProperties.getProperty('flutter.versionName')
// if (flutterVersionName == null) {
//     flutterVersionName = '1.0'
// }

// apply plugin: 'com.android.application'
// // START: FlutterFire Configuration
// apply plugin: 'com.google.gms.google-services'
// // END: FlutterFire Configuration
// apply plugin: 'kotlin-android'
// apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    namespace = "com.lbstudio12.berhentikok"
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    // sourceSets {
    //     main.java.srcDirs += 'src/main/kotlin'
    // }

    defaultConfig {
        applicationId = "com.lbstudio12.berhentikok"
        minSdk = 26
        targetSdk = 36
        compileSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    // Add other dependencies here if needed
}
