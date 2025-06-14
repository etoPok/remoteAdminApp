import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000),
      surfaceTint: Color(0xff5a5f5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff171d1c),
      onPrimaryContainer: Color(0xff808584),
      secondary: Color(0xff5d5f5e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe2e2e2),
      onSecondaryContainer: Color(0xff636564),
      tertiary: Color(0xff000000),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a1c1f),
      onTertiaryContainer: Color(0xff828488),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcf9f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff434847),
      outline: Color(0xff737877),
      outlineVariant: Color(0xffc3c7c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc3c7c7),
      primaryFixed: Color(0xffdfe3e3),
      onPrimaryFixed: Color(0xff171d1c),
      primaryFixedDim: Color(0xffc3c7c7),
      onPrimaryFixedVariant: Color(0xff434847),
      secondaryFixed: Color(0xffe2e2e2),
      onSecondaryFixed: Color(0xff1a1c1c),
      secondaryFixedDim: Color(0xffc6c6c6),
      onSecondaryFixedVariant: Color(0xff454747),
      tertiaryFixed: Color(0xffe2e2e7),
      onTertiaryFixed: Color(0xff1a1c1f),
      tertiaryFixedDim: Color(0xffc6c6cb),
      onTertiaryFixedVariant: Color(0xff45474b),
      surfaceDim: Color(0xffdcd9d9),
      surfaceBright: Color(0xfffcf9f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff0edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000),
      surfaceTint: Color(0xff5a5f5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff171d1c),
      onPrimaryContainer: Color(0xffa3a8a7),
      secondary: Color(0xff353636),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6c6d6d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff000000),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a1c1f),
      onTertiaryContainer: Color(0xffa6a6ab),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf9f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff323737),
      outline: Color(0xff4f5353),
      outlineVariant: Color(0xff696e6d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc3c7c7),
      primaryFixed: Color(0xff696e6e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff515655),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6c6d6d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff535555),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6b6d72),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff535559),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc8c6c5),
      surfaceBright: Color(0xfffcf9f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffdfdcdb),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000),
      surfaceTint: Color(0xff5a5f5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff171d1c),
      onPrimaryContainer: Color(0xffccd1d0),
      secondary: Color(0xff2b2c2c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff484949),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff000000),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a1c1f),
      onTertiaryContainer: Color(0xffcfd0d5),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf9f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282d2d),
      outlineVariant: Color(0xff454a4a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc3c7c7),
      primaryFixed: Color(0xff454a4a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2e3433),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff484949),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff313333),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff47494d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff313337),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b8),
      surfaceBright: Color(0xfffcf9f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc8c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc3c7c7),
      surfaceTint: Color(0xffc3c7c7),
      onPrimary: Color(0xff2c3131),
      primaryContainer: Color(0xff010303),
      onPrimaryContainer: Color(0xff727777),
      secondary: Color(0xffc6c6c6),
      onSecondary: Color(0xff2f3130),
      secondaryContainer: Color(0xff454747),
      onSecondaryContainer: Color(0xffb5b5b4),
      tertiary: Color(0xffc6c6cb),
      onTertiary: Color(0xff2e3035),
      tertiaryContainer: Color(0xff020305),
      onTertiaryContainer: Color(0xff75767b),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc3c7c7),
      outline: Color(0xff8d9191),
      outlineVariant: Color(0xff434847),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff5a5f5f),
      primaryFixed: Color(0xffdfe3e3),
      onPrimaryFixed: Color(0xff171d1c),
      primaryFixedDim: Color(0xffc3c7c7),
      onPrimaryFixedVariant: Color(0xff434847),
      secondaryFixed: Color(0xffe2e2e2),
      onSecondaryFixed: Color(0xff1a1c1c),
      secondaryFixedDim: Color(0xffc6c6c6),
      onSecondaryFixedVariant: Color(0xff454747),
      tertiaryFixed: Color(0xffe2e2e7),
      onTertiaryFixed: Color(0xff1a1c1f),
      tertiaryFixedDim: Color(0xffc6c6cb),
      onTertiaryFixedVariant: Color(0xff45474b),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353534),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd9dddc),
      surfaceTint: Color(0xffc3c7c7),
      onPrimary: Color(0xff212726),
      primaryContainer: Color(0xff8d9291),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffdcdcdc),
      onSecondary: Color(0xff242626),
      secondaryContainer: Color(0xff909190),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdcdce1),
      onTertiary: Color(0xff24262a),
      tertiaryContainer: Color(0xff8f9095),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd9dddc),
      outline: Color(0xffafb3b2),
      outlineVariant: Color(0xff8d9191),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff444949),
      primaryFixed: Color(0xffdfe3e3),
      onPrimaryFixed: Color(0xff0d1212),
      primaryFixedDim: Color(0xffc3c7c7),
      onPrimaryFixedVariant: Color(0xff323737),
      secondaryFixed: Color(0xffe2e2e2),
      onSecondaryFixed: Color(0xff101111),
      secondaryFixedDim: Color(0xffc6c6c6),
      onSecondaryFixedVariant: Color(0xff353636),
      tertiaryFixed: Color(0xffe2e2e7),
      onTertiaryFixed: Color(0xff0f1115),
      tertiaryFixedDim: Color(0xffc6c6cb),
      onTertiaryFixedVariant: Color(0xff34363a),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282828),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffecf1f0),
      surfaceTint: Color(0xffc3c7c7),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffbfc3c3),
      onPrimaryContainer: Color(0xff070c0c),
      secondary: Color(0xfff0f0ef),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc2c3c2),
      onSecondaryContainer: Color(0xff0a0c0c),
      tertiary: Color(0xffefeff5),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc2c2c7),
      onTertiaryContainer: Color(0xff090b0f),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff131313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffedf1f0),
      outlineVariant: Color(0xffbfc3c3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff444949),
      primaryFixed: Color(0xffdfe3e3),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc3c7c7),
      onPrimaryFixedVariant: Color(0xff0d1212),
      secondaryFixed: Color(0xffe2e2e2),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc6c6c6),
      onSecondaryFixedVariant: Color(0xff101111),
      tertiaryFixed: Color(0xffe2e2e7),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc6c6cb),
      onTertiaryFixedVariant: Color(0xff0f1115),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff51504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff474646),
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
