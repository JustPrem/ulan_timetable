// ########################
// Imports.
// ########################

// Base.
import 'package:flutter/material.dart';
// External.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers.
import 'package:ulan_timetable/providers/settings_provider.dart';

// Widgets.
import 'package:ulan_timetable/widgets/app_bar.dart';
import 'package:ulan_timetable/widgets/app_drawer.dart';
import 'package:ulan_timetable/widgets/theme_picker.dart';

// ########################
// Android - Settings.
// ########################

class AndroidSettings extends ConsumerWidget
{
	const AndroidSettings({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref)
	{
		final settingsAsync = ref.watch(settingsProvider);
		final colorScheme = Theme.of(context).colorScheme;

		return Scaffold
		(
			appBar: CustomAppBar(title: "Settings"),
			drawer: const AppDrawer(),
			body: SafeArea
			(
				child: settingsAsync.when
				(
					loading: () => const Center(child: CircularProgressIndicator()),
					error: (e, _) => Center(child: Text("Failed to load settings.")),
					data: (settings) => ListView
					(
						padding: const EdgeInsets.all(24),
						children:
						[
							// ########################
							// Appearance Section.
							// ########################

							Text
							(
								"Appearance",
								style: Theme.of(context).textTheme.titleSmall?.copyWith
								(
									color: colorScheme.primary,
									fontWeight: FontWeight.bold,
								),
							),
							const SizedBox(height: 16),

							// Dark mode toggle.
							Container
							(
								decoration: BoxDecoration
								(
									color: colorScheme.surfaceContainerHigh,
									borderRadius: BorderRadius.circular(16),
								),
								child: SwitchListTile
								(
									title: const Text("Dark Mode"),
									subtitle: const Text("Override system theme"),
									secondary: Icon
									(
										settings.darkMode
											? Icons.dark_mode_outlined
											: Icons.light_mode_outlined,
									),
									value: settings.darkMode,
									onChanged: (value)
									{
										ref.read(settingsProvider.notifier).setDarkMode(value);
									},
									shape: RoundedRectangleBorder
									(
										borderRadius: BorderRadius.circular(16),
									),
								),
							),
							const SizedBox(height: 24),

							// ########################
							// Theme Section.
							// ########################

							Text
							(
								"Theme",
								style: Theme.of(context).textTheme.titleSmall?.copyWith
								(
									color: colorScheme.primary,
									fontWeight: FontWeight.bold,
								),
							),
							const SizedBox(height: 16),

							Container
							(
								padding: const EdgeInsets.all(16),
								decoration: BoxDecoration
								(
									color: colorScheme.surfaceContainerHigh,
									borderRadius: BorderRadius.circular(16),
								),
								child: ThemePicker
								(
									selectedThemeID: settings.themeID,
									onThemeSelected: (id)
									{
										ref.read(settingsProvider.notifier).setTheme(id);
									},
								),
							),
						],
					),
				),
			),
		);
	}
}
