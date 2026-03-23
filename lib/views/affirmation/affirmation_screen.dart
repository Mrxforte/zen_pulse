import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/config/aura_theme.dart';
import '../../core/l10n/app_localizations.dart';
import '../../providers/affirmation_provider.dart';
import '../../viewmodels/affirmation/affirmation_viewmodel.dart';
import '../../utils/constants.dart';

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({super.key});

  static List<({String key, String emoji, String label})> _moodsList(
    AppLocalizations l10n,
  ) {
    return [
      (key: 'joy', emoji: '😊', label: l10n.moodJoy),
      (key: 'calm', emoji: '😌', label: l10n.moodCalm),
      (key: 'energy', emoji: '🔥', label: l10n.moodEnergy),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scale = screenScale(context);
    final maxWidth = responsiveMaxContentWidth(context);
    final wideLayout = !isPhone(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.aiMoodBooster),
        leading: const BackButton(),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: context.auraBackgroundGradient),
        child: Consumer<AffirmationProvider>(
          builder: (context, affirmationProvider, _) {
            final vm = AffirmationViewModel(
              affirmationProvider: affirmationProvider,
            );
            return SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          (isPhone(context) ? AppSpacing.md : AppSpacing.lg) *
                          scale,
                      vertical: AppSpacing.sm * scale,
                    ),
                    child: wideLayout
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _MoodPanel(vm: vm, scale: scale),
                              ),
                              SizedBox(width: AppSpacing.lg * scale),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: AppSpacing.xxl * scale,
                                  ),
                                  child: _AffirmationDisplay(
                                    vm: vm,
                                    scale: scale,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _MoodPanel(vm: vm, scale: scale),
                              SizedBox(height: AppSpacing.xl * scale),
                              Expanded(
                                child: _AffirmationDisplay(
                                  vm: vm,
                                  scale: scale,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MoodPanel extends StatelessWidget {
  final AffirmationViewModel vm;
  final double scale;

  const _MoodPanel({required this.vm, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.lg * scale),
        Text(
          context.l10n.howAreYouFeeling,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: sp(context, isPhone(context) ? 24 : 28),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSpacing.xs * scale),
        Text(
          context.l10n.pickMoodSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white54, fontSize: sp(context, 14)),
        ),
        SizedBox(height: AppSpacing.xl * scale),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 14 * scale,
          runSpacing: 14 * scale,
          children: AffirmationScreen._moodsList(context.l10n).map((mood) {
            return _MoodChip(
              emoji: mood.emoji,
              label: mood.label,
              isSelected: vm.selectedMood == mood.key,
              scale: scale,
              onTap: () => vm.onMoodSelected(mood.key),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MoodChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final double scale;
  final VoidCallback onTap;

  const _MoodChip({
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.scale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 20 * scale,
          vertical: 14 * scale,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.aura.accent.withAlpha(77)
              : Colors.white.withAlpha(18),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? context.aura.accent
                : Colors.white.withAlpha(61),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: 32 * scale)),
            SizedBox(height: 6 * scale),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: sp(context, 13),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AffirmationDisplay extends StatelessWidget {
  final AffirmationViewModel vm;
  final double scale;

  const _AffirmationDisplay({required this.vm, required this.scale});

  @override
  Widget build(BuildContext context) {
    if (vm.selectedMood == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white.withAlpha(61),
              size: 56 * scale,
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              context.l10n.selectMoodPrompt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white38,
                fontSize: sp(context, 15),
                height: 1.6,
              ),
            ),
          ],
        ),
      );
    }

    if (vm.isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              context.l10n.generatingAffirmation,
              style: const TextStyle(color: Colors.white54),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4 * scale),
            padding: EdgeInsets.all(AppSpacing.lg * scale),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withAlpha(31)),
            ),
            child: Text(
              vm.currentAffirmation ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: sp(context, 20),
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.xl * scale),
          OutlinedButton.icon(
            onPressed: vm.onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(context.l10n.newAffirmation),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withAlpha(97)),
              padding: EdgeInsets.symmetric(
                horizontal: 28 * scale,
                vertical: 12 * scale,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
