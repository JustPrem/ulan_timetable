// ########################
// Imports.
// ########################

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ########################
// Model.
// ########################

class ReleaseInfo
{
	final bool   hasUpdate;
	final String latestVersion;
	final String releaseNotes;

	const ReleaseInfo
	({
		required this.hasUpdate,
		required this.latestVersion,
		required this.releaseNotes,
	});
}

// ########################
// UpdateService.
// ########################

class UpdateService
{
	// ############################
	// Singleton.
	// ############################

	static final UpdateService _instance = UpdateService._internal();

	factory UpdateService() => _instance;

	UpdateService._internal();

	// ############################
	// Constants.
	// ############################

	static const _repoName    = "ulan_timetable";
	static const _repoApi     = 'https://api.github.com/repos/JustPrem/$_repoName/releases/latest';
	static const _downloadUrl = 'https://github.com/JustPrem/$_repoName/releases/latest/download/app-release.apk';

	// ############################
	// Update Check.
	// ############################

	Future<ReleaseInfo> checkForUpdate() async
	{
		final packageInfo    = await PackageInfo.fromPlatform();
		final currentVersion = packageInfo.version;

		final response = await http.get
		(
			Uri.parse(_repoApi),
			headers: { 'Accept': 'application/vnd.github+json' },
		);

		if (response.statusCode != 200)
		{
			throw Exception('Failed to check for updates (${response.statusCode})');
		}

		final json          = jsonDecode(response.body);
		final latestVersion = (json['tag_name'] as String).replaceAll('v', '');
		final releaseNotes  = (json['body'] as String? ?? '').trim();
		final hasUpdate     = _isNewer(latestVersion, currentVersion);

		return ReleaseInfo
		(
			hasUpdate:     hasUpdate,
			latestVersion: latestVersion,
			releaseNotes:  releaseNotes,
		);
	}

	// Compare semver — returns true if latest > current.
	bool _isNewer(String latest, String current)
	{
		final l = latest.split('.').map(int.parse).toList();
		final c = current.split('.').map(int.parse).toList();

		for (int i = 0; i < 3; i++)
		{
			final lPart = i < l.length ? l[i] : 0;
			final cPart = i < c.length ? c[i] : 0;

			if (lPart > cPart) return true;
			if (lPart < cPart) return false;
		}

		return false;
	}

	// ############################
	// Update Dialog.
	// ############################

	void showUpdateDialog(BuildContext context, ReleaseInfo info)
	{
		final theme   = Theme.of(context);
		final colours = theme.colorScheme;

		showDialog
		(
			context: context,
			builder: (context)
			{
				return Dialog
				(
					child: ConstrainedBox
					(
						constraints: BoxConstraints
						(
							maxHeight: MediaQuery.of(context).size.height * 0.75,
							maxWidth:  400,
						),
						child: Column
						(
							mainAxisSize: MainAxisSize.min,
							crossAxisAlignment: CrossAxisAlignment.start,
							children:
							[
								// ---- Header ----
								Padding
								(
									padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
									child: Row
									(
										children:
										[
											Icon(Icons.system_update_outlined, color: colours.primary, size: 22),
											const SizedBox(width: 8),
											Expanded
											(
												child: Text
												(
													'Version ${info.latestVersion} Available',
													style: theme.textTheme.titleLarge,
												),
											),
										],
									),
								),

								const SizedBox(height: 12),
								Divider(color: colours.outlineVariant, height: 1),

								// ---- Release Notes ----
								Flexible
								(
									child: info.releaseNotes.isNotEmpty
										? Markdown
										(
											data:          info.releaseNotes,
											shrinkWrap:    true,
											padding:       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
											styleSheet:    MarkdownStyleSheet.fromTheme(theme).copyWith
											(
												p:       theme.textTheme.bodyMedium,
												h1:      theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
												h2:      theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
												h3:      theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
												code:    theme.textTheme.bodySmall?.copyWith
												(
													fontFamily:      'monospace',
													backgroundColor: colours.surfaceContainerHighest,
												),
												codeblockDecoration: BoxDecoration
												(
													color:        colours.surfaceContainerHighest,
													borderRadius: BorderRadius.circular(8),
												),
												blockquoteDecoration: BoxDecoration
												(
													border: Border
													(
														left: BorderSide
														(
															color: colours.primary,
															width: 4,
														),
													),
												),
											),
											onTapLink: (text, href, title) async
											{
												if (href != null)
												{
													final url = Uri.parse(href);
													if (await canLaunchUrl(url))
													{
														await launchUrl(url, mode: LaunchMode.externalApplication);
													}
												}
											},
										)
										: Padding
										(
											padding: const EdgeInsets.all(24),
											child: Text
											(
												'No release notes provided.',
												style: theme.textTheme.bodyMedium?.copyWith
												(
													color: colours.onSurfaceVariant,
												),
											),
										),
								),

								Divider(color: colours.outlineVariant, height: 1),

								// ---- Actions ----
								Padding
								(
									padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
									child: Row
									(
										mainAxisAlignment: MainAxisAlignment.end,
										children:
										[
											TextButton
											(
												onPressed: () => Navigator.pop(context),
												child:     const Text('Later'),
											),
											const SizedBox(width: 8),
											FilledButton.icon
											(
												onPressed: () async
												{
													Navigator.pop(context);
													await _launchDownload();
												},
												icon:  const Icon(Icons.download_outlined, size: 18),
												label: const Text('Download'),
											),
										],
									),
								),
							],
						),
					),
				);
			},
		);
	}

	// ############################
	// QR Code.
	// ############################

	void showQrCode(BuildContext context)
	{
		final colours   = Theme.of(context).colorScheme;
		final textTheme = Theme.of(context).textTheme;

		showModalBottomSheet
		(
			context:     context,
			useSafeArea: true,
			builder: (context)
			{
				return Padding
				(
					padding: const EdgeInsets.all(32),
					child: Column
					(
						mainAxisSize: MainAxisSize.min,
						children:
						[
							Text
							(
								'Download Latest Version',
								style: textTheme.titleMedium?.copyWith
								(
									fontWeight: FontWeight.bold,
								),
							),
							const SizedBox(height: 8),
							Text
							(
								'Scan to download the latest release',
								style: textTheme.bodySmall?.copyWith
								(
									color: colours.onSurfaceVariant,
								),
							),
							const SizedBox(height: 24),
							QrImageView
							(
								data:            _downloadUrl,
								version:         QrVersions.auto,
								size:            220,
								backgroundColor: Colors.white,
								padding:         const EdgeInsets.all(12),
							),
							const SizedBox(height: 16),
							TextButton.icon
							(
								onPressed: () async
								{
									Navigator.pop(context);
									await _launchDownload();
								},
								icon:  const Icon(Icons.download_outlined),
								label: const Text('Open Download Link'),
							),
							const SizedBox(height: 8),
						],
					),
				);
			},
		);
	}

	// ############################
	// Helpers.
	// ############################

	Future<void> _launchDownload() async
	{
		final url = Uri.parse(_downloadUrl);
		if (await canLaunchUrl(url))
		{
			await launchUrl(url, mode: LaunchMode.externalApplication);
		}
	}
}
