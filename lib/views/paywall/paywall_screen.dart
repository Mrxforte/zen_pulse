import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/config/aura_theme.dart';
import '../../providers/subscription_provider.dart';
import '../../utils/app_routes.dart';
import '../../viewmodels/paywall/paywall_viewmodel.dart';
import '../../utils/constants.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SubscriptionProvider>(
        builder: (context, subProvider, _) {
          final vm = PaywallViewModel(subscriptionProvider: subProvider);
          return _PaywallBody(vm: vm);
        },
      ),
    );
  }
}

class _PaywallBody extends StatelessWidget {
  final PaywallViewModel vm;
  const _PaywallBody({required this.vm});

  @override
  Widget build(BuildContext context) {
    final scale = screenScale(context);
    final maxWidth = responsiveMaxContentWidth(context);
    return OrientationBuilder(
      builder: (context, orientation) {
        final wideLayout =
            !isPhone(context) || orientation == Orientation.landscape;
        return _buildContent(context, scale, maxWidth, wideLayout);
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    double scale,
    double maxWidth,
    bool wideLayout,
  ) {
    return Container(
      decoration: BoxDecoration(gradient: context.auraBackgroundGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal:
                (isPhone(context) ? AppSpacing.md : AppSpacing.lg) * scale,
            vertical: AppSpacing.sm * scale,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white54),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm * scale),
                  if (wideLayout)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _Header(scale: scale),
                              SizedBox(height: AppSpacing.lg * scale),
                              _BenefitsList(scale: scale),
                            ],
                          ),
                        ),
                        SizedBox(width: AppSpacing.lg * scale),
                        Expanded(
                          child: Column(
                            children: [
                              _PlanSelector(vm: vm, scale: scale),
                              SizedBox(height: AppSpacing.lg * scale),
                              _PurchaseButton(vm: vm, scale: scale),
                              SizedBox(height: AppSpacing.sm * scale),
                              TextButton(
                                onPressed: () => vm.onRestore(context),
                                child: Text(
                                  'Restore Purchases',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: sp(context, 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _Header(scale: scale),
                    SizedBox(height: AppSpacing.lg * scale),
                    _BenefitsList(scale: scale),
                    SizedBox(height: AppSpacing.lg * scale),
                    _PlanSelector(vm: vm, scale: scale),
                    SizedBox(height: AppSpacing.lg * scale),
                    _PurchaseButton(vm: vm, scale: scale),
                    SizedBox(height: AppSpacing.sm * scale),
                    TextButton(
                      onPressed: () => vm.onRestore(context),
                      child: Text(
                        'Restore Purchases',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: sp(context, 13),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: AppSpacing.sm * scale),
                  _Footer(scale: scale),
                  SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final double scale;
  const _Header({required this.scale});

  @override
  Widget build(BuildContext context) {
    final headlineSize = sp(context, isPhone(context) ? 28 : 34);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 72 * scale,
          height: 72 * scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: context.aura.heroGradient),
            boxShadow: [
              BoxShadow(
                color: context.aura.accent.withAlpha(102),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Icon(
            Icons.self_improvement,
            color: Colors.white,
            size: 36 * scale,
          ),
        ),
        SizedBox(height: AppSpacing.md * scale),
        Text(
          'ZenPulse Plus',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: headlineSize,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          'Unlock your full potential',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white60, fontSize: sp(context, 15)),
        ),
      ],
    );
  }
}

class _BenefitsList extends StatelessWidget {
  final double scale;
  const _BenefitsList({required this.scale});

  static const List<({IconData icon, String text})> _benefits = [
    (icon: Icons.library_music, text: '500+ meditations'),
    (icon: Icons.school, text: 'Exclusive courses'),
    (icon: Icons.download_done_rounded, text: 'Offline access'),
    (icon: Icons.psychology, text: 'Personal recommendations'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md * scale),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha(31)),
      ),
      child: Column(
        children: _benefits.map((b) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6 * scale),
            child: Row(
              children: [
                Container(
                  width: 36 * scale,
                  height: 36 * scale,
                  decoration: BoxDecoration(
                    color: context.aura.accent.withAlpha(51),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    b.icon,
                    color: context.aura.accent,
                    size: 18 * scale,
                  ),
                ),
                SizedBox(width: AppSpacing.md * scale),
                Expanded(
                  child: Text(
                    b.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sp(context, 15),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.check_circle_rounded,
                  color: context.aura.accent,
                  size: 20 * scale,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _PlanSelector extends StatelessWidget {
  final PaywallViewModel vm;
  final double scale;
  const _PlanSelector({required this.vm, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PlanCard(
          title: 'Yearly',
          price: '\$49.99',
          period: 'per year',
          badge: 'Save 50%',
          isSelected: vm.isYearlySelected,
          onTap: () => vm.onSelectPlan(SubscriptionPlan.yearly),
          scale: scale,
        ),
        SizedBox(height: 10 * scale),
        _PlanCard(
          title: 'Monthly',
          price: '\$9.99',
          period: 'per month',
          isSelected: !vm.isYearlySelected,
          onTap: () => vm.onSelectPlan(SubscriptionPlan.monthly),
          scale: scale,
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final String? badge;
  final bool isSelected;
  final VoidCallback onTap;
  final double scale;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    this.badge,
    required this.isSelected,
    required this.onTap,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(AppSpacing.md * scale),
        decoration: BoxDecoration(
          color: isSelected
              ? context.aura.accent.withAlpha(64)
              : Colors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? context.aura.accent
                : Colors.white.withAlpha(61),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20 * scale,
              height: 20 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? context.aura.accent
                      : Colors.white.withAlpha(97),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10 * scale,
                        height: 10 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.aura.accent,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: AppSpacing.md * scale),
            Expanded(
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sp(context, 16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (badge != null) ...[
                    SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8 * scale,
                        vertical: 2 * scale,
                      ),
                      decoration: BoxDecoration(
                        color: context.aura.premiumBadge,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: sp(context, 10),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sp(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  period,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: sp(context, 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PurchaseButton extends StatelessWidget {
  final PaywallViewModel vm;
  final double scale;
  const _PurchaseButton({required this.vm, required this.scale});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54 * scale,
      child: vm.isPurchasing
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(31),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ),
            )
          : Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: context.auraButtonGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: context.aura.accent.withAlpha(102),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () => vm.onPurchase(context),
                  borderRadius: BorderRadius.circular(14),
                  child: Center(
                    child: Text(
                      'Try Free for 7 Days',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sp(context, 17),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _Footer extends StatelessWidget {
  final double scale;
  const _Footer({required this.scale});

  void _showTerms(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Terms of Use page will be available soon.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: Colors.white38, fontSize: sp(context, 12));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.privacyPolicy),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white38,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text('Privacy Policy', style: style),
        ),
        Text(' • ', style: style),
        TextButton(
          onPressed: () => _showTerms(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white38,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text('Terms of Use', style: style),
        ),
      ],
    );
  }
}
