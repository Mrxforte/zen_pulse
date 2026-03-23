import '../models/meditation.dart';

class MockApiService {
  static const List<Map<String, dynamic>> _meditationData = [];

  static const Map<String, List<String>> _affirmations = {
    'joy': [
      'Сегодня день полон возможностей. Ты готов сиять!',
      'Радость живёт внутри тебя. Позволь ей расцвести сегодня.',
      'Каждый момент — подарок. Наслаждайся этим прекрасным днём!',
    ],
    'calm': [
      'Позволь себе просто быть. Внутренний покой уже с тобой.',
      'Дыши глубоко. Всё, что тебе нужно, уже внутри.',
      'В тишине рождается мудрость. Ты в безопасности здесь и сейчас.',
    ],
    'energy': [
      'Используй свою энергию для великих дел. Ты — сила!',
      'Огонь внутри тебя горит ярко. Зажги свой путь сегодня.',
      'Ты обладаешь невероятной силой. Иди и создавай великое!',
    ],
  };

  Future<List<Meditation>> getMeditations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _meditationData
        .map(
          (data) => Meditation(
            id: data['id'] as String,
            title: data['title'] as String,
            duration: data['duration'] as String,
            colorIndex: data['colorIndex'] as int,
            isPremium: data['isPremium'] as bool,
          ),
        )
        .toList();
  }

  Future<String> getAffirmation(String mood) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final phrases = _affirmations[mood] ?? _affirmations['calm']!;
    final index = DateTime.now().second % phrases.length;
    return phrases[index];
  }
}
