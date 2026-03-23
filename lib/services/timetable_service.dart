// ########################
// Imports.
// ########################

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

// ########################
// Model.
// ########################

class TimetableEvent
{
	final String day;
	final String time;
	final String module;
	final String room;
	final String lecturer;
	final String type;

	const TimetableEvent
	({
		required this.day,
		required this.time,
		required this.module,
		required this.room,
		required this.lecturer,
		required this.type,
	});
}

// ########################
// Service.
// ########################

class TimetableService
{
	// ############################
	// Date Helpers.
	// ############################

	// Always work in UTC to avoid DST shifting the date when adding/subtracting days.
	DateTime _todayUtc()
	{
		final now = DateTime.now();
		return DateTime.utc(now.year, now.month, now.day);
	}

	DateTime _parseUtc(String date)
	{
		final parts = date.split('-');
		return DateTime.utc
		(
			int.parse(parts[0]),
			int.parse(parts[1]),
			int.parse(parts[2]),
		);
	}

	String _formatDate(DateTime date) =>
		'${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

	String _fmtDay(DateTime date) =>
		'${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';

	String getCurrentWeekMonday()
	{
		final today  = _todayUtc();
		final monday = today.subtract(Duration(days: today.weekday - 1));
		return _formatDate(monday);
	}

	String shiftWeek(String startDate, int weekDelta)
	{
		final date    = _parseUtc(startDate);
		final shifted = date.add(Duration(days: 7 * weekDelta));
		return _formatDate(shifted);
	}

	String formatWeekLabel(String startDate, {int? weekNumber})
	{
		final monday  = _parseUtc(startDate);
		final friday  = monday.add(const Duration(days: 4));
		final weekTag = weekNumber != null ? '(Week $weekNumber) ' : '';

		return '$weekTag${_fmtDay(monday)} – ${_fmtDay(friday)}/${friday.year}';
	}

	// ############################
	// Fetch.
	// ############################

	Future<String> fetchRaw
	(
		String username,
		String password,
		String startDate,
	) async
	{
		final authUser    = '$username@lancashire.ac.uk';
		final credentials = base64Encode(utf8.encode('$authUser:$password'));
		final uri         = Uri.https
		(
			'apps.uclan.ac.uk',
			'/TimeTables/SpanWeek/WkMatrix',
			{
				'entId':     username,
				'entType':   'Student',
				'startDate': startDate,
			},
		);

		final response = await http.get
		(
			uri,
			headers:
			{
				'Authorization': 'Basic $credentials',
				'User-Agent':    'Mozilla/5.0',
			},
		);

		if (response.statusCode == 200)
		{
			return response.body;
		}
		else
		{
			throw Exception('Failed to fetch timetable (${response.statusCode})');
		}
	}

	Future<bool> verifyCredentials(String username, String password) async
	{
		await fetchRaw(username, password, getCurrentWeekMonday());
		return true;
	}

	// ############################
	// Parse.
	// ############################

	List<TimetableEvent> parse(String html)
	{
		final document = htmlParser.parse(html);
		final events   = <TimetableEvent>[];
		final rows     = document.querySelectorAll('tbody tr');

		for (final row in rows)
		{
			final dayHeader = row.querySelector('th.TimeTableRowHeader');
			if (dayHeader == null) continue;

			final day   = dayHeader.text.trim().split('\n').first.trim();
			final cells = row.querySelectorAll('td.StuTTEvent');

			for (final cell in cells)
			{
				final strongs = cell.querySelectorAll('strong');
				final spans   = cell.querySelectorAll('span');

				final time   = strongs.isNotEmpty ? strongs[0].text.trim() : '';
				final module = spans.isNotEmpty   ? spans[0].text.trim()   : '';
				final room   = strongs.length > 1 ? strongs[1].text.trim() : '';
				final type   = strongs.length > 2 ? strongs[2].text.trim() : '';

				final allText  = cell.text.trim();
				final lines    = allText
					.split('\n')
					.map((l) => l.trim())
					.where((l) => l.isNotEmpty)
					.toList();

				final roomIdx  = lines.indexWhere((l) => l == room);
				final lecturer = (roomIdx != -1 && roomIdx + 1 < lines.length)
					? lines[roomIdx + 1]
					: '';

				events.add
				(
					TimetableEvent
					(
						day:      day,
						time:     time,
						module:   module,
						room:     room,
						lecturer: lecturer,
						type:     type,
					),
				);
			}
		}

		return events;
	}

	int? parseWeekNumber(String html)
	{
		final document = htmlParser.parse(html);
		final header   = document.querySelector('th#week_number');
		if (header == null) return null;

		final match = RegExp(r'\d+').firstMatch(header.text);
		return match != null ? int.tryParse(match.group(0)!) : null;
	}
}
