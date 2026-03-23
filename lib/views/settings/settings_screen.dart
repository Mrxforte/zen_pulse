import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';
import 'package:zen_pulse/core/l10n/app_localizations.dart';
import 'package:zen_pulse/providers/settings_provider.dart';
import 'package:zen_pulse/utils/app_icons.dart';
import 'package:zen_pulse/utils/app_routes.dart';
import 'package:zen_pulse/utils/constants.dart';
import 'package:zen_pulse/viewmodels/settings/settings_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final viewModel = SettingsViewModel(context.watch<SettingsProvider>());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.settingsTitle),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: context.auraBackgroundGradient),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(l10n.sessionConfiguration),
                const SizedBox(height: AppSpacing.md),
                _buildSessionConfigCard(viewModel),
                const SizedBox(height: AppSpacing.xl),

                _buildSectionHeader(l10n.appearance),
                const SizedBox(height: AppSpacing.md),
                _buildAppearanceCard(viewModel),
                const SizedBox(height: AppSpacing.xl),

                _buildSectionHeader(l10n.about),
                const SizedBox(height: AppSpacing.md),
                _buildAboutCard(),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSessionConfigCard(SettingsViewModel viewModel) {
    final l10n = context.l10n;
    return Container(
      decoration: BoxDecoration(
        color: context.aura.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.aura.accent.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          _buildConfigItem(
            label: l10n.targetFocus,
            value: viewModel.targetFocusDisplay,
            onTap: () => _showDurationPicker(
              context,
              l10n.targetFocus,
              viewModel.targetFocusDuration,
              (duration) => viewModel.updateTargetFocus(duration),
            ),
          ),
          Divider(color: context.aura.glassBorder, height: 32),
          _buildConfigItem(
            label: l10n.centeringPhase,
            value: viewModel.centeringPhaseDisplay,
            onTap: () => _showDurationPicker(
              context,
              l10n.centeringPhase,
              viewModel.centeringPhaseDuration,
              (duration) => viewModel.updateCenteringPhase(duration),
            ),
          ),
          Divider(color: context.aura.glassBorder, height: 32),
          _buildConfigItem(
            label: l10n.meditationPhase,
            value: viewModel.meditationPhaseDisplay,
            onTap: () => _showDurationPicker(
              context,
              l10n.meditationPhase,
              viewModel.meditationPhaseDuration,
              (duration) => viewModel.updateMeditationPhase(duration),
            ),
          ),
          Divider(color: context.aura.glassBorder, height: 32),
          _buildConfigItem(
            label: l10n.awakeningPhase,
            value: viewModel.awakeningPhaseDisplay,
            onTap: () => _showDurationPicker(
              context,
              l10n.awakeningPhase,
              viewModel.awakeningPhaseDuration,
              (duration) => viewModel.updateAwakeningPhase(duration),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: context.aura.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: context.aura.accent, size: 18),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Total: ${viewModel.getTotalSessionDuration()}',
                  style: TextStyle(
                    color: context.aura.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigItem({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: context.aura.accent,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(Icons.chevron_right, color: Colors.white24, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceCard(SettingsViewModel viewModel) {
    final l10n = context.l10n;
    final settings = context.watch<SettingsProvider>();

    return Container(
      decoration: BoxDecoration(
        color: context.aura.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.aura.accent.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.chooseAura),
            child: Row(
              children: [
                Icon(AppIcons.aura, color: context.aura.accent, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  l10n.auraLabel,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  viewModel.selectedAura.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.aura.accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white24,
                  size: 20,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(color: context.aura.glassBorder, height: 1),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(Icons.language, color: context.aura.accent, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  l10n.language,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: settings.selectedLocale.languageCode,
                  dropdownColor: context.aura.card,
                  iconEnabledColor: Colors.white70,
                  style: TextStyle(
                    color: context.aura.accent,
                    fontWeight: FontWeight.w600,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(l10n.languageEnglish),
                    ),
                    DropdownMenuItem(
                      value: 'ru',
                      child: Text(l10n.languageRussian),
                    ),
                    DropdownMenuItem(
                      value: 'uz',
                      child: Text(l10n.languageUzbek),
                    ),
                  ],
                  onChanged: (code) {
                    if (code == null) return;
                    context.read<SettingsProvider>().updateLocale(Locale(code));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    final l10n = context.l10n;
    return Container(
      decoration: BoxDecoration(
        color: context.aura.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.aura.accent.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _launchPrivacyPolicy(),
            child: Row(
              children: [
                Icon(Icons.privacy_tip, color: context.aura.accent, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  l10n.privacyPolicy,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white24,
                  size: 20,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(Icons.info_outline, color: context.aura.accent, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.version,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDurationPicker(
    BuildContext context,
    String title,
    int currentDuration,
    Function(int) onDurationSelected,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.aura.card,
      builder: (context) {
        final l10n = context.l10n;
        int selectedMinutes = currentDuration ~/ 60;
        int selectedSeconds = currentDuration % 60;
        final minutesController = FixedExtentScrollController(
          initialItem: selectedMinutes.clamp(0, 10),
        );
        final secondsController = FixedExtentScrollController(
          initialItem: (selectedSeconds ~/ 5).clamp(0, 11),
        );

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            l10n.minutes,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          SizedBox(
                            width: 80,
                            height: 150,
                            child: ListWheelScrollView(
                              controller: minutesController,
                              itemExtent: 40,
                              physics: const FixedExtentScrollPhysics(),
                              onSelectedItemChanged: (index) {
                                setState(() => selectedMinutes = index);
                              },
                              children: List.generate(
                                11,
                                (index) => Center(
                                  child: Text(
                                    '$index',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: selectedMinutes == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: selectedMinutes == index
                                          ? context.aura.accent
                                          : Colors.white54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Column(
                        children: [
                          Text(
                            l10n.seconds,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          SizedBox(
                            width: 80,
                            height: 150,
                            child: ListWheelScrollView(
                              controller: secondsController,
                              itemExtent: 40,
                              physics: const FixedExtentScrollPhysics(),
                              onSelectedItemChanged: (index) {
                                setState(() => selectedSeconds = index * 5);
                              },
                              children: List.generate(
                                12,
                                (index) => Center(
                                  child: Text(
                                    '${index * 5}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: selectedSeconds == index * 5
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: selectedSeconds == index * 5
                                          ? context.aura.accent
                                          : Colors.white54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.aura.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        int totalSeconds =
                            selectedMinutes * 60 + selectedSeconds;
                        onDurationSelected(totalSeconds);
                        Navigator.pop(context);
                      },
                      child: Text(
                        l10n.confirm,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _launchPrivacyPolicy() {
    Navigator.pushNamed(context, AppRoutes.privacyPolicy);
  }
}
