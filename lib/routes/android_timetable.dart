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
// Constants.
// ########################

const _kDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

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
	with SingleTickerProviderStateMixin
{
	// ############################
	// State.
	// ############################

	final _service       = TimetableService();
	final _cache         = CacheService();
	final _updateService = UpdateService();

	late TabController _tabController;

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
		_startDate     = _service.getCurrentWeekMonday();
		_tabController = TabController
		(
			length:       _kDays.length,
			vsync:        this,
			initialIndex: _initialTabIndex(),
		);
		_initialLoad();
		_checkForUpdates();
	}

	@override
	void dispose()
	{
		_tabController.dispose();
		super.dispose();
	}

	// ############################
	// Helpers.
	// ############################

	// Returns today's tab index if viewing current week, else Monday.
	int _initialTabIndex()
	{
		final isThisWeek = _startDate == _service.getCurrentWeekMonday();
		if (!isThisWeek) return 0;

		final weekday = DateTime.now().weekday; // 1 = Monday, 7 = Sunday
		return weekday <= 5 ? weekday - 1 : 0;
	}

	bool _isCurrentDay(int tabIndex)
	{
		final isThisWeek = _startDate == _service.getCurrentWeekMonday();
		if (!isThisWeek) return false;

		final weekday = DateTime.now().weekday;
		return weekday <= 5 && weekday - 1 == tabIndex;
	}

	Map<String, List<TimetableEvent>> get _grouped
	{
		final Map<String, List<TimetableEvent>> map = {};
		for (final day in _kDays)
		{
			map[day] = [];
		}
		for (final event in _events)
		{
			// Match event day to our canonical day names.
			final key = _kDays.firstWhere
			(
				(d) => event.day.startsWith(d),
				orElse: () => '',
			);
			if (key.isNotEmpty) map[key]!.add(event);
		}
		return map;
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

		// Jump to correct tab after applying cache.
		_tabController.animateTo(_initialTabIndex());
	}

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
		catch (_) {}
	}

	Future<void> _navigateTo(String targetDate) async
	{
		if (_isFetching) return;

		if (_cache.has(targetDate))
		{
			_applyCache(targetDate);
			return;
		}

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

				_tabController.animateTo(_initialTabIndex());
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

					if (!isThisWeek)
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

					// ############################
					// Day Tabs.
					// ############################

					TabBar
					(
						controller:        _tabController,
						isScrollable:      true,
						tabAlignment:      TabAlignment.start,
						dividerColor:      colours.outlineVariant,
						indicatorColor:    colours.primary,
						labelColor:        colours.primary,
						unselectedLabelColor: colours.onSurfaceVariant,
						tabs: List.generate
						(
							_kDays.length,
							(i)
							{
								final isToday = _isCurrentDay(i);
								return Tab
								(
									child: Row
									(
										mainAxisSize: MainAxisSize.min,
										children:
										[
											if (isToday) ...[
												Container
												(
													width:  6,
													height: 6,
													margin: const EdgeInsets.only(right: 6),
													decoration: BoxDecoration
													(
														color:  colours.primary,
														shape:  BoxShape.circle,
													),
												),
											],
											Text(_kDays[i]),
										],
									),
								);
							},
						),
					),

					// ############################
					// Body.
					// ############################

					Expanded
					(
						child: _isLoading
							? const Center(child: CircularProgressIndicator())
							: _error != null
								? _ErrorView(message: _error!, onRetry: () => _navigateTo(_startDate))
								: TabBarView
								(
									controller: _tabController,
									children: _kDays.map
									(
										(day)
										{
											final dayEvents = _grouped[day] ?? [];
											return dayEvents.isEmpty
												? _EmptyDayView(day: day)
												: _DayEventList(events: dayEvents);
										},
									).toList(),
								),
					),
				],
			),
		);
	}
}

// ########################
// Day Event List.
// ########################

class _DayEventList extends StatelessWidget
{
	final List<TimetableEvent> events;

	const _DayEventList({required this.events});

	@override
	Widget build(BuildContext context)
	{
		return ListView
		(
			padding: const EdgeInsets.all(16),
			children: events.map((e) => _EventCard(event: e)).toList(),
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
// Empty Day View.
// ########################

class _EmptyDayView extends StatelessWidget
{
	final String day;

	const _EmptyDayView({required this.day});

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
						Icons.free_breakfast_outlined,
						size:  56,
						color: Theme.of(context).colorScheme.outlineVariant,
					),
					const SizedBox(height: 12),
					Text
					(
						'No classes on $day',
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
