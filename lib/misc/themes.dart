// ########################
// Imports.
// ########################

// Base.
import 'package:flutter/material.dart';

// Theme files.
import '../themes/theme_orange.dart';
import '../themes/theme_green.dart';
import '../themes/theme_blue.dart';
import '../themes/theme_purple.dart';

// Font.
import 'package:google_fonts/google_fonts.dart';

// ########################
// App Theme Option.
// ########################

class AppThemeOption
{
	final String id;
	final String name;
	final Color primaryColour;
	final ThemeData Function(TextTheme) lightTheme;
	final ThemeData Function(TextTheme) darkTheme;

	const AppThemeOption
	({
		required this.id,
		required this.name,
		required this.primaryColour,
		required this.lightTheme,
		required this.darkTheme,
	});
}

// ########################
// Theme Registry.
// ########################

final List<AppThemeOption> appThemes =
[
	AppThemeOption
	(
		id: 'orange',
		name: 'Orange',
		primaryColour: OrangeTheme.lightScheme().primary,
		lightTheme: (textTheme) => OrangeTheme(textTheme).light(),
		darkTheme: (textTheme) => OrangeTheme(textTheme).dark(),
	),
	AppThemeOption
	(
		id: 'green',
		name: "Green",
		primaryColour: GreenTheme.lightScheme().primary,
		lightTheme: (textTheme) => GreenTheme(textTheme).light(),
		darkTheme: (textTheme) => GreenTheme(textTheme).dark(),
	),
	AppThemeOption
	(
		id: "blue",
		name: "Blue",
		primaryColour: BlueTheme.lightScheme().primary,
		lightTheme: (textTheme) => BlueTheme(textTheme).light(),
		darkTheme: (textTheme) => BlueTheme(textTheme).dark(),
	),
	AppThemeOption
	(
		id: "purple",
		name: "Purple",
		primaryColour: PurpleTheme.lightScheme().primary,
		lightTheme: (textTheme) => PurpleTheme(textTheme).light(),
		darkTheme: (textTheme) => PurpleTheme(textTheme).dark(),
	),
	// To add a new theme:
	// 1. Drop your generated theme file into lib/misc/
	// 2. Import it above
	// 3. Add an entry here like:
	// AppThemeOption
	// (
	// 	id: 'ocean',
	// 	name: 'Ocean',
	// 	primaryColour: Color(0xff...),  // copy lightScheme() primary value
	// 	lightTheme: (textTheme) => MaterialThemeOcean(textTheme).light(),
	// 	darkTheme: (textTheme) => MaterialThemeOcean(textTheme).dark(),
	// ),
];

TextTheme createTextTheme(
  BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );

  return textTheme;
  }
