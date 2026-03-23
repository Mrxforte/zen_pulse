import 'package:flutter/material.dart';

/// All icon references used throughout the app.
/// Using named constants avoids scattering icon lookups across widgets.
class AppIcons {
  AppIcons._();

  // Navigation & actions
  static const IconData journey = Icons.insights_rounded;
  static const IconData settings = Icons.settings_outlined;
  static const IconData back = Icons.arrow_back;
  static const IconData close = Icons.close_rounded;
  static const IconData chevronRight = Icons.chevron_right;
  static const IconData refresh = Icons.refresh_rounded;

  // Home & content
  static const IconData aiMoodBooster = Icons.auto_awesome_rounded;
  static const IconData spa = Icons.spa_rounded;
  static const IconData meditation = Icons.self_improvement_rounded;
  static const IconData totalRelax = Icons.nightlight_round;
  static const IconData lock = Icons.lock_rounded;

  // Stats & journey
  static const IconData aura = Icons.palette;
  static const IconData focus = Icons.hourglass_empty_rounded;
  static const IconData mindfulness = Icons.psychology_alt_rounded;
  static const IconData streak = Icons.bolt_rounded;
  static const IconData sessions = Icons.self_improvement_rounded;
  static const IconData timerIcon = Icons.timer_rounded;

  // Timer
  static const IconData timerPlay = Icons.play_arrow_rounded;
  static const IconData timerPause = Icons.pause_rounded;

  // Misc
  static const IconData support = Icons.volunteer_activism_rounded;
  static const IconData language = Icons.language;
  static const IconData info = Icons.info_outline;
  static const IconData error = Icons.error_outline;
}
