# ZenPulse — AI Meditation App

A Flutter mobile app for iOS & Android that combines a meditations library with an AI-powered daily affirmation feature and a premium subscription (paywall) flow.

---

## Project structure

```
lib/
├── main.dart                       # App entry-point, get_it setup, MultiProvider, routes
├── models/
│   ├── meditation.dart             # Meditation data class
│   └── user.dart                   # User data class (isSubscribed, selectedMood)
├── providers/                      # ChangeNotifier state containers
│   ├── subscription_provider.dart  # isSubscribed, purchase(), restore()
│   ├── meditation_provider.dart    # Loads and exposes the meditation list
│   └── affirmation_provider.dart   # Generates mood-based affirmations (mock LLM)
├── viewmodels/                     # Thin PODO screen orchestrators
│   ├── paywall_viewmodel.dart
│   ├── meditation_list_viewmodel.dart
│   └── affirmation_viewmodel.dart
├── views/                          # One file per screen
│   ├── meditations_home_screen.dart # Home — list of sessions, lock overlay
│   ├── paywall_screen.dart         # Premium subscription / paywall
│   └── affirmation_screen.dart     # AI mood booster
├── services/
│   └── mock_api_service.dart       # Simulates remote API + LLM calls
└── utils/
    └── constants.dart              # AppColors, AppSpacing, screenScale(), sp()
```

---

## Architecture

**MVVM + Provider + get_it**

| Layer | Role |
|---|---|
| **Models** | Plain Dart classes (`Meditation`, `User`) |
| **Services** | `MockApiService` — registered as a `get_it` lazy singleton; injected into providers |
| **Providers** | `ChangeNotifier` subclasses holding all mutable state — data source for ViewModels |
| **ViewModels** | Stateless PODO objects created inside `Consumer` builders; receive provider references and expose screen-specific logic |
| **Views** | `StatelessWidget` screens using `Consumer` / `Consumer2` to read state and call ViewModel methods |

Navigation uses Flutter's `Navigator` with named routes.  
`get_it` keeps `MockApiService` as a singleton decoupled from the widget tree.

---

## Features

- **Meditation list** — 10 sessions, 5 free / 5 premium. Premium cards show a semi-transparent lock overlay.
- **Paywall** — premium gradient design with a benefits list, monthly/yearly plan selector (yearly shows a "Save 50%" badge), and a "Try Free for 7 Days" CTA that simulates a purchase.
- **AI Mood Booster** — pick 😊 Joy, 😌 Calm, or 🔥 Energy; the app calls `MockApiService.getAffirmation()` which adds a 600 ms fake LLM latency and returns one of three Russian-language phrases. "Ещё" re-generates.

---

## Getting started

### Prerequisites

- Flutter ≥ 3.10 (`flutter --version`)
- Dart ≥ 3.0

### Install & run

```bash
# 1  Clone / open the project
cd zen_pulse

# 2  Fetch dependencies
flutter pub get

# 3  Run on a connected device or emulator
flutter run
```

### Lint check

```bash
flutter analyze
```

---

## How AI was used to generate this project

GitHub Copilot (Claude Sonnet 4.6) was used to:

1. **Scaffold the full project structure** — directory layout, file naming, import graph — from a natural-language prompt describing MVVM + Provider + get_it architecture requirements.
2. **Generate all Dart files** — models, providers, viewmodels, views, services and utilities — iterating on each until the analyzer reported zero issues.
3. **Implement adaptive layout** — the AI applied `MediaQuery.sizeOf`, `screenScale()` and `sp()` helpers automatically after being told the target range was iPhone SE → Pro Max.
4. **Write this README** — including the reflection answer below.

Every generated file was reviewed for correctness before being accepted.  
Repository: *(fill in after pushing to GitHub)*

---

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
