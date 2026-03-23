import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JourneyEntry {
  final DateTime date;
  final double focusMinutes;
  final int points;

  const JourneyEntry({
    required this.date,
    required this.focusMinutes,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'focusMinutes': focusMinutes,
      'points': points,
    };
  }

  factory JourneyEntry.fromMap(Map<String, dynamic> map) {
    return JourneyEntry(
      date: DateTime.parse(map['date'] as String),
      focusMinutes: (map['focusMinutes'] as num).toDouble(),
      points: map['points'] as int,
    );
  }
}

class JourneyProvider extends ChangeNotifier {
  static const String _totalSessionsKey = 'journey.totalSessions';
  static const String _totalFocusMinutesKey = 'journey.totalFocusMinutes';
  static const String _mindfulnessPointsKey = 'journey.mindfulnessPoints';
  static const String _flowStreakKey = 'journey.flowStreak';
  static const String _weeklyMinutesKey = 'journey.weeklyMinutes';
  static const String _recentEntriesKey = 'journey.recentEntries';
  static const String _lastSessionDateKey = 'journey.lastSessionDate';

  int _totalSessions = 0;
  double _totalFocusMinutes = 0;
  int _mindfulnessPoints = 0;
  int _flowStreak = 0;
  DateTime? _lastSessionDate;

  List<double> _weeklyMinutes = List<double>.filled(7, 0);
  List<JourneyEntry> _recentEntries = [];

  JourneyProvider() {
    _loadFromStorage();
  }

  int get totalSessions => _totalSessions;
  int get mindfulnessPoints => _mindfulnessPoints;
  int get flowStreak => _flowStreak;
  List<double> get weeklyMinutes => List.unmodifiable(_weeklyMinutes);
  List<JourneyEntry> get recentEntries => List.unmodifiable(_recentEntries);

  double get avgFocusMinutes {
    if (_totalSessions == 0) return 0;
    return _totalFocusMinutes / _totalSessions;
  }

  void recordSessionFromDurationText(String durationText) {
    final parsed = _extractMinutes(durationText);
    recordSession(parsed);
  }

  void recordSession(double focusMinutes) {
    final now = DateTime.now();
    final points = (focusMinutes * 10).round().clamp(10, 200);

    _totalSessions += 1;
    _totalFocusMinutes += focusMinutes;
    _mindfulnessPoints += points;

    _updateFlowStreak(now);

    final weekdayIndex = now.weekday - 1;
    _weeklyMinutes[weekdayIndex] += focusMinutes;

    _recentEntries = [
      JourneyEntry(date: now, focusMinutes: focusMinutes, points: points),
      ..._recentEntries,
    ];
    if (_recentEntries.length > 15) {
      _recentEntries = _recentEntries.take(15).toList();
    }

    _lastSessionDate = now;
    _saveToStorage();
    notifyListeners();
  }

  double _extractMinutes(String text) {
    final numberMatch = RegExp(r'\d+(?:\.\d+)?').firstMatch(text);
    if (numberMatch == null) return 1.0;
    return double.tryParse(numberMatch.group(0) ?? '1') ?? 1.0;
  }

  void _updateFlowStreak(DateTime now) {
    if (_lastSessionDate == null) {
      _flowStreak = 1;
      return;
    }

    final prev = DateTime(
      _lastSessionDate!.year,
      _lastSessionDate!.month,
      _lastSessionDate!.day,
    );
    final cur = DateTime(now.year, now.month, now.day);
    final diff = cur.difference(prev).inDays;

    if (diff == 0) {
      return;
    }
    if (diff == 1) {
      _flowStreak += 1;
      return;
    }
    _flowStreak = 1;
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    _totalSessions = prefs.getInt(_totalSessionsKey) ?? _totalSessions;
    _totalFocusMinutes =
        prefs.getDouble(_totalFocusMinutesKey) ?? _totalFocusMinutes;
    _mindfulnessPoints =
        prefs.getInt(_mindfulnessPointsKey) ?? _mindfulnessPoints;
    _flowStreak = prefs.getInt(_flowStreakKey) ?? _flowStreak;

    final weeklyRaw = prefs.getString(_weeklyMinutesKey);
    if (weeklyRaw != null) {
      final decoded = (jsonDecode(weeklyRaw) as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList();
      if (decoded.length == 7) {
        _weeklyMinutes = decoded;
      }
    }

    final entriesRaw = prefs.getString(_recentEntriesKey);
    if (entriesRaw != null) {
      final decoded = jsonDecode(entriesRaw) as List<dynamic>;
      _recentEntries = decoded
          .map((e) => JourneyEntry.fromMap(e as Map<String, dynamic>))
          .toList();
    }

    final lastSessionIso = prefs.getString(_lastSessionDateKey);
    if (lastSessionIso != null) {
      _lastSessionDate = DateTime.tryParse(lastSessionIso);
    }

    notifyListeners();
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_totalSessionsKey, _totalSessions);
    await prefs.setDouble(_totalFocusMinutesKey, _totalFocusMinutes);
    await prefs.setInt(_mindfulnessPointsKey, _mindfulnessPoints);
    await prefs.setInt(_flowStreakKey, _flowStreak);
    await prefs.setString(_weeklyMinutesKey, jsonEncode(_weeklyMinutes));
    await prefs.setString(
      _recentEntriesKey,
      jsonEncode(_recentEntries.map((e) => e.toMap()).toList()),
    );

    if (_lastSessionDate != null) {
      await prefs.setString(
        _lastSessionDateKey,
        _lastSessionDate!.toIso8601String(),
      );
    }
  }
}
