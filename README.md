# ZenPulse

ZenPulse is a meditation and mindfulness app built with Flutter. It runs on both iOS and Android from a single codebase. The app gives users a library of guided meditation sessions, a session timer with phase tracking, an AI mood booster, a personal journey dashboard, and a fully themeable UI through an "Aura" system.


---

## Features

### Meditation Library
The home screen shows a grid or list of meditation sessions depending on screen size. Free sessions are open to everyone. Premium sessions are locked behind a subscription and show a lock badge. Tapping a session goes straight to the timer.

### Session Timer
A full-screen timer screen with a circular progress ring. Tracks three phases — centering, meditation, awakening — with durations configurable in settings. When the session ends it records the result to the journey log and adds sparks to your balance.

### AI Mood Booster
Pick a mood (Joy, Calm, Energy) and the app returns a personalised affirmation. Uses a mock service that simulates an LLM response with a short delay. You can regenerate as many times as you want.

### Journey Dashboard
Tracks your history across sessions. Shows weekly activity as a bar chart, a streak counter, average focus minutes, mindfulness points, total sessions, and the last 6 session entries with dates and stats.

### Aura Themes
Six colour palettes that change the entire app — gradients, cards, app bar, all widgets. Three auras are free, three are premium and cost sparks to unlock.

| Aura | Vibe | Cost |
|---|---|---|
| Deep Mind | Purple, focus | Free |
| Nature Path | Green, renewal | Free |
| Inner Fire | Orange, energy | Free |
| Sunset Glow | Warm amber | 150 sparks |
| Ocean Deep | Deep teal | 200 sparks |
| Lavender Dream | Soft purple | 250 sparks |

### Sparks System
Sparks are an in-app currency earned by completing sessions (10 sparks each). They can also be acquired through optional contribution packs. Sparks are used to unlock premium aura themes.

### Support Development
An optional contribution screen with 5 price tiers ($0.19 – $1.99). Each purchase adds sparks to your balance. Sparks persist locally via SharedPreferences.

### Settings
- Configure session phase durations (centering, meditation, awakening, target focus)
- Switch the app language (English, Russian, Uzbek)
- Navigate to the aura picker
- View app version and privacy policy

### Subscription / Paywall
Monthly and yearly plan selector. Yearly plan shows a "Best Value" badge. Simulated purchase and restore flow.

### Localisation
Full i18n support for English, Russian, and Uzbek via Flutter's built-in localisation system. Language can be changed at runtime from settings.

---

## Architecture

The project follows **MVVM + Provider + get_it**.

| Layer | Description |
|---|---|
| `models/` | Plain Dart data classes — `Meditation`, `User` |
| `services/` | `MockApiService` registered as a get_it singleton. Handles meditation data and affirmation generation |
| `providers/` | `ChangeNotifier` classes that hold all mutable state |
| `viewmodels/` | Stateless Dart objects created inside `Consumer` builders. Contain screen-specific logic, no Flutter imports |
| `views/` | `StatelessWidget` screens that read state through `Consumer` and call viewmodel methods |
| `widgets/` | Shared reusable UI components used across screens |
| `core/` | App config, DI bootstrap, l10n access, aura theme definition |

Navigation uses Flutter's `Navigator` with named routes defined in `utils/app_routes.dart`.

---

## Folder structure

```
lib/
├── main.dart
├── app/
│   └── zen_pulse_app.dart          # MaterialApp, theme wiring, route map
├── core/
│   ├── bootstrap/                  # App startup and get_it setup
│   ├── config/
│   │   ├── aura_theme.dart         # AuraPalette ThemeExtension, all 6 palettes, buildAuraTheme()
│   │   └── app_environment.dart
│   ├── di/                         # Dependency injection helpers
│   ├── l10n/
│   │   └── app_localizations.dart  # Localisation access extension
│   └── logging/
├── models/
│   ├── meditation.dart
│   └── user.dart
├── providers/
│   ├── affirmation_provider.dart
│   ├── journey_provider.dart
│   ├── meditation_provider.dart
│   ├── settings_provider.dart      # AuraTheme enum, locale, session config
│   ├── subscription_provider.dart
│   └── support_provider.dart       # Sparks balance, contribution packs
├── services/
│   └── mock_api_service.dart
├── utils/
│   ├── app_icons.dart
│   ├── app_images.dart
│   ├── app_routes.dart
│   ├── app_strings.dart
│   └── constants.dart              # AppColors, AppSpacing, screenScale(), sp()
├── viewmodels/
│   ├── affirmation/
│   ├── meditation_list/
│   ├── paywall/
│   └── settings/
├── views/
│   ├── affirmation/                # AI Mood Booster screen
│   ├── choose_aura/                # Aura picker with unlock dialog
│   ├── home/
│   │   └── widgets/                # HomeDashboard, MeditationCard
│   ├── journey/                    # Journey stats, weekly chart, session log
│   ├── meditation_list/            # Main home screen
│   ├── meditation_timer/           # Full-screen session timer
│   ├── paywall/                    # Subscription screen
│   ├── privacy_policy/
│   ├── settings/
│   ├── splash/
│   └── support_development/        # Contribution / sparks purchase
└── widgets/
    ├── glass_card.dart             # Frosted glass card used across the app
    ├── journey_stats_strip.dart
    ├── metric_stat_card.dart
    ├── quick_preset_card.dart
    └── section_title.dart
```

---

## Getting started

### Requirements

- Flutter 3.10 or newer
- Dart 3.0 or newer
- Android Studio / Xcode for device targets

### Install

```bash
git clone https://github.com/Mrxforte/zen_pulse.git
cd zen_pulse
flutter pub get
```

### Run

```bash
flutter run
```

### Analyse

```bash
flutter analyze
```

---

## Dependencies

| Package | Purpose |
|---|---|
| `provider` | State management |
| `get_it` | Dependency injection |
| `shared_preferences` | Local persistence for sparks, settings |
| `intl` | Date formatting, plurals |
| `flutter_localizations` | i18n (en, ru, uz) |


## Контрольный вопрос

> **С какими специфическими проблемами мобильной верстки ИИ справляется хуже всего и как ты контролировал его работу, чтобы приложение не сломалось на маленьких экранах (iPhone SE vs Pro Max)?**

### Где ИИ справляется хуже всего

**1. Фиксированные размеры вместо адаптивных.**  
Самая частая ошибка — ИИ прописывал конкретные значения (`height: 120`, `fontSize: 18`) без привязки к размеру экрана. На iPhone SE (375 × 667 pt) карточки выходили за границы экрана, текст обрезался или кнопки наплывали друг на друга.

**2. Отсутствие `SafeArea` внутри кастомных контейнеров.**  
Когда фоновый `Container` с градиентом оборачивал весь `Scaffold.body`, ИИ иногда забывал добавить `SafeArea` внутрь него, из-за чего кнопки уходили под Dynamic Island / Home indicator.

**3. Переполнение `Column` без `Expanded`/`Flexible`.**  
На узких экранах ИИ-сгенерированные `Column` с несколькими крупными блоками вызывали `RenderFlex overflowed` — особенно на Paywall, где много контента в одном скролле.

**4. Жёсткие `padding` в `Row` с `Text`.**  
На Pro Max текст с большим `fontSize` вместе с бейджем «Save 50%» и ценой легко умещается, но на SE они overlapping. ИИ без принудительных подсказок не учитывал эту разницу.

### Как контролировалась работа ИИ

- **Единый `screenScale(context)`** — все размеры (кроме логических отступов 1× и 2×) умножаются на этот коэффициент, вычисляемый из `MediaQuery.sizeOf(context).width`. Диапазон зажат в `clamp(0.75, 1.2)`.
- **`sp(context, size)`** — функция-обёртка для всех `fontSize`, обеспечивающая одинаковое масштабирование шрифтов.
- **`SafeArea` на каждом экране** — явное требование было включено в промпт, и выполнение проверялось после каждого сгенерированного экрана.
- **`SingleChildScrollView` на Paywall** — предотвращает переполнение на маленьких экранах при большом количестве контента.
- **`Expanded` в `ListView`** — список медитаций занимает оставшееся место, а не растягивает Column.
- **`flutter analyze` после каждого файла** — немедленная обратная связь по типовым ошибкам, до запуска на устройстве.
- **Ручная проверка на эмуляторах** — финальный прогон на iPhone SE (375 × 667) и Pixel 9 Pro (412 × 915) подтвердил корректность отступов и читаемость текста.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
