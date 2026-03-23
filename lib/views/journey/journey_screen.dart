import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zen_pulse/core/l10n/app_localizations.dart';
import 'package:zen_pulse/providers/journey_provider.dart';
import 'package:zen_pulse/utils/app_icons.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';
import 'package:zen_pulse/utils/constants.dart';
import 'package:zen_pulse/widgets/glass_card.dart';
import 'package:zen_pulse/widgets/metric_stat_card.dart';
import 'package:zen_pulse/widgets/section_title.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scale = screenScale(context);
    final maxWidth = responsiveMaxContentWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.journeyTitle),
        leading: const BackButton(),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: context.auraBackgroundGradient),
        child: Consumer<JourneyProvider>(
          builder: (context, journey, _) {
            return SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      final horizontal =
                          (isPhone(context) ? AppSpacing.md : AppSpacing.lg) *
                          scale;
                      return SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          horizontal,
                          AppSpacing.md * scale,
                          horizontal,
                          AppSpacing.xl * scale,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMetricsGrid(
                              context,
                              journey,
                              orientation,
                              scale,
                            ),
                            SizedBox(height: AppSpacing.xl * scale),
                            SectionTitle(text: l10n.weeklyRhythm),
                            SizedBox(height: AppSpacing.md * scale),
                            _WeeklyRhythmCard(minutes: journey.weeklyMinutes),
                            SizedBox(height: AppSpacing.xl * scale),
                            SectionTitle(text: l10n.recentJourneys),
                            SizedBox(height: AppSpacing.md * scale),
                            _RecentJourneysList(entries: journey.recentEntries),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(
    BuildContext context,
    JourneyProvider journey,
    Orientation orientation,
    double scale,
  ) {
    final crossAxisCount = orientation == Orientation.landscape ? 4 : 2;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md * scale,
      mainAxisSpacing: AppSpacing.md * scale,
      childAspectRatio: 1.1,
      children: [
        MetricStatCard(
          icon: AppIcons.focus,
          value: '${journey.avgFocusMinutes.toStringAsFixed(1)} min',
          label: context.l10n.avgFocus,
        ),
        MetricStatCard(
          icon: AppIcons.mindfulness,
          value: '${journey.mindfulnessPoints} pts',
          label: context.l10n.mindfulness,
        ),
        MetricStatCard(
          icon: AppIcons.streak,
          value: '${journey.flowStreak} days',
          label: context.l10n.flowStreak,
        ),
        MetricStatCard(
          icon: AppIcons.sessions,
          value: '${journey.totalSessions}',
          label: context.l10n.totalSessions,
        ),
      ],
    );
  }
}

class _WeeklyRhythmCard extends StatelessWidget {
  final List<double> minutes;

  const _WeeklyRhythmCard({required this.minutes});

  @override
  Widget build(BuildContext context) {
    final maxValue = minutes.fold<double>(0, (a, b) => a > b ? a : b);
    final labels = context.l10n.weekdayLabels;

    return GlassCard(
      child: SizedBox(
        height: 220,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (index) {
            final value = minutes[index];
            final ratio = maxValue <= 0 ? 0 : (value / maxValue);
            final barHeight = 8.0 + (ratio * 140.0);

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 42,
                  height: barHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: context.aura.heroGradient,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  labels[index],
                  style: TextStyle(
                    color: context.aura.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _RecentJourneysList extends StatelessWidget {
  final List<JourneyEntry> entries;

  const _RecentJourneysList({required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return GlassCard(
        child: Text(
          context.l10n.noJourneyYet,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 15,
            height: 1.4,
          ),
        ),
      );
    }

    return Column(
      children: entries.take(6).map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: GlassCard(
            borderRadius: BorderRadius.circular(20),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.aura.accent,
                  ),
                  child: const Icon(
                    Icons.spa_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy').format(entry.date),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${entry.focusMinutes.toStringAsFixed(1)} min · ${entry.points} pts',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
