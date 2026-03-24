// ########################
// Imports.
// ########################

// Base.
import 'package:flutter/material.dart';

// ########################
// Widget - Revise App Bar.
// ########################

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget
{
	final String title;
	final List<Widget>? actions;

	const CustomAppBar({required this.title, this.actions, super.key});

	@override
	Size get preferredSize => const Size.fromHeight(kToolbarHeight);

	@override
	Widget build(BuildContext context)
	{
		final currentRoute = ModalRoute.of(context)?.settings.name;
		final showBackButton = currentRoute != "/login" && currentRoute != "/timetable";

		return AppBar
		(
			title: Text(title),
			leading: showBackButton
				? IconButton
				(
					icon: const Icon(Icons.arrow_back),
					onPressed: () => Navigator.pop(context),
				)
				: null,
			actions: actions,
		);
	}
}
