import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuraTheme {
  deepMind,
  naturePath,
  innerFire,
  sunsetGlow,
  oceanDeep,
  lavenderDream,
}

extension AuraThemeExt on AuraTheme {
  String get displayName {
    switch (this) {
      case AuraTheme.deepMind:
        return 'Deep Mind';
      case AuraTheme.naturePath:
        return 'Nature Path';
      case AuraTheme.innerFire:
        return 'Inner Fire';
      case AuraTheme.sunsetGlow:
        return 'Sunset Glow';
      case AuraTheme.oceanDeep:
        return 'Ocean Deep';
      case AuraTheme.lavenderDream:
        return 'Lavender Dream';
    }
  }

  String get subtitle {
    switch (this) {
      case AuraTheme.deepMind:
        return 'Focus and clarity';
      case AuraTheme.naturePath:
        return 'Growth and renewal';
      case AuraTheme.innerFire:
        return 'Energy and passion';
      case AuraTheme.sunsetGlow:
        return 'Warm evening colors';
      case AuraTheme.oceanDeep:
        return 'Deep sea mystery';
      case AuraTheme.lavenderDream:
        return 'Peaceful night calm';
    }
  }

  int? get sparkCost {
    switch (this) {
      case AuraTheme.deepMind:
      case AuraTheme.naturePath:
      case AuraTheme.innerFire:
        return null;
      case AuraTheme.sunsetGlow:
        return 150;
      case AuraTheme.oceanDeep:
        return 200;
      case AuraTheme.lavenderDream:
        return 250;
    }
  }

  bool get isPro => sparkCost != null;

  int get swatchColorValue {
    switch (this) {
      case AuraTheme.deepMind:
        return 0xFF9730C4;
      case AuraTheme.naturePath:
        return 0xFF43A047;
      case AuraTheme.innerFire:
        return 0xFFFFA000;
      case AuraTheme.sunsetGlow:
        return 0xFF8D4B61;
      case AuraTheme.oceanDeep:
        return 0xFF4C4C9D;
      case AuraTheme.lavenderDream:
        return 0xFF6C4A8A;
    }
  }
}

class SettingsProvider extends ChangeNotifier {
  static const String _targetFocusKey = 'settings.targetFocusDuration';
  static const String _centeringPhaseKey = 'settings.centeringPhaseDuration';
  static const String _meditationPhaseKey = 'settings.meditationPhaseDuration';
  static const String _awakeningPhaseKey = 'settings.awakeningPhaseDuration';
  static const String _selectedAuraKey = 'settings.selectedAura';
  static const String _unlockedAurasKey = 'settings.unlockedAuras';
  static const String _selectedLocaleKey = 'settings.selectedLocale';

  int _targetFocusDuration = 300; // 5 min
  int _centeringPhaseDuration = 60; // 60 sec
  int _meditationPhaseDuration = 240; // 240 sec (4 min)
  int _awakeningPhaseDuration = 60; // 60 sec

  AuraTheme _selectedAura = AuraTheme.deepMind;
  Locale _selectedLocale = const Locale('en');
  Set<AuraTheme> _unlockedAuras = {
    AuraTheme.deepMind,
    AuraTheme.naturePath,
    AuraTheme.innerFire,
  };

  SettingsProvider() {
    _loadFromStorage();
  }

  int get targetFocusDuration => _targetFocusDuration;
  int get centeringPhaseDuration => _centeringPhaseDuration;
  int get meditationPhaseDuration => _meditationPhaseDuration;
  int get awakeningPhaseDuration => _awakeningPhaseDuration;
  AuraTheme get selectedAura => _selectedAura;
  Locale get selectedLocale => _selectedLocale;
  Set<AuraTheme> get unlockedAuras => Set.unmodifiable(_unlockedAuras);

  String get targetFocusDisplay => '${_targetFocusDuration ~/ 60} min';
  String get centeringPhaseDisplay => '$_centeringPhaseDuration sec';
  String get meditationPhaseDisplay => '$_meditationPhaseDuration sec';
  String get awakeningPhaseDisplay => '$_awakeningPhaseDuration sec';

  void updateTargetFocusDuration(int seconds) {
    _targetFocusDuration = seconds;
    _saveToStorage();
    notifyListeners();
  }

  void updateCenteringPhaseDuration(int seconds) {
    _centeringPhaseDuration = seconds;
    _saveToStorage();
    notifyListeners();
  }

  void updateMeditationPhaseDuration(int seconds) {
    _meditationPhaseDuration = seconds;
    _saveToStorage();
    notifyListeners();
  }

  void updateAwakeningPhaseDuration(int seconds) {
    _awakeningPhaseDuration = seconds;
    _saveToStorage();
    notifyListeners();
  }

  void updateLocale(Locale locale) {
    _selectedLocale = locale;
    _saveToStorage();
    notifyListeners();
  }

  void updateAuraTheme(AuraTheme theme) {
    if (!isAuraUnlocked(theme)) return;
    _selectedAura = theme;
    _saveToStorage();
    notifyListeners();
  }

  bool isAuraUnlocked(AuraTheme theme) {
    if (!theme.isPro) return true;
    return _unlockedAuras.contains(theme);
  }

  void unlockAura(AuraTheme theme) {
    _unlockedAuras.add(theme);
    _saveToStorage();
    notifyListeners();
  }

  int getTotalSessionDuration() {
    return _centeringPhaseDuration +
        _meditationPhaseDuration +
        _awakeningPhaseDuration;
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _targetFocusDuration =
        prefs.getInt(_targetFocusKey) ?? _targetFocusDuration;
    _centeringPhaseDuration =
        prefs.getInt(_centeringPhaseKey) ?? _centeringPhaseDuration;
    _meditationPhaseDuration =
        prefs.getInt(_meditationPhaseKey) ?? _meditationPhaseDuration;
    _awakeningPhaseDuration =
        prefs.getInt(_awakeningPhaseKey) ?? _awakeningPhaseDuration;

    final auraIndex = prefs.getInt(_selectedAuraKey);
    if (auraIndex != null &&
        auraIndex >= 0 &&
        auraIndex < AuraTheme.values.length) {
      _selectedAura = AuraTheme.values[auraIndex];
    }

    final localeCode = prefs.getString(_selectedLocaleKey);
    if (localeCode != null && ['en', 'ru', 'uz'].contains(localeCode)) {
      _selectedLocale = Locale(localeCode);
    }

    final unlockedIndexes = prefs.getStringList(_unlockedAurasKey);
    if (unlockedIndexes != null && unlockedIndexes.isNotEmpty) {
      _unlockedAuras = unlockedIndexes
          .map((e) => int.tryParse(e))
          .whereType<int>()
          .where((i) => i >= 0 && i < AuraTheme.values.length)
          .map((i) => AuraTheme.values[i])
          .toSet();

      _unlockedAuras.addAll({
        AuraTheme.deepMind,
        AuraTheme.naturePath,
        AuraTheme.innerFire,
      });
    }

    notifyListeners();
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_targetFocusKey, _targetFocusDuration);
    await prefs.setInt(_centeringPhaseKey, _centeringPhaseDuration);
    await prefs.setInt(_meditationPhaseKey, _meditationPhaseDuration);
    await prefs.setInt(_awakeningPhaseKey, _awakeningPhaseDuration);
    await prefs.setInt(_selectedAuraKey, _selectedAura.index);
    await prefs.setString(_selectedLocaleKey, _selectedLocale.languageCode);
    await prefs.setStringList(
      _unlockedAurasKey,
      _unlockedAuras.map((e) => e.index.toString()).toList(),
    );
  }
}
