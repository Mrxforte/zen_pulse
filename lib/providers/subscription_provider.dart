import 'package:flutter/foundation.dart';

enum SubscriptionPlan { monthly, yearly }

class SubscriptionProvider extends ChangeNotifier {
  bool _isSubscribed = false;
  SubscriptionPlan _selectedPlan = SubscriptionPlan.yearly;
  bool _isPurchasing = false;

  bool get isSubscribed => _isSubscribed;
  SubscriptionPlan get selectedPlan => _selectedPlan;
  bool get isPurchasing => _isPurchasing;

  void selectPlan(SubscriptionPlan plan) {
    _selectedPlan = plan;
    notifyListeners();
  }

  Future<void> purchase() async {
    _isPurchasing = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _isSubscribed = true;
    _isPurchasing = false;
    notifyListeners();
  }

  Future<void> restore() async {
    _isPurchasing = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    _isPurchasing = false;
    notifyListeners();
  }
}
