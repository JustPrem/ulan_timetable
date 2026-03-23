// ########################
// Imports.
// ########################

import 'package:ulan_timetable/services/timetable_service.dart';

// ########################
// CacheService.
// ########################

class CacheService
{
	// ############################
	// Singleton.
	// ############################

	static final CacheService _instance = CacheService._internal();

	factory CacheService() => _instance;

	CacheService._internal();

	// ############################
	// Cache Store.
	// ############################

	final Map<String, _CachedWeek> _cache = {};

	// ############################
	// Methods.
	// ############################

	bool has(String startDate) => _cache.containsKey(startDate);

	_CachedWeek? get(String startDate) => _cache[startDate];

	void store(String startDate, List<TimetableEvent> events, int? weekNumber)
	{
		_cache[startDate] = _CachedWeek(events: events, weekNumber: weekNumber);
	}

	void clear() => _cache.clear();
}

// ########################
// Cache Entry.
// ########################

class _CachedWeek
{
	final List<TimetableEvent> events;
	final int?                 weekNumber;

	const _CachedWeek({required this.events, required this.weekNumber});
}
