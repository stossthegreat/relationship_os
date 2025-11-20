#!/bin/bash

# RelationshipOS Build and Test Script
# This script helps build and test the APK after the crash fixes

echo "🔧 RelationshipOS Build and Test Script"
echo "======================================="

# Clean the project
echo "🧹 Cleaning project..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Analyze the code
echo "🔍 Analyzing code..."
flutter analyze

# Build debug APK
echo "🏗️  Building debug APK..."
flutter build apk --debug

# Build release APK
echo "🚀 Building release APK..."
flutter build apk --release

echo "✅ Build completed!"
echo ""
echo "📱 APK locations:"
echo "Debug APK: build/app/outputs/flutter-apk/app-debug.apk"
echo "Release APK: build/app/outputs/flutter-apk/app-release.apk"
echo ""
echo "🔍 To test on device:"
echo "adb install build/app/outputs/flutter-apk/app-release.apk"
echo ""
echo "📋 To check logs if app crashes:"
echo "adb logcat | grep -E '(flutter|relationshipos|AndroidRuntime)'"
