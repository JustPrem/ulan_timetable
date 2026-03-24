// ########################
// Imports.
// ########################

// Base.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Services.
import 'services/credentials_service.dart';

// Providers.
import 'providers/settings_provider.dart';

// Misc.
import 'misc/themes.dart';

// External.
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Routes.
import 'routes/android_login.dart';
import 'routes/android_timetable.dart';
import 'routes/android_settings.dart';

// ########################
// Main.
// ########################

void main() async
{
	// Ensure everything works.
	WidgetsFlutterBinding.ensureInitialized();
	
	// Load .env file. (Ignore if no file or empty)
	await dotenv.load(fileName: ".env", mergeWith: {}).catchError((_) {});

	// Check if the user has credentials.
	final hasCredentials = await CredentialsService().hasCredentials();

	// Hide system navigation.
	SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

	// Start the app.
	runApp(ProviderScope(child: AndroidApp(hasCredentials: hasCredentials)));
}

// ########################
// Material App.
// ########################

class AndroidApp extends ConsumerWidget
{
	// ########################
	// Variables.
	// ########################

	// Conditions.
	final bool hasCredentials;

	// ########################
	// Constructor.
	// ########################

	const AndroidApp({required this.hasCredentials, super.key});

	// ########################
	// Routes.
	// ########################

	static final Map<String, WidgetBuilder> _routes =
	{
		"/login"		: (_) => const AndroidLogin(),
		"/timetable" 	: (_) => const AndroidTimeTable(),
		"/settings"		: (_) => const AndroidSettings(),
	};

	@override
	Widget build(BuildContext context, WidgetRef ref)
	{	
		print("Has Credentials: $hasCredentials");

		// Listen to changes.
		final settingsAsync = ref.watch(settingsProvider);
		final textTheme = createTextTheme(context, "Inter Tight", "Inter");

		// Load Settings.
		final settings = settingsAsync.value ?? const SettingsState();

		// Find the selected theme, otherwise use the default.
		final selectedTheme = appThemes.firstWhere
		(
			(t) => t.id == settings.themeID,
			orElse: () => appThemes.first,
		);

		// Build the material app.
		return MaterialApp
		(
			debugShowCheckedModeBanner: false,
			theme: selectedTheme.lightTheme(textTheme),
			darkTheme: selectedTheme.darkTheme(textTheme),
			themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
			routes: _routes,
			initialRoute: hasCredentials ? "/timetable" : "/login",
		);
	}
}
