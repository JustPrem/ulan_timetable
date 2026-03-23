import "package:flutter/material.dart";

class GreenTheme {
  final TextTheme textTheme;

  const GreenTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff48672e),
      surfaceTint: Color(0xff48672e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc9eea7),
      onPrimaryContainer: Color(0xff314e19),
      secondary: Color(0xff56624b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdae7c9),
      onSecondaryContainer: Color(0xff3f4a34),
      tertiary: Color(0xff386665),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbbecea),
      onTertiaryContainer: Color(0xff1e4e4d),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff9faef),
      onSurface: Color(0xff1a1d16),
      onSurfaceVariant: Color(0xff44483e),
      outline: Color(0xff74796d),
      outlineVariant: Color(0xffc4c8ba),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e312a),
      inversePrimary: Color(0xffaed18d),
      primaryFixed: Color(0xffc9eea7),
      onPrimaryFixed: Color(0xff0c2000),
      primaryFixedDim: Color(0xffaed18d),
      onPrimaryFixedVariant: Color(0xff314e19),
      secondaryFixed: Color(0xffdae7c9),
      onSecondaryFixed: Color(0xff141e0c),
      secondaryFixedDim: Color(0xffbecbae),
      onSecondaryFixedVariant: Color(0xff3f4a34),
      tertiaryFixed: Color(0xffbbecea),
      onTertiaryFixed: Color(0xff00201f),
      tertiaryFixedDim: Color(0xffa0cfcd),
      onTertiaryFixedVariant: Color(0xff1e4e4d),
      surfaceDim: Color(0xffd9dbd0),
      surfaceBright: Color(0xfff9faef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f5ea),
      surfaceContainer: Color(0xffedefe4),
      surfaceContainerHigh: Color(0xffe7e9de),
      surfaceContainerHighest: Color(0xffe2e3d9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff213d09),
      surfaceTint: Color(0xff48672e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff56763c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2f3925),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff657158),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff073d3c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff477573),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9faef),
      onSurface: Color(0xff0f120c),
      onSurfaceVariant: Color(0xff33382e),
      outline: Color(0xff4f5449),
      outlineVariant: Color(0xff6a6f63),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e312a),
      inversePrimary: Color(0xffaed18d),
      primaryFixed: Color(0xff56763c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3f5d26),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff657158),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4d5841),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff477573),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2e5c5b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5c7bd),
      surfaceBright: Color(0xfff9faef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f5ea),
      surfaceContainer: Color(0xffe7e9de),
      surfaceContainerHigh: Color(0xffdcded3),
      surfaceContainerHighest: Color(0xffd1d3c8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff173301),
      surfaceTint: Color(0xff48672e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff34511b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff252f1b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff414d36),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003231),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff21504f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9faef),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292e24),
      outlineVariant: Color(0xff464b40),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e312a),
      inversePrimary: Color(0xffaed18d),
      primaryFixed: Color(0xff34511b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff1e3906),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff414d36),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2b3621),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff21504f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff023938),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb8bab0),
      surfaceBright: Color(0xfff9faef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f2e7),
      surfaceContainer: Color(0xffe2e3d9),
      surfaceContainerHigh: Color(0xffd3d5cb),
      surfaceContainerHighest: Color(0xffc5c7bd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffaed18d),
      surfaceTint: Color(0xffaed18d),
      onPrimary: Color(0xff1b3704),
      primaryContainer: Color(0xff314e19),
      onPrimaryContainer: Color(0xffc9eea7),
      secondary: Color(0xffbecbae),
      onSecondary: Color(0xff29341f),
      secondaryContainer: Color(0xff3f4a34),
      onSecondaryContainer: Color(0xffdae7c9),
      tertiary: Color(0xffa0cfcd),
      onTertiary: Color(0xff003736),
      tertiaryContainer: Color(0xff1e4e4d),
      onTertiaryContainer: Color(0xffbbecea),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff11140e),
      onSurface: Color(0xffe2e3d9),
      onSurfaceVariant: Color(0xffc4c8ba),
      outline: Color(0xff8e9286),
      outlineVariant: Color(0xff44483e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e3d9),
      inversePrimary: Color(0xff48672e),
      primaryFixed: Color(0xffc9eea7),
      onPrimaryFixed: Color(0xff0c2000),
      primaryFixedDim: Color(0xffaed18d),
      onPrimaryFixedVariant: Color(0xff314e19),
      secondaryFixed: Color(0xffdae7c9),
      onSecondaryFixed: Color(0xff141e0c),
      secondaryFixedDim: Color(0xffbecbae),
      onSecondaryFixedVariant: Color(0xff3f4a34),
      tertiaryFixed: Color(0xffbbecea),
      onTertiaryFixed: Color(0xff00201f),
      tertiaryFixedDim: Color(0xffa0cfcd),
      onTertiaryFixedVariant: Color(0xff1e4e4d),
      surfaceDim: Color(0xff11140e),
      surfaceBright: Color(0xff373a33),
      surfaceContainerLowest: Color(0xff0c0f09),
      surfaceContainerLow: Color(0xff1a1d16),
      surfaceContainer: Color(0xff1e211a),
      surfaceContainerHigh: Color(0xff282b24),
      surfaceContainerHighest: Color(0xff33362f),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc3e8a1),
      surfaceTint: Color(0xffaed18d),
      onPrimary: Color(0xff122b00),
      primaryContainer: Color(0xff799b5c),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd4e1c3),
      onSecondary: Color(0xff1e2915),
      secondaryContainer: Color(0xff88957a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb5e5e3),
      onTertiary: Color(0xff002b2a),
      tertiaryContainer: Color(0xff6b9997),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff11140e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdaded0),
      outline: Color(0xffafb4a6),
      outlineVariant: Color(0xff8e9285),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e3d9),
      inversePrimary: Color(0xff32501a),
      primaryFixed: Color(0xffc9eea7),
      onPrimaryFixed: Color(0xff061500),
      primaryFixedDim: Color(0xffaed18d),
      onPrimaryFixedVariant: Color(0xff213d09),
      secondaryFixed: Color(0xffdae7c9),
      onSecondaryFixed: Color(0xff0a1404),
      secondaryFixedDim: Color(0xffbecbae),
      onSecondaryFixedVariant: Color(0xff2f3925),
      tertiaryFixed: Color(0xffbbecea),
      onTertiaryFixed: Color(0xff001414),
      tertiaryFixedDim: Color(0xffa0cfcd),
      onTertiaryFixedVariant: Color(0xff073d3c),
      surfaceDim: Color(0xff11140e),
      surfaceBright: Color(0xff43453e),
      surfaceContainerLowest: Color(0xff060804),
      surfaceContainerLow: Color(0xff1c1f18),
      surfaceContainer: Color(0xff262922),
      surfaceContainerHigh: Color(0xff31342c),
      surfaceContainerHighest: Color(0xff3c3f37),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd6fcb3),
      surfaceTint: Color(0xffaed18d),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffaacd8a),
      onPrimaryContainer: Color(0xff040e00),
      secondary: Color(0xffe8f5d6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbac7aa),
      onSecondaryContainer: Color(0xff050e01),
      tertiary: Color(0xffc9f9f7),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9ccbc9),
      onTertiaryContainer: Color(0xff000e0d),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff11140e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeef2e3),
      outlineVariant: Color(0xffc0c4b7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e3d9),
      inversePrimary: Color(0xff32501a),
      primaryFixed: Color(0xffc9eea7),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffaed18d),
      onPrimaryFixedVariant: Color(0xff061500),
      secondaryFixed: Color(0xffdae7c9),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbecbae),
      onSecondaryFixedVariant: Color(0xff0a1404),
      tertiaryFixed: Color(0xffbbecea),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa0cfcd),
      onTertiaryFixedVariant: Color(0xff001414),
      surfaceDim: Color(0xff11140e),
      surfaceBright: Color(0xff4e5149),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1e211a),
      surfaceContainer: Color(0xff2e312a),
      surfaceContainerHigh: Color(0xff393c35),
      surfaceContainerHighest: Color(0xff454840),
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
     scaffoldBackgroundColor: colorScheme.background,
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

