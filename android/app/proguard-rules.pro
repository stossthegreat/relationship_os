# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Gson specific classes
-keepattributes Signature
-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }

# SharedPreferences
-keep class * extends android.content.SharedPreferences { *; }

# Keep all native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep all classes that have native methods
-keepclasseswithmembers class * {
    native <methods>;
}

# Riverpod specific rules
-keep class * extends riverpod.** { *; }
-keep class **.*Provider* { *; }

# Keep MainActivity
-keep class app.relationshipos.MainActivity { *; }
