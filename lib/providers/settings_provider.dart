// ########################
// Imports.
// ########################

// External.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ########################
// Settings State.
// ########################

class SettingsState
{
	final bool darkMode;
	final bool choseOffline;
	final String themeID;

	const SettingsState
	({
		this.darkMode = true,
		this.choseOffline = false,
		this.themeID = 'blue',
	});

	SettingsState copyWith({bool? darkMode, bool? choseOffline, String? themeID})
	{
		return SettingsState
		(
			darkMode: darkMode ?? this.darkMode,
			choseOffline: choseOffline ?? this.choseOffline,
			themeID: themeID ?? this.themeID,
		);
	}
}

// ########################
// Settings Notifier.
// ########################

class SettingsNotifier extends AsyncNotifier<SettingsState>
{
	static const _darkModeKey = 'darkMode';
	static const _choseOfflineKey = 'choseOffline';
	static const _themeIDKey = 'themeID';

	@override
	Future<SettingsState> build() async
	{
		final prefs = await SharedPreferences.getInstance();
		return SettingsState
		(
			darkMode: prefs.getBool(_darkModeKey) ?? true,
			choseOffline: prefs.getBool(_choseOfflineKey) ?? false,
			themeID: prefs.getString(_themeIDKey) ?? 'blue',
		);
	}

	// Toggle dark mode.
	Future<void> setDarkMode(bool value) async
	{
		final prefs = await SharedPreferences.getInstance();
		await prefs.setBool(_darkModeKey, value);
		state = AsyncData(state.value!.copyWith(darkMode: value));
	}

	// Set theme.
	Future<void> setTheme(String themeID) async
	{
		final prefs = await SharedPreferences.getInstance();
		await prefs.setString(_themeIDKey, themeID);
		state = AsyncData(state.value!.copyWith(themeID: themeID));
	}

	// Check if chosen to remain offline.
	Future<void> setOffline(bool value) async
	{
		final prefs = await SharedPreferences.getInstance();
		await prefs.setBool(_choseOfflineKey, value);
		state = AsyncData(state.value!.copyWith(choseOffline: value));
	}
}

// ########################
// Provider.
// ########################

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, SettingsState>
(
	SettingsNotifier.new,
);
