// ########################
// Imports.
// ########################

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
	
	static const _repoName    = 'ulan_timetable';
	static const _repoApi     = 'https://api.github.com/repos/JustPrem/$_repoName/releases/latest';
	static const _downloadUrl = 'https://github.com/JustPrem/$_repoName/releases/latest/download/app-release.apk';

	// ############################
	// Update Check.
	// ############################

	Future<({bool hasUpdate, String latestVersion})> checkForUpdate() async
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
		final hasUpdate     = _isNewer(latestVersion, currentVersion);

		return (hasUpdate: hasUpdate, latestVersion: latestVersion);
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

	void showUpdateDialog(BuildContext context, String latestVersion)
	{
		showDialog
		(
			context: context,
			builder: (context)
			{
				return AlertDialog
				(
					title:   const Text('Update Available'),
					content: Text('Version $latestVersion is available. Would you like to download it?'),
					actions:
					[
						TextButton
						(
							onPressed: () => Navigator.pop(context),
							child:     const Text('Later'),
						),
						FilledButton
						(
							onPressed: () async
							{
								Navigator.pop(context);
								await _launchDownload();
							},
							child: const Text('Download'),
						),
					],
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
			context:       context,
			useSafeArea:   true,
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
