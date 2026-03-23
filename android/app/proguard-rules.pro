# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# HTTP
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**

# Flutter Secure Storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# HTML parser
-keep class org.jsoup.** { *; }
-dontwarn org.jsoup.**

# General
-keepattributes *Annotation*
-keepattributes Signature

# Play Core - not used but referenced by Flutter internals
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }
