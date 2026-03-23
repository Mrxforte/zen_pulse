import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';
import 'package:zen_pulse/core/l10n/app_localizations.dart';
import 'package:zen_pulse/providers/settings_provider.dart';
import 'package:zen_pulse/providers/support_provider.dart';
import 'package:zen_pulse/utils/app_routes.dart';
import 'package:zen_pulse/utils/constants.dart';

class ChooseAuraScreen extends StatelessWidget {
  const ChooseAuraScreen({super.key});

  Future<void> _onAuraTap(
    BuildContext context,
    SettingsProvider settings,
    SupportProvider support,
    AuraTheme aura,
  ) async {
    if (settings.isAuraUnlocked(aura)) {
      settings.updateAuraTheme(aura);
      return;
    }

    final cost = aura.sparkCost ?? 0;
    final enough = support.sparks >= cost;

    final action = await showDialog<_UnlockAction>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        backgroundColor: context.aura.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: Text('Unlock ${aura.displayName}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(aura.subtitle),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Bolt $cost sparks',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your energy: ${support.sparks} sparks',
              style: TextStyle(
                color: enough ? Colors.white70 : Colors.redAccent,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _UnlockAction.cancel),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: enough
                  ? context.aura.premiumBadge
                  : Colors.white.withValues(alpha: 0.18),
              foregroundColor: enough ? Colors.black : Colors.white,
            ),
            onPressed: () => Navigator.pop(
              context,
              enough ? _UnlockAction.unlock : _UnlockAction.getSparks,
            ),
            child: Text(enough ? 'Unlock Now' : 'Get Sparks'),
          ),
        ],
      ),
    );

    if (action == _UnlockAction.unlock) {
      final spent = support.spendSparks(cost);
      if (spent) {
        settings.unlockAura(aura);
        settings.updateAuraTheme(aura);
      }
    }

    if (action == _UnlockAction.getSparks && context.mounted) {
      Navigator.pushNamed(context, AppRoutes.supportDevelopment);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final support = context.watch<SupportProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.chooseAuraTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: AppSpacing.md),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: context.aura.glassBorder),
              color: context.aura.glass,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.bolt_rounded,
                  size: 16,
                  color: context.aura.premiumBadge,
                ),
                const SizedBox(width: 6),
                Text(
                  '${support.sparks}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: context.auraBackgroundGradient),
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: AuraTheme.values.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final aura = AuraTheme.values[index];
            final isSelected = settings.selectedAura == aura;
            final unlocked = settings.isAuraUnlocked(aura);

            return _AuraTile(
              aura: aura,
              isSelected: isSelected,
              isUnlocked: unlocked,
              onTap: () => _onAuraTap(context, settings, support, aura),
            );
          },
        ),
      ),
    );
  }
}

enum _UnlockAction { cancel, unlock, getSparks }

class _AuraTile extends StatelessWidget {
  final AuraTheme aura;
  final bool isSelected;
  final bool isUnlocked;
  final VoidCallback onTap;

  const _AuraTile({
    required this.aura,
    required this.isSelected,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = Colors.white.withValues(alpha: isUnlocked ? 0.12 : 0.08);

    return Opacity(
      opacity: isUnlocked ? 1 : 0.65,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.2),
              width: isSelected ? 2 : 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Color(aura.swatchColorValue),
                ),
                child: !isUnlocked
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.lock_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${aura.sparkCost}',
                            style: TextStyle(
                              color: context.aura.premiumBadge,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            aura.displayName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (aura.isPro) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: context.aura.premiumBadge,
                              ),
                            ),
                            child: Text(
                              'PRO',
                              style: TextStyle(
                                color: context.aura.premiumBadge,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      aura.subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (!isUnlocked) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Bolt ${aura.sparkCost} sparks to unlock',
                        style: TextStyle(
                          color: context.aura.premiumBadge,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 38,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
