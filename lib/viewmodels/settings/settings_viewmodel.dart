import 'package:flutter/foundation.dart';
import 'package:zen_pulse/providers/settings_provider.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsProvider _settingsProvider;

  SettingsViewModel(this._settingsProvider);

  SettingsProvider get settingsProvider => _settingsProvider;

  int get targetFocusDuration => _settingsProvider.targetFocusDuration;
  int get centeringPhaseDuration => _settingsProvider.centeringPhaseDuration;
  int get meditationPhaseDuration => _settingsProvider.meditationPhaseDuration;
  int get awakeningPhaseDuration => _settingsProvider.awakeningPhaseDuration;

  String get targetFocusDisplay => _settingsProvider.targetFocusDisplay;
  String get centeringPhaseDisplay => _settingsProvider.centeringPhaseDisplay;
  String get meditationPhaseDisplay => _settingsProvider.meditationPhaseDisplay;
  String get awakeningPhaseDisplay => _settingsProvider.awakeningPhaseDisplay;

  AuraTheme get selectedAura => _settingsProvider.selectedAura;
  List<AuraTheme> get availableAuras => AuraTheme.values;

  void updateTargetFocus(int seconds) {
    _settingsProvider.updateTargetFocusDuration(seconds);
    notifyListeners();
  }

  void updateCenteringPhase(int seconds) {
    _settingsProvider.updateCenteringPhaseDuration(seconds);
    notifyListeners();
  }

  void updateMeditationPhase(int seconds) {
    _settingsProvider.updateMeditationPhaseDuration(seconds);
    notifyListeners();
  }

  void updateAwakeningPhase(int seconds) {
    _settingsProvider.updateAwakeningPhaseDuration(seconds);
    notifyListeners();
  }

  void updateAuraTheme(AuraTheme theme) {
    _settingsProvider.updateAuraTheme(theme);
    notifyListeners();
  }

  String getTotalSessionDuration() {
    int totalSeconds = _settingsProvider.getTotalSessionDuration();
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    if (seconds > 0) {
      return '$minutes min $seconds sec';
    }
    return '$minutes min';
  }
}
