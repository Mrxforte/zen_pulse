import 'package:flutter/foundation.dart';
import '../models/meditation.dart';
import '../services/mock_api_service.dart';

class MeditationProvider extends ChangeNotifier {
  final MockApiService _apiService;

  List<Meditation> _meditations = [];
  bool _isLoading = false;
  String? _error;

  List<Meditation> get meditations => List.unmodifiable(_meditations);
  bool get isLoading => _isLoading;
  String? get error => _error;

  MeditationProvider(this._apiService) {
    loadMeditations();
  }

  Future<void> loadMeditations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _meditations = await _apiService.getMeditations();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
