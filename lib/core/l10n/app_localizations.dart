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

  // ── Home dashboard ──────────────────────────────────────────────────────────

  String get totalRelax =>
      _t(en: 'Total Relax', ru: 'Полное Расслабление', uz: 'To\'liq Dam');

  String get changeColorsSubtitle => _t(
    en: 'Change colors and atmosphere',
    ru: 'Сменить цвета и атмосферу',
    uz: 'Rang va muhitni o\'zgartiring',
  );

  String get getSparksSubtitle => _t(
    en: 'Get sparks and support updates',
    ru: 'Получить искры и поддержать обновления',
    uz: 'Uchqunlar oling va yangilanishlarni qo\'llab-quvvatlang',
  );

  String get noMeditationsAvailable => _t(
    en: 'No meditation sessions available right now.',
    ru: 'Сессии медитации пока недоступны.',
    uz: 'Hozircha meditatsiya sessiyalari mavjud emas.',
  );

  // ── Common actions ──────────────────────────────────────────────────────────

  String get retry => _t(en: 'Retry', ru: 'Повторить', uz: 'Qayta urinish');

  String get cancelLabel => _t(en: 'Cancel', ru: 'Отмена', uz: 'Bekor qilish');

  String get unlockNow =>
      _t(en: 'Unlock Now', ru: 'Разблокировать', uz: 'Hozir ochish');

  String get getSparksLabel =>
      _t(en: 'Get Sparks', ru: 'Получить Искры', uz: 'Uchqun Olish');

  // ── AI Mood Booster ─────────────────────────────────────────────────────────

  String get howAreYouFeeling => _t(
    en: 'How are you feeling?',
    ru: 'Как вы себя чувствуете?',
    uz: 'O\'zingizni qanday his qilyapsiz?',
  );

  String get pickMoodSubtitle => _t(
    en: 'Pick a mood to receive your personalised affirmation.',
    ru: 'Выберите настроение, чтобы получить персональное аффирмацию.',
    uz: 'Shaxsiy affirmatsiya olish uchun kayfiyatni tanlang.',
  );

  String get selectMoodPrompt => _t(
    en: 'Select a mood above\nto get your affirmation',
    ru: 'Выберите настроение выше\nчтобы получить аффирмацию',
    uz: 'Affirmatsiya olish uchun\nyuqoridan kayfiyat tanlang',
  );

  String get generatingAffirmation => _t(
    en: 'Generating your affirmation…',
    ru: 'Генерируем вашу аффирмацию…',
    uz: 'Affirmatsiyangiz yaratilmoqda…',
  );

  String get newAffirmation => _t(en: 'New one', ru: 'Новая', uz: 'Yangi');

  String get moodJoy => _t(en: 'Joy', ru: 'Радость', uz: 'Quvonch');

  String get moodCalm => _t(en: 'Calm', ru: 'Спокойствие', uz: 'Tinchlik');

  String get moodEnergy => _t(en: 'Energy', ru: 'Энергия', uz: 'Energiya');

  // ── Splash ──────────────────────────────────────────────────────────────────

  String get tagline => _t(
    en: 'Rhythm for your mind',
    ru: 'Ритм для вашего разума',
    uz: 'Fikringiz uchun ritm',
  );

  // ── Journey / weekdays ──────────────────────────────────────────────────────

  List<String> get weekdayLabels => [
    _t(en: 'Mon', ru: 'Пн', uz: 'Du'),
    _t(en: 'Tue', ru: 'Вт', uz: 'Se'),
    _t(en: 'Wed', ru: 'Ср', uz: 'Ch'),
    _t(en: 'Thu', ru: 'Чт', uz: 'Pa'),
    _t(en: 'Fri', ru: 'Пт', uz: 'Ju'),
    _t(en: 'Sat', ru: 'Сб', uz: 'Sh'),
    _t(en: 'Sun', ru: 'Вс', uz: 'Ya'),
  ];

  // ── Choose Aura dialog ──────────────────────────────────────────────────────

  String unlockAura(String auraName) => _t(
    en: 'Unlock $auraName?',
    ru: 'Разблокировать $auraName?',
    uz: '$auraName ni ochish?',
  );

  String sparksCost(int cost) =>
      _t(en: '$cost sparks', ru: '$cost искр', uz: '$cost uchqun');

  String yourEnergy(int sparks) => _t(
    en: 'Your energy: $sparks sparks',
    ru: 'Ваша энергия: $sparks искр',
    uz: 'Energiyangiz: $sparks uchqun',
  );

  // ── Support / sparks ────────────────────────────────────────────────────────

  String sparksAdded(int sparks) => _t(
    en: 'Thanks! +$sparks sparks added.',
    ru: 'Спасибо! +$sparks искр добавлено.',
    uz: 'Rahmat! +$sparks uchqun qo\'shildi.',
  );

  // ── Settings ────────────────────────────────────────────────────────────────

  String sessionTotal(String duration) =>
      _t(en: 'Total: $duration', ru: 'Итого: $duration', uz: 'Jami: $duration');

  // ── Privacy policy / agreements ───────────────────────────────────────────

  String get privacyPolicyHeading => _t(
    en: 'ZenPulse Privacy Policy',
    ru: 'Политика Конфиденциальности ZenPulse',
    uz: 'ZenPulse Maxfiylik Siyosati',
  );

  String get privacyPolicySummary => _t(
    en:
        'We respect your privacy. This app stores session configuration '
        'locally on your device during runtime and does not sell your data. '
        'No personal data is shared with third parties in this demo build.',
    ru:
        'Мы уважаем вашу конфиденциальность. Это приложение сохраняет '
        'настройки сессий локально на вашем устройстве во время работы и не '
        'продаёт ваши данные. В этой демо-версии личные данные не передаются '
        'третьим лицам.',
    uz:
        'Biz sizning maxfiyligingizni hurmat qilamiz. Ilova sessiya '
        'sozlamalarini ish jarayonida qurilmangizda mahalliy saqlaydi va '
        'ma\'lumotlaringizni sotmaydi. Ushbu demo versiyada shaxsiy '
        'ma\'lumotlar uchinchi tomonlarga uzatilmaydi.',
  );

  String get dataWeUseTitle => _t(
    en: 'Data We Use',
    ru: 'Какие Данные Мы Используем',
    uz: 'Biz Foydalanadigan Ma\'lumotlar',
  );

  String get dataUseItemSessionDurations => _t(
    en: '- Session durations you configure',
    ru: '- Настроенные вами длительности сессий',
    uz: '- Siz sozlagan sessiya davomiyliklari',
  );

  String get dataUseItemAura => _t(
    en: '- Selected appearance aura',
    ru: '- Выбранная тема-аура оформления',
    uz: '- Tanlangan tashqi ko\'rinish aurasi',
  );

  String get dataUseItemSubscription => _t(
    en: '- Subscription state in mock/demo mode',
    ru: '- Состояние подписки в mock/demo режиме',
    uz: '- Mock/demo rejimidagi obuna holati',
  );

  String get contactTitle => _t(en: 'Contact', ru: 'Контакты', uz: 'Aloqa');

  String get privacyContactText => _t(
    en: 'If you have privacy concerns, contact support@zenpulse.app',
    ru:
        'Если у вас есть вопросы по конфиденциальности, свяжитесь с '
        'support@zenpulse.app',
    uz:
        'Agar maxfiylik bo\'yicha savollaringiz bo\'lsa, '
        'support@zenpulse.app manziliga yozing',
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
