# ZenPulse

A meditation app built with Flutter. Supports iOS and Android.

## What it does

- Browse a library of meditation sessions (free + premium)
- Run a timer for any session with phase tracking
- AI Mood Booster — pick a mood, get a personalised affirmation
- Weekly rhythm chart and journey stats
- Aura themes — 6 color palettes that change the whole app feel
- Support the dev with in-app spark packs

## Stack

- Flutter + Dart
- Provider for state management
- get_it for dependency injection
- Shared Preferences for local persistence
- MVVM architecture

## Run it

```bash
flutter pub get
flutter run
```

## Structure

```
lib/
  models/        # Meditation, User
  providers/     # State (subscriptions, meditations, journey, affirmations, settings, support)
  viewmodels/    # Screen logic, pure Dart
  views/         # Screens
  widgets/       # Shared UI components
  services/      # Mock API
  utils/         # Constants, routes, icons
  core/          # App config, DI, l10n, themes
```


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
