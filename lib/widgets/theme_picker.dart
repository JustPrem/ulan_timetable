// ########################
// Imports.
// ########################

// Base.
import 'package:flutter/material.dart';

// Themes.
import 'package:ulan_timetable/misc/themes.dart';

// ########################
// Widget - Theme Picker.
// ########################

class ThemePicker extends StatelessWidget
{
	final String selectedThemeID;
	final ValueChanged<String> onThemeSelected;

	const ThemePicker
	({
		required this.selectedThemeID,
		required this.onThemeSelected,
		super.key,
	});

	@override
	Widget build(BuildContext context)
	{
		return SizedBox
		(
			width: double.infinity,
			child: Wrap
			(
				spacing: 16,
				runSpacing: 16,
				alignment: WrapAlignment.center,
				children: appThemes.map((theme)
				{
					final isSelected = selectedThemeID == theme.id;

					return GestureDetector
					(
						onTap: () => onThemeSelected(theme.id),
						child: Column
						(
							children:
							[
								AnimatedContainer
								(
									duration: const Duration(milliseconds: 200),
									width: 48,
									height: 48,
									decoration: BoxDecoration
									(
										shape: BoxShape.circle,
										color: theme.primaryColour,
										border: Border.all
										(
											color: isSelected
												? Theme.of(context).colorScheme.onSurface
												: Colors.transparent,
											width: 3,
										),
										boxShadow: isSelected
											?
											[
												BoxShadow
												(
													color: theme.primaryColour.withAlpha(120),
													blurRadius: 8,
													spreadRadius: 2,
												),
											]
											: null,
									),
									child: isSelected
										? const Icon(Icons.check, color: Colors.white, size: 20)
										: null,
								),
								const SizedBox(height: 6),
								Text
								(
									theme.name,
									style: Theme.of(context).textTheme.labelSmall?.copyWith
									(
										fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
									),
								),
							],
						),
					);
				}).toList(),
			),
		);
	}
}
