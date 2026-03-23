import "package:flutter/material.dart";

class OrangeTheme {
  final TextTheme textTheme;

  const OrangeTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff895020),
      surfaceTint: Color(0xff895020),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdcc4),
      onPrimaryContainer: Color(0xff6d3a09),
      secondary: Color(0xff745945),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdcc4),
      onSecondaryContainer: Color(0xff5b412f),
      tertiary: Color(0xff5d6136),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe3e7af),
      onTertiaryContainer: Color(0xff464a20),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff221a14),
      onSurfaceVariant: Color(0xff52443b),
      outline: Color(0xff84746a),
      outlineVariant: Color(0xffd6c3b7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f28),
      inversePrimary: Color(0xffffb781),
      primaryFixed: Color(0xffffdcc4),
      onPrimaryFixed: Color(0xff2f1400),
      primaryFixedDim: Color(0xffffb781),
      onPrimaryFixedVariant: Color(0xff6d3a09),
      secondaryFixed: Color(0xffffdcc4),
      onSecondaryFixed: Color(0xff2a1707),
      secondaryFixedDim: Color(0xffe4bfa7),
      onSecondaryFixedVariant: Color(0xff5b412f),
      tertiaryFixed: Color(0xffe3e7af),
      onTertiaryFixed: Color(0xff1a1d00),
      tertiaryFixedDim: Color(0xffc6ca95),
      onTertiaryFixedVariant: Color(0xff464a20),
      surfaceDim: Color(0xffe7d7ce),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e9),
      surfaceContainer: Color(0xfffbebe1),
      surfaceContainerHigh: Color(0xfff5e5dc),
      surfaceContainerHighest: Color(0xfff0dfd6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff572a00),
      surfaceTint: Color(0xff895020),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9b5f2d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff48311f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff846752),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff353911),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c7043),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff17100a),
      onSurfaceVariant: Color(0xff40342b),
      outline: Color(0xff5e5046),
      outlineVariant: Color(0xff7a6a60),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f28),
      inversePrimary: Color(0xffffb781),
      primaryFixed: Color(0xff9b5f2d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff7e4717),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff846752),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6a4f3c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c7043),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff54582d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd3c4bb),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e9),
      surfaceContainer: Color(0xfff5e5dc),
      surfaceContainerHigh: Color(0xffeadad1),
      surfaceContainerHighest: Color(0xffdecfc6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff482200),
      surfaceTint: Color(0xff895020),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff703c0c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3d2716),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5d4431),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2b2e08),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff484c22),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff352a22),
      outlineVariant: Color(0xff54463d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f28),
      inversePrimary: Color(0xffffb781),
      primaryFixed: Color(0xff703c0c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff522700),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5d4431),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff442e1c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff484c22),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff32350e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5b6ad),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffeeee4),
      surfaceContainer: Color(0xfff0dfd6),
      surfaceContainerHigh: Color(0xffe1d1c8),
      surfaceContainerHighest: Color(0xffd3c4bb),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb781),
      surfaceTint: Color(0xffffb781),
      onPrimary: Color(0xff4e2600),
      primaryContainer: Color(0xff6d3a09),
      onPrimaryContainer: Color(0xffffdcc4),
      secondary: Color(0xffe4bfa7),
      onSecondary: Color(0xff422b1a),
      secondaryContainer: Color(0xff5b412f),
      onSecondaryContainer: Color(0xffffdcc4),
      tertiary: Color(0xffc6ca95),
      onTertiary: Color(0xff2f330c),
      tertiaryContainer: Color(0xff464a20),
      onTertiaryContainer: Color(0xffe3e7af),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff19120d),
      onSurface: Color(0xfff0dfd6),
      onSurfaceVariant: Color(0xffd6c3b7),
      outline: Color(0xff9f8d82),
      outlineVariant: Color(0xff52443b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dfd6),
      inversePrimary: Color(0xff895020),
      primaryFixed: Color(0xffffdcc4),
      onPrimaryFixed: Color(0xff2f1400),
      primaryFixedDim: Color(0xffffb781),
      onPrimaryFixedVariant: Color(0xff6d3a09),
      secondaryFixed: Color(0xffffdcc4),
      onSecondaryFixed: Color(0xff2a1707),
      secondaryFixedDim: Color(0xffe4bfa7),
      onSecondaryFixedVariant: Color(0xff5b412f),
      tertiaryFixed: Color(0xffe3e7af),
      onTertiaryFixed: Color(0xff1a1d00),
      tertiaryFixedDim: Color(0xffc6ca95),
      onTertiaryFixedVariant: Color(0xff464a20),
      surfaceDim: Color(0xff19120d),
      surfaceBright: Color(0xff413731),
      surfaceContainerLowest: Color(0xff140d08),
      surfaceContainerLow: Color(0xff221a14),
      surfaceContainer: Color(0xff261e18),
      surfaceContainerHigh: Color(0xff312822),
      surfaceContainerHighest: Color(0xff3c332d),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd4b6),
      surfaceTint: Color(0xffffb781),
      onPrimary: Color(0xff3e1d00),
      primaryContainer: Color(0xffc4814d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffbd5bb),
      onSecondary: Color(0xff362110),
      secondaryContainer: Color(0xffab8a74),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdce0a9),
      onTertiary: Color(0xff242803),
      tertiaryContainer: Color(0xff909463),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff19120d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffedd8cc),
      outline: Color(0xffc1aea3),
      outlineVariant: Color(0xff9e8d82),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dfd6),
      inversePrimary: Color(0xff6e3b0a),
      primaryFixed: Color(0xffffdcc4),
      onPrimaryFixed: Color(0xff200c00),
      primaryFixedDim: Color(0xffffb781),
      onPrimaryFixedVariant: Color(0xff572a00),
      secondaryFixed: Color(0xffffdcc4),
      onSecondaryFixed: Color(0xff1e0d02),
      secondaryFixedDim: Color(0xffe4bfa7),
      onSecondaryFixedVariant: Color(0xff48311f),
      tertiaryFixed: Color(0xffe3e7af),
      onTertiaryFixed: Color(0xff101300),
      tertiaryFixedDim: Color(0xffc6ca95),
      onTertiaryFixedVariant: Color(0xff353911),
      surfaceDim: Color(0xff19120d),
      surfaceBright: Color(0xff4d423c),
      surfaceContainerLowest: Color(0xff0c0603),
      surfaceContainerLow: Color(0xff241c16),
      surfaceContainer: Color(0xff2f2620),
      surfaceContainerHigh: Color(0xff3a312b),
      surfaceContainerHighest: Color(0xff463c35),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffece2),
      surfaceTint: Color(0xffffb781),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xfffdb279),
      onPrimaryContainer: Color(0xff170700),
      secondary: Color(0xffffece2),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe0bca3),
      onSecondaryContainer: Color(0xff170700),
      tertiary: Color(0xfff0f4bc),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc3c791),
      onTertiaryContainer: Color(0xff0b0c00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff19120d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffece2),
      outlineVariant: Color(0xffd2bfb3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dfd6),
      inversePrimary: Color(0xff6e3b0a),
      primaryFixed: Color(0xffffdcc4),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb781),
      onPrimaryFixedVariant: Color(0xff200c00),
      secondaryFixed: Color(0xffffdcc4),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe4bfa7),
      onSecondaryFixedVariant: Color(0xff1e0d02),
      tertiaryFixed: Color(0xffe3e7af),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc6ca95),
      onTertiaryFixedVariant: Color(0xff101300),
      surfaceDim: Color(0xff19120d),
      surfaceBright: Color(0xff594e47),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff261e18),
      surfaceContainer: Color(0xff382f28),
      surfaceContainerHigh: Color(0xff433933),
      surfaceContainerHighest: Color(0xff4f453e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

