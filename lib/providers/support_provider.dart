import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContributionPack {
  final int id;
  final String title;
  final String subtitle;
  final double price;
  final int sparks;

  const ContributionPack({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.sparks,
  });
}

class SupportProvider extends ChangeNotifier {
  static const String _sparksKey = 'support.sparks';

  int _sparks = 0;
  int? _selectedPackId;
  bool _isProcessing = false;

  static const List<ContributionPack> packs = [
    ContributionPack(
      id: 1,
      title: 'Pack 1',
      subtitle: 'Contribute For Developer 1',
      price: 0.19,
      sparks: 20,
    ),
    ContributionPack(
      id: 2,
      title: 'Pack 2',
      subtitle: 'Contribute For Developer 2',
      price: 0.29,
      sparks: 35,
    ),
    ContributionPack(
      id: 3,
      title: 'Pack 3',
      subtitle: 'Contribute For Developer 3',
      price: 0.49,
      sparks: 60,
    ),
    ContributionPack(
      id: 4,
      title: 'Pack 4',
      subtitle: 'Contribute For Developer 4',
      price: 0.99,
      sparks: 120,
    ),
    ContributionPack(
      id: 5,
      title: 'Pack 5',
      subtitle: 'Contribute For Developer 5',
      price: 1.99,
      sparks: 260,
    ),
    ContributionPack(
      id: 6,
      title: 'Pack 6',
      subtitle: 'Contribute For Developer 6',
      price: 2.99,
      sparks: 420,
    ),
    ContributionPack(
      id: 7,
      title: 'Pack 7',
      subtitle: 'Contribute For Developer 7',
      price: 4.99,
      sparks: 760,
    ),
    ContributionPack(
      id: 8,
      title: 'Pack 8',
      subtitle: 'Contribute For Developer 8',
      price: 10.99,
      sparks: 1800,
    ),
    ContributionPack(
      id: 9,
      title: 'Pack 9',
      subtitle: 'Contribute For Developer 9',
      price: 19.99,
      sparks: 3600,
    ),
    ContributionPack(
      id: 10,
      title: 'Pack 10',
      subtitle: 'Contribute For Developer 10',
      price: 29.99,
      sparks: 6000,
    ),
  ];

  SupportProvider() {
    _load();
  }

  int get sparks => _sparks;
  int? get selectedPackId => _selectedPackId;
  bool get isProcessing => _isProcessing;

  ContributionPack? get selectedPack {
    if (_selectedPackId == null) return null;
    for (final pack in packs) {
      if (pack.id == _selectedPackId) return pack;
    }
    return null;
  }

  void selectPack(int id) {
    _selectedPackId = id;
    notifyListeners();
  }

  Future<bool> contributeSelectedPack() async {
    final pack = selectedPack;
    if (pack == null) return false;
    _isProcessing = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 900));
    _sparks += pack.sparks;

    _isProcessing = false;
    await _save();
    notifyListeners();
    return true;
  }

  bool spendSparks(int amount) {
    if (amount <= 0) return true;
    if (_sparks < amount) return false;
    _sparks -= amount;
    _save();
    notifyListeners();
    return true;
  }

  void addSparks(int amount) {
    if (amount <= 0) return;
    _sparks += amount;
    _save();
    notifyListeners();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _sparks = prefs.getInt(_sparksKey) ?? _sparks;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sparksKey, _sparks);
  }
}
