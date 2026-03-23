import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String get appName => _t(en: 'ZenPulse', ru: 'ZenPulse', uz: 'ZenPulse');

  String get settingsTitle =>
      _t(en: 'Settings', ru: 'Настройки', uz: 'Sozlamalar');

  String get chooseAuraTitle =>
      _t(en: 'Choose Aura', ru: 'Выбор Ауры', uz: 'Aurani Tanlash');

  String get journeyTitle =>
      _t(en: 'Your Journey', ru: 'Ваш Путь', uz: "Sizning Yo'lingiz");

  String get supportDevelopmentTitle => _t(
    en: 'Support Development',
    ru: 'Поддержать Разработчика',
    uz: "Ishlab Chiquvchini Qo'llab-quvvatlash",
  );

  String get contributionTitle => _t(
    en: 'Contribute For Developer',
    ru: 'Помощь Разработчику',
    uz: "Ishlab Chiquvchiga Hissa Qo'shish",
  );

  String get selectContributionAmount => _t(
    en: 'Select Contribution Amount',
    ru: 'Выберите Сумму Взноса',
    uz: 'Hissa Miqdorini Tanlang',
  );

  String get selectAmount =>
      _t(en: 'Select an Amount', ru: 'Выберите Сумму', uz: 'Miqdorni Tanlang');

  String get contributeNow =>
      _t(en: 'Contribute Now', ru: 'Внести Сейчас', uz: "Hozir Hissa Qo'shing");

  String get grounding =>
      _t(en: 'GROUNDING', ru: 'ЗАЗЕМЛЕНИЕ', uz: 'ZAMINLASH');

  String get startJourney =>
      _t(en: 'Start Journey', ru: 'Начать Путь', uz: 'Sayohatni Boshlash');

  String get quickPresets =>
      _t(en: 'Quick Presets', ru: 'Быстрые Пресеты', uz: 'Tez Sozlamalar');

  String get customizeAura =>
      _t(en: 'Customize Aura', ru: 'Настроить Ауру', uz: 'Aurani Sozlash');

  String get supportDevelopment => _t(
    en: 'Support Development',
    ru: 'Поддержать Разработку',
    uz: "Ishlab Chiquvchini Qo'llab-quvvatlash",
  );

  String get findInnerRhythm => _t(
    en: 'Find your inner rhythm',
    ru: 'Найдите свой внутренний ритм',
    uz: 'Ichki ritmingizni toping',
  );

  String get dayStreak =>
      _t(en: 'Day Streak', ru: 'Дней подряд', uz: 'Ketma-ket kunlar');

  String get dailyRhythm =>
      _t(en: 'Daily Rhythm', ru: 'Ежедневный Ритм', uz: 'Kunlik Ritm');

  String get soulSparks =>
      _t(en: 'Soul Sparks', ru: 'Искры Души', uz: 'Ruh Uchqunlari');

  String get quickReset =>
      _t(en: 'Quick Reset', ru: 'Быстрый Сброс', uz: 'Tez Qayta Tiklash');

  String get deepFocus =>
      _t(en: 'Deep Focus', ru: 'Глубокий Фокус', uz: 'Chuqur Diqqat');

  String get sixMinutes => _t(en: '6 minutes', ru: '6 минут', uz: '6 daqiqa');

  String get aiMoodBooster => _t(
    en: 'AI Mood Booster',
    ru: 'ИИ Усилитель Настроения',
    uz: "Sun'iy Intellekt Kayfiyat Kuchaytiruvchi",
  );

  String get sessionConfiguration => _t(
    en: 'Session Configuration',
    ru: 'Конфигурация Сессии',
    uz: 'Sessiya Konfiguratsiyasi',
  );

  String get appearance =>
      _t(en: 'Appearance', ru: 'Внешний вид', uz: "Ko'rinish");

  String get about => _t(en: 'About', ru: 'О приложении', uz: 'Dastur Haqida');

  String get privacyPolicy => _t(
    en: 'Privacy Policy',
    ru: 'Политика Конфиденциальности',
    uz: 'Maxfiylik Siyosati',
  );

  String get targetFocus =>
      _t(en: 'Target Focus', ru: 'Целевой Фокус', uz: 'Maqsad Diqqat');

  String get centeringPhase => _t(
    en: 'Centering Phase',
    ru: 'Фаза Центрирования',
    uz: 'Markazlash Fazasi',
  );

  String get meditationPhase => _t(
    en: 'Meditation Phase',
    ru: 'Фаза Медитации',
    uz: 'Meditatsiya Fazasi',
  );

  String get awakeningPhase =>
      _t(en: 'Awakening Phase', ru: 'Фаза Пробуждения', uz: "Uyg'onish Fazasi");

  String get auraLabel => _t(en: 'Aura', ru: 'Аура', uz: 'Aura');

  String get version => _t(en: 'Version', ru: 'Версия', uz: 'Versiya');

  String get language => _t(en: 'Language', ru: 'Язык', uz: 'Til');

  String get languageEnglish => 'English';
  String get languageRussian => 'Русский';
  String get languageUzbek => "O'zbek";

  String get confirm => _t(en: 'Confirm', ru: 'Подтвердить', uz: 'Tasdiqlash');

  String get minutes => _t(en: 'Minutes', ru: 'Минуты', uz: 'Daqiqalar');
  String get seconds => _t(en: 'Seconds', ru: 'Секунды', uz: 'Soniyalar');

  String get trackJourney => _t(
    en: 'Track Your Calm Journey',
    ru: 'Следите за Своим Путём',
    uz: "Tinch Yo'lingizni Kuzating",
  );

  String get weeklyRhythm =>
      _t(en: 'Weekly Rhythm', ru: 'Недельный Ритм', uz: 'Haftalik Ritm');

  String get recentJourneys => _t(
    en: 'Recent Journeys',
    ru: 'Недавние Сессии',
    uz: "So'nggi Sessiyalar",
  );

  String get avgFocus =>
      _t(en: 'Avg Focus', ru: 'Средний Фокус', uz: "O'rtacha Diqqat");

  String get mindfulness =>
      _t(en: 'Mindfulness', ru: 'Осознанность', uz: 'Ongli Fikrlash');

  String get flowStreak =>
      _t(en: 'Flow Streak', ru: 'Полоса Потока', uz: 'Oqim Seriyasi');

  String get totalSessions =>
      _t(en: 'Total Sessions', ru: 'Всего Сессий', uz: 'Jami Sessiyalar');

  String get noJourneyYet => _t(
    en: 'No sessions tracked yet. Start a meditation to build your journey.',
    ru: 'Сессий пока нет. Начните медитацию, чтобы создать свой путь.',
    uz: "Hali sessiyalar yo'q. Yo'lingizni boshlash uchun meditatsiya qiling.",
  );

  String get sessionComplete => _t(
    en: 'Session complete. +10 sparks and journey updated.',
    ru: 'Сессия завершена. +10 искр и путь обновлён.',
    uz: "Sessiya tugadi. +10 uchqun va yo'l yangilandi.",
  );

  String get contributionDescription => _t(
    en:
        'Your contribution helps support the ongoing maintenance and improvement '
        'of this application. Contributions are voluntary and do not provide '
        'additional features or content.',
    ru:
        'Ваш взнос помогает поддерживать разработку и улучшение этого приложения. '
        'Взносы добровольны и не предоставляют дополнительных функций или контента.',
    uz:
        'Sizning hissangiz ushbu ilovani qo\'llab-quvvatlash va yaxshilashga '
        'yordam beradi. Hissalar ixtiyoriy va qo\'shimcha xususiyatlar yoki '
        'kontent taqdim etmaydi.',
  );

  String _t({required String en, required String ru, required String uz}) {
    switch (locale.languageCode) {
      case 'ru':
        return ru;
      case 'uz':
        return uz;
      default:
        return en;
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
