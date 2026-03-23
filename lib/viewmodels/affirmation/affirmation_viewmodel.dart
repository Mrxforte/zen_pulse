import '../../providers/affirmation_provider.dart';

class AffirmationViewModel {
  final AffirmationProvider affirmationProvider;

  const AffirmationViewModel({required this.affirmationProvider});

  String? get currentAffirmation => affirmationProvider.currentAffirmation;
  bool get isLoading => affirmationProvider.isLoading;
  String? get selectedMood => affirmationProvider.selectedMood;

  Future<void> onMoodSelected(String mood) =>
      affirmationProvider.generateAffirmation(mood);

  Future<void> onRetry() {
    final mood = affirmationProvider.selectedMood;
    if (mood == null) return Future.value();
    return affirmationProvider.generateAffirmation(mood);
  }
}
