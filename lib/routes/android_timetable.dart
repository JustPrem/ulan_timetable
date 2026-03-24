// ########################
// Imports.
// ########################

// Base.
import 'package:flutter/material.dart';

// External.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Services.
import 'package:ulan_timetable/services/timetable_service.dart';
import 'package:ulan_timetable/services/credentials_service.dart';
import 'package:ulan_timetable/services/cache_service.dart';
import 'package:ulan_timetable/services/update_service.dart';

// Widgets.
import 'package:ulan_timetable/widgets/app_drawer.dart';
import 'package:ulan_timetable/widgets/app_bar.dart';

// ########################
// AndroidTimeTable.
// ########################

class AndroidTimeTable extends ConsumerStatefulWidget
{
	const AndroidTimeTable({super.key});

	@override
	ConsumerState<AndroidTimeTable> createState() => _AndroidTimeTableState();
}

class _AndroidTimeTableState extends ConsumerState<AndroidTimeTable>
{
	// ############################
	// State.
	// ############################

	final _service       = TimetableService();
	final _cache         = CacheService();
	final _updateService = UpdateService();

	List<TimetableEvent> _events     = [];
	bool                 _isLoading  = false;
	bool                 _isFetching = false;
	String?              _error;
	int?                 _weekNumber;
	late String          _startDate;

	// ############################
	// Lifecycle.
	// ############################

	@override
	void initState()
	{
		super.initState();
		_startDate = _service.getCurrentWeekMonday();
		_initialLoad();
		_checkForUpdates();
	}

	// ############################
	// Methods.
	// ############################

	Future<void> _initialLoad() async
	{
		final currentWeek = _startDate;
		final nextWeek    = _service.shiftWeek(currentWeek, 1);

		if (_cache.has(currentWeek))
		{
			_applyCache(currentWeek);
			_fetchAndCache(nextWeek);
		}
		else
		{
			setState(() => _isLoading = true);

			await Future.wait
			(
				[
					_fetchAndCache(currentWeek),
					_fetchAndCache(nextWeek),
				],
			);

			if (mounted && _cache.has(currentWeek))
			{
				_applyCache(currentWeek);
			}
			else if (mounted)
			{
				setState
				(
					()
					{
						_isLoading = false;
						_error     = 'Failed to load timetable. Check your connection and try again.';
					},
				);
			}
		}
	}

	Future<void> _checkForUpdates() async
	{
		try
		{
			final info = await _updateService.checkForUpdate();
			if (info.hasUpdate && mounted)
			{
				_updateService.showUpdateDialog(context, info);
			}
		}
		catch (_) {}
	}

	// Apply cached data to UI — strictly synchronous, never shows a spinner.
	void _applyCache(String startDate)
	{
		final cached = _cache.get(startDate)!;
		setState
		(
			()
			{
				_startDate  = startDate;
				_events     = cached.events;
				_weekNumber = cached.weekNumber;
				_isLoading  = false;
				_error      = null;
			},
		);
	}

	// Fetch and store in cache. Never touches UI state.
	Future<void> _fetchAndCache(String startDate) async
	{
		if (_cache.has(startDate)) return;

		try
		{
			final creds = await CredentialsService().load();
			if (creds.username == null || creds.password == null) return;

			final html       = await _service.fetchRaw(creds.username!, creds.password!, startDate);
			final events     = _service.parse(html);
			final weekNumber = _service.parseWeekNumber(html);

			_cache.store(startDate, events, weekNumber);
		}
		catch (_)
		{
			// Silently fail — pre-caching is best effort.
		}
	}

	Future<void> _navigateTo(String targetDate) async
	{
		if (_isFetching) return;

		// Cache hit — instant, no spinner.
		if (_cache.has(targetDate))
		{
			_applyCache(targetDate);
			return;
		}

		// Cache miss — show spinner and fetch.
		_isFetching = true;

		setState
		(
			()
			{
				_startDate = targetDate;
				_isLoading = true;
				_error     = null;
			},
		);

		try
		{
			final creds = await CredentialsService().load();

			if (creds.username == null || creds.password == null)
			{
				if (mounted) Navigator.pushReplacementNamed(context, '/');
				return;
			}

			final html       = await _service.fetchRaw(creds.username!, creds.password!, targetDate);
			final events     = _service.parse(html);
			final weekNumber = _service.parseWeekNumber(html);

			_cache.store(targetDate, events, weekNumber);

			if (mounted)
			{
				setState
				(
					()
					{
						_events     = events;
						_weekNumber = weekNumber;
						_error      = null;
					},
				);
			}
		}
		catch (e)
		{
			if (mounted) setState(() => _error = 'Failed to load timetable. Check your connection and try again.');
		}
		finally
		{
			_isFetching = false;
			if (mounted) setState(() => _isLoading = false);
		}
	}

	void _goToPrevWeek()
	{
		final prev = _service.shiftWeek(_startDate, -1);
		_navigateTo(prev);
	}

	void _goToNextWeek()
	{
		final next = _service.shiftWeek(_startDate, 1);
		_navigateTo(next);
		_fetchAndCache(_service.shiftWeek(next, 1));
	}

	void _goToCurrentWeek()
	{
		_navigateTo(_service.getCurrentWeekMonday());
	}

	String _weekLabel()
	{
		if (_isLoading)
		{
			return 'Loading... ${_service.formatWeekLabel(_startDate)}';
		}
		return _service.formatWeekLabel(_startDate, weekNumber: _weekNumber);
	}

	// ############################
	// Build.
	// ############################

	@override
	Widget build(BuildContext context)
	{
		final theme      = Theme.of(context);
		final colours    = theme.colorScheme;
		final isThisWeek = _startDate == _service.getCurrentWeekMonday();

		return Scaffold
		(
			drawer: const AppDrawer(),
			appBar: CustomAppBar(title: 'Timetable'),
			body: Column
			(
				children:
				[
					// ############################
					// Week Navigation.
					// ############################

					Padding
					(
						padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
						child: Row
						(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children:
							[
								IconButton
								(
									icon:      const Icon(Icons.chevron_left),
									onPressed: _isFetching ? null : _goToPrevWeek,
								),
								Expanded
								(
									child: Text
									(
										_weekLabel(),
										textAlign: TextAlign.center,
										style: theme.textTheme.titleSmall?.copyWith
										(
											color: _isLoading
												? colours.onSurface.withOpacity(0.45)
												: colours.onSurface,
										),
									),
								),
								IconButton
								(
									icon:      const Icon(Icons.chevron_right),
									onPressed: _isFetching ? null : _goToNextWeek,
								),
							],
						),
					),

					// Today button — only shown when not on current week.
					if (isThisWeek == false)
						Padding
						(
							padding: const EdgeInsets.only(bottom: 4),
							child: TextButton.icon
							(
								onPressed: _goToCurrentWeek,
								icon:      const Icon(Icons.today_outlined, size: 16),
								label:     const Text('Back to current week'),
							),
						),

					const Divider(height: 1),

					// ############################
					// Body.
					// ############################

					Expanded
					(
						child: _isLoading
							? const Center(child: CircularProgressIndicator())
							: _error != null
								? _ErrorView(message: _error!, onRetry: () => _navigateTo(_startDate))
								: _events.isEmpty
									? const _EmptyView()
									: _TimetableBody(events: _events),
					),
				],
			),
		);
	}
}

// ########################
// Timetable Body.
// ########################

class _TimetableBody extends StatelessWidget
{
	final List<TimetableEvent> events;

	const _TimetableBody({required this.events});

	@override
	Widget build(BuildContext context)
	{
		final Map<String, List<TimetableEvent>> grouped = {};
		for (final event in events)
		{
			grouped.putIfAbsent(event.day, () => []).add(event);
		}

		return ListView
		(
			padding: const EdgeInsets.all(16),
			children: grouped.entries.map
			(
				(entry)
				{
					return Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children:
						[
							Padding
							(
								padding: const EdgeInsets.only(top: 16, bottom: 8),
								child: Text
								(
									entry.key,
									style: Theme.of(context).textTheme.titleMedium?.copyWith
									(
										fontWeight: FontWeight.bold,
									),
								),
							),
							...entry.value.map((e) => _EventCard(event: e)),
						],
					);
				},
			).toList(),
		);
	}
}

// ########################
// Event Card.
// ########################

class _EventCard extends StatelessWidget
{
	final TimetableEvent event;

	const _EventCard({required this.event});

	@override
	Widget build(BuildContext context)
	{
		final theme   = Theme.of(context);
		final colours = theme.colorScheme;

		return Card
		(
			margin: const EdgeInsets.only(bottom: 10),
			child: Padding
			(
				padding: const EdgeInsets.all(14),
				child: Column
				(
					crossAxisAlignment: CrossAxisAlignment.start,
					children:
					[
						// Time + type chip.
						Row
						(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children:
							[
								Text
								(
									event.time,
									style: theme.textTheme.labelLarge?.copyWith
									(
										color:      colours.primary,
										fontWeight: FontWeight.bold,
									),
								),
								Chip
								(
									label: Text
									(
										event.type,
										style: theme.textTheme.labelSmall,
									),
									padding:               EdgeInsets.zero,
									materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
								),
							],
						),
						const SizedBox(height: 6),

						// Module.
						Text
						(
							event.module,
							style: theme.textTheme.bodyMedium?.copyWith
							(
								fontWeight: FontWeight.w600,
							),
						),
						const SizedBox(height: 4),

						// Room.
						Row
						(
							children:
							[
								Icon(Icons.location_on_outlined, size: 14, color: colours.onSurfaceVariant),
								const SizedBox(width: 4),
								Expanded
								(
									child: Text
									(
										event.room,
										style: theme.textTheme.bodySmall?.copyWith
										(
											color: colours.onSurfaceVariant,
										),
									),
								),
							],
						),
						const SizedBox(height: 2),

						// Lecturer.
						Row
						(
							children:
							[
								Icon(Icons.person_outline, size: 14, color: colours.onSurfaceVariant),
								const SizedBox(width: 4),
								Text
								(
									event.lecturer,
									style: theme.textTheme.bodySmall?.copyWith
									(
										color: colours.onSurfaceVariant,
									),
								),
							],
						),
					],
				),
			),
		);
	}
}

// ########################
// Empty View.
// ########################

class _EmptyView extends StatelessWidget
{
	const _EmptyView();

	@override
	Widget build(BuildContext context)
	{
		return Center
		(
			child: Column
			(
				mainAxisSize: MainAxisSize.min,
				children:
				[
					Icon
					(
						Icons.event_available_outlined,
						size:  64,
						color: Theme.of(context).colorScheme.outlineVariant,
					),
					const SizedBox(height: 16),
					Text
					(
						'No classes this week',
						style: Theme.of(context).textTheme.bodyLarge,
					),
				],
			),
		);
	}
}

// ########################
// Error View.
// ########################

class _ErrorView extends StatelessWidget
{
	final String       message;
	final VoidCallback onRetry;

	const _ErrorView({required this.message, required this.onRetry});

	@override
	Widget build(BuildContext context)
	{
		final colours = Theme.of(context).colorScheme;

		return Center
		(
			child: Padding
			(
				padding: const EdgeInsets.all(32),
				child: Column
				(
					mainAxisSize: MainAxisSize.min,
					children:
					[
						Icon(Icons.wifi_off_outlined, size: 64, color: colours.outlineVariant),
						const SizedBox(height: 16),
						Text
						(
							message,
							textAlign: TextAlign.center,
							style: Theme.of(context).textTheme.bodyMedium,
						),
						const SizedBox(height: 24),
						FilledButton.tonal
						(
							onPressed: onRetry,
							child:     const Text('Retry'),
						),
					],
				),
			),
		);
	}
}
