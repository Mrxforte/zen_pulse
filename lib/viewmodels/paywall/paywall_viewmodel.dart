import 'package:flutter/material.dart';
import '../../providers/subscription_provider.dart';

class PaywallViewModel {
  final SubscriptionProvider subscriptionProvider;

  const PaywallViewModel({required this.subscriptionProvider});

  bool get isYearlySelected =>
      subscriptionProvider.selectedPlan == SubscriptionPlan.yearly;

  bool get isPurchasing => subscriptionProvider.isPurchasing;

  void onSelectPlan(SubscriptionPlan plan) =>
      subscriptionProvider.selectPlan(plan);

  Future<void> onPurchase(BuildContext context) async {
    await subscriptionProvider.purchase();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> onRestore(BuildContext context) async {
    await subscriptionProvider.restore();
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Restore completed.')));
    }
  }
}
