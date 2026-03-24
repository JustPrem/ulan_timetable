// ########################
// Imports.
// ########################

// Base.
import 'package:flutter/material.dart';

// External.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// Services.
import 'package:ulan_timetable/services/credentials_service.dart';
import 'package:ulan_timetable/services/update_service.dart';

// ########################
// Widget - App Drawer.
// ########################

class AppDrawer extends ConsumerWidget
{
	const AppDrawer({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref)
	{
		final colorScheme = Theme.of(context).colorScheme;
		final textTheme   = Theme.of(context).textTheme;

		return Drawer
		(
			width: MediaQuery.sizeOf(context).width * 0.75,
			child: SafeArea
			(
				child: Column
				(
					children:
					[
						// ########################
						// Header.
						// ########################

						Padding
						(
							padding: const EdgeInsets.all(12),
							child: Row
							(
								children:
								[
									Expanded
									(
										child: Column
										(
											crossAxisAlignment: CrossAxisAlignment.start,
											children:
											[
												Text
												(
													'University of Lancashire',
													style: textTheme.titleLarge?.copyWith
													(
														fontWeight: FontWeight.bold,
														color: colorScheme.onSurface,
													),
													overflow: TextOverflow.ellipsis,
												),
												Text
												(
													'Timetable',
													style: textTheme.titleMedium?.copyWith
													(
														fontWeight: FontWeight.bold,
														color: colorScheme.onSurfaceVariant,
													),
													overflow: TextOverflow.ellipsis,
												),
												Text
												(
													'Week at a glance',
													style: textTheme.bodySmall?.copyWith
													(
														color: colorScheme.onSurfaceVariant,
													),
												),
											],
										),
									),
								],
							),
						),
						Divider(color: colorScheme.outlineVariant),

						// ########################
						// Navigation Items.
						// ########################
						
						// Timetable.
						ListTile
						(
							leading: Icon(Icons.calendar_today_outlined, color: colorScheme.onSurface),
							title:   const Text('Timetable'),
							onTap:   ()
							{
								Navigator.pushReplacementNamed(context, "/timetable");
							},
						),

						// Settings.
						ListTile
						(
							leading: Icon(Icons.settings_outlined, color: colorScheme.onSurface),
							title:   const Text('Settings'),
							onTap:   ()
							{
								Navigator.pushNamed(context, "/settings");
							},
						),

						// Spacer.
						const Spacer(),

						// ########################
						// Links.
						// ########################

						// University Website.
						ListTile
						(
							leading: Icon(Icons.open_in_browser_outlined, color: colorScheme.onSurface),
							title:   const Text('University Website'),
							onTap:   () async
							{
								final url = Uri.parse('https://www.lancashire.ac.uk');
								if (await canLaunchUrl(url))
								{
									await launchUrl(url, mode: LaunchMode.externalApplication);
								}
							},
						),

						// Timetable Help.
						ListTile
						(
							leading: Icon(Icons.help_outline, color: colorScheme.onSurface),
							title:   const Text('Timetable Help'),
							onTap:   () async
							{
								final url = Uri.parse
								(
									'https://msuclanac.sharepoint.com/sites/StudentHub/SitePages/Timetabling-information.aspx',
								);
								if (await canLaunchUrl(url))
								{
									await launchUrl(url, mode: LaunchMode.externalApplication);
								}
							},
						),

						Divider(color: colorScheme.outlineVariant),
						
						// ########################
						// Developer.
						// ########################

						// Website.
						ListTile
						(
							leading: Icon(Icons.computer_outlined, color: colorScheme.onSurface),
							title: const Text("Developer Website"),
							subtitle: const Text("Created by Przemek Kaniewski"),
							onTap: () async
							{
								final url = Uri.parse("https://www.code-prem.dev");
								if (await canLaunchUrl(url))
								{
									await launchUrl(url, mode: LaunchMode.externalApplication);
								}
							}
						),
						
						// Share app QR Code.
						ListTile
						(
							leading: Icon(Icons.qr_code, color: colorScheme.onSurface),
							title:   const Text('Share the App'),
							onTap: () => UpdateService().showQrCode(context),
						),

						Divider(color: colorScheme.outlineVariant),

						// ########################
						// Logout Button.
						// ########################

						ListTile
						(
							leading: Icon(Icons.logout, color: colorScheme.error),
							title: Text
							(
								'Sign Out',
								style: TextStyle(color: colorScheme.error),
							),
							onTap: () async
							{
								await CredentialsService().clear();
								Navigator.pushReplacementNamed(context, '/');
							},
						),
						const SizedBox(height: 8),
					],
				),
			),
		);
	}
}
