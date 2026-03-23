import 'package:flutter/material.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';
import 'package:zen_pulse/core/l10n/app_localizations.dart';
import 'package:zen_pulse/providers/journey_provider.dart';
import 'package:zen_pulse/providers/support_provider.dart';
import 'package:zen_pulse/utils/app_icons.dart';
import 'package:zen_pulse/utils/app_routes.dart';
import 'package:zen_pulse/utils/constants.dart';
import 'package:zen_pulse/widgets/glass_card.dart';
import 'package:zen_pulse/widgets/journey_stats_strip.dart';
import 'package:zen_pulse/widgets/quick_preset_card.dart';

class HomeDashboard extends StatelessWidget {
  final JourneyProvider journey;
  final SupportProvider support;
  final double scale;
  final bool emptyState;

  const HomeDashboard({
    super.key,
    required this.journey,
    required this.support,
    required this.scale,
    this.emptyState = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tints = context.aura.meditationTints;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.findInnerRhythm,
          style: TextStyle(color: Colors.white70, fontSize: sp(context, 16)),
        ),
        SizedBox(height: AppSpacing.md * scale),
        GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          borderRadius: BorderRadius.circular(36),
          backgroundColor: context.aura.glass,
          borderColor: context.aura.glassBorder,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.spa_rounded, color: Colors.white, size: 84),
              const SizedBox(height: 18),
              Text(
                l10n.startJourney,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42 / 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.18),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 12,
                  ),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.timer, arguments: 6),
                child: Text(l10n.sixMinutes),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xl * scale),
        Text(
          l10n.quickPresets,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.3,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppSpacing.md * scale),
        SizedBox(
          height: 192 * scale,
          child: Row(
            children: [
              Expanded(
                child: QuickPresetCard(
                  icon: AppIcons.streak,
                  duration: '5m',
                  label: l10n.quickReset,
                  gradientColors: [
                    tints[0].withValues(alpha: 0.42),
                    tints[3].withValues(alpha: 0.32),
                  ],
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.timer,
                    arguments: 5,
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.md * scale),
              Expanded(
                child: QuickPresetCard(
                  icon: AppIcons.mindfulness,
                  duration: '25m',
                  label: l10n.deepFocus,
                  gradientColors: [
                    tints[2].withValues(alpha: 0.42),
                    tints[5].withValues(alpha: 0.32),
                  ],
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.timer,
                    arguments: 25,
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.md * scale),
              Expanded(
                child: QuickPresetCard(
                  icon: Icons.nightlight_round,
                  duration: '45m',
                  label: l10n.totalRelax,
                  gradientColors: [
                    tints[7].withValues(alpha: 0.42),
                    tints[9].withValues(alpha: 0.32),
                  ],
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.timer,
                    arguments: 45,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xl * scale),
        Text(
          l10n.journeyTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.3,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppSpacing.md * scale),
        JourneyStatsStrip(
          leftLabel: l10n.dayStreak,
          leftValue: '${journey.flowStreak}',
          centerLabel: l10n.dailyRhythm,
          centerValue: '${journey.avgFocusMinutes.toStringAsFixed(1)}m',
          rightLabel: l10n.soulSparks,
          rightValue: '${support.sparks}',
        ),
        SizedBox(height: AppSpacing.md * scale),
        GlassCard(
          backgroundColor: context.aura.glass,
          borderColor: context.aura.glassBorder,
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: context.aura.accent.withValues(alpha: 0.35),
                  child: const Icon(AppIcons.aura, color: Colors.white),
                ),
                title: Text(
                  l10n.customizeAura,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  l10n.changeColorsSubtitle,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: () => Navigator.pushNamed(context, AppRoutes.chooseAura),
              ),
              Divider(color: context.aura.glassBorder),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: context.aura.accent.withValues(alpha: 0.35),
                  child: const Icon(AppIcons.support, color: Colors.white),
                ),
                title: Text(
                  l10n.supportDevelopment,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  l10n.getSparksSubtitle,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.supportDevelopment),
              ),
            ],
          ),
        ),
        if (emptyState) ...[
          SizedBox(height: AppSpacing.lg * scale),
          Text(
            l10n.noMeditationsAvailable,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
          ),
        ],
      ],
    );
  }
}
