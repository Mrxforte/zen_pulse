import 'package:flutter/foundation.dart';
import '../services/mock_api_service.dart';

class AffirmationProvider extends ChangeNotifier {
  final MockApiService _apiService;

  String? _currentAffirmation;
  bool _isLoading = false;
  String? _selectedMood;

  String? get currentAffirmation => _currentAffirmation;
  bool get isLoading => _isLoading;
  String? get selectedMood => _selectedMood;

  AffirmationProvider(this._apiService);

  Future<void> generateAffirmation(String mood) async {
    _selectedMood = mood;
    _isLoading = true;
    _currentAffirmation = null;
    notifyListeners();
    final affirmation = await _apiService.getAffirmation(mood);
    _currentAffirmation = affirmation;
    _isLoading = false;
    notifyListeners();
  }
}
