// In android/build.gradle.kts

import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

buildscript {
    val kotlin_version = "1.8.0" // From your working example

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
    dependencies {
        // Using versions from your working example for compatibility
        classpath("com.android.tools.build:gradle:8.2.2") // A common stable version
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")
        classpath("com.google.gms:google-services:4.4.1")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://jitpack.io")
        }
    }
}

// Build directory configuration from your example
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
    delete(project.layout.buildDirectory)
}