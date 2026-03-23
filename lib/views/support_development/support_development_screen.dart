import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zen_pulse/core/l10n/app_localizations.dart';
import 'package:zen_pulse/providers/support_provider.dart';
import 'package:zen_pulse/utils/app_icons.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';
import 'package:zen_pulse/utils/constants.dart';
import 'package:zen_pulse/widgets/glass_card.dart';

class SupportDevelopmentScreen extends StatelessWidget {
  const SupportDevelopmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scale = screenScale(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.supportDevelopmentTitle),
        leading: const BackButton(),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: context.auraBackgroundGradient),
        child: Consumer<SupportProvider>(
          builder: (context, support, _) {
            return SafeArea(
              child: ListView(
                padding: EdgeInsets.all(AppSpacing.md * scale),
                children: [
                  GlassCard(
                    borderRadius: BorderRadius.circular(40),
                    padding: EdgeInsets.all(AppSpacing.lg * scale),
                    child: Column(
                      children: [
                        const Icon(
                          AppIcons.support,
                          color: Colors.white,
                          size: 52,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n.contributionTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36 / 2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n.contributionDescription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            height: 1.4,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.xl * scale),
                  Text(
                    l10n.selectContributionAmount,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md * scale),
                  ...SupportProvider.packs.map((pack) {
                    final selected = support.selectedPackId == pack.id;
                    return Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.lg * scale),
                      child: GestureDetector(
                        onTap: () => support.selectPack(pack.id),
                        child: GlassCard(
                          borderRadius: BorderRadius.circular(34),
                          padding: EdgeInsets.all(AppSpacing.lg * scale),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selected
                                        ? context.aura.accent
                                        : Colors.white.withValues(alpha: 0.55),
                                    width: 2.5,
                                  ),
                                ),
                                child: selected
                                    ? Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: context.aura.accent,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pack.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      pack.subtitle,
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.78,
                                        ),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.sm,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: selected
                                      ? context.aura.accent.withValues(
                                          alpha: 0.28,
                                        )
                                      : Colors.white.withValues(alpha: 0.2),
                                ),
                                child: Text(
                                  '\$${pack.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: AppSpacing.md * scale),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: support.selectedPack == null
                            ? Colors.white.withValues(alpha: 0.2)
                            : context.aura.premiumBadge,
                        foregroundColor: support.selectedPack == null
                            ? Colors.white70
                            : Colors.black,
                        disabledBackgroundColor: context.aura.glass,
                        disabledForegroundColor: Colors.white60,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed:
                          support.selectedPack == null || support.isProcessing
                          ? null
                          : () async {
                              final ok = await support.contributeSelectedPack();
                              if (!context.mounted) return;
                              if (ok) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Thanks! +${support.selectedPack?.sparks ?? 0} sparks added.',
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                      child: support.isProcessing
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              support.selectedPack == null
                                  ? l10n.selectAmount
                                  : l10n.contributeNow,
                              style: const TextStyle(
                                fontSize: 20 / 1.2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
