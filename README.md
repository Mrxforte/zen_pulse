# ZenPulse

> Written by Azamat — a Flutter meditation app for iOS and Android.

I built ZenPulse as a personal project to practice clean Flutter architecture while making something actually useful. The app lets you run guided meditation sessions, track your progress over time, and customise the whole look with colour themes called Auras.

---

## Features

**Meditation library**
A scrollable list of sessions. Free ones open immediately. Premium sessions have a lock badge and need a subscription. The layout adapts between a list and a grid based on screen size.

**Session timer**
Full-screen timer with a circular progress ring and three phases — centering, meditation, awakening. Each phase duration is configurable in settings. Finishing a session logs it to your journey and gives you 10 sparks.

**AI Mood Booster**
Pick a mood (Joy, Calm, or Energy) and get a personalised affirmation. Tap again for a new one. There is a short delay to make it feel like something is actually happening.

**Journey dashboard**
Your personal history page. Weekly bar chart, current streak, average focus minutes, mindfulness points, and a log of your last 6 sessions with dates.

**Aura system**
Six colour themes that change the whole app — gradients, cards, app bar, buttons, everything. Three are free. The other three cost sparks to unlock.

| Aura | Vibe | Unlock |
|---|---|---|
| Deep Mind | Deep purple, focused | Free |
| Nature Path | Forest green, calm | Free |
| Inner Fire | Burnt orange, energised | Free |
| Sunset Glow | Warm amber evening | 150 sparks |
| Ocean Deep | Dark teal, mysterious | 200 sparks |
| Lavender Dream | Soft purple, peaceful | 250 sparks |

**Sparks**
Earned by completing sessions (10 per session). Spent on unlocking premium Auras. You can also buy sparks through the support screen if you want to skip the grind.

**Support screen**
Five contribution tiers from $0.19 to $1.99. Each adds sparks to your balance. Totally optional.

**Settings**
Configure session phase durations, switch language between English, Russian, and Uzbek, access the Aura picker, and view the privacy policy.

**Subscription / paywall**
Monthly and yearly plans. Yearly has a "Best Value" badge. Purchase and restore are simulated.

---

## Tech stack

- **Flutter + Dart** — single codebase for iOS and Android
- **Provider** — state management
- **get_it** — dependency injection
- **SharedPreferences** — local persistence (sparks, settings, session config)
- **MVVM** — clean separation between models, state, logic, and UI

---

## Architecture

```
Model ? Service ? Provider ? ViewModel ? View
```

- `models/` — plain Dart data classes, no logic
- `services/` — MockApiService as a get_it singleton, handles data and affirmation generation
- `providers/` — ChangeNotifier classes that hold all mutable state
- `viewmodels/` — stateless Dart objects with screen-specific logic, created inside Consumer builders
- `views/` — StatelessWidget screens, read state via Consumer, call viewmodel methods
- `widgets/` — shared reusable components
- `core/` — app config, DI setup, localisations, Aura theme definitions

---

## Folder structure

```
lib/
+-- main.dart
+-- app/
¦   +-- zen_pulse_app.dart
+-- core/
¦   +-- bootstrap/
¦   +-- config/
¦   ¦   +-- aura_theme.dart         # All 6 palettes + ThemeExtension
¦   ¦   +-- app_environment.dart
¦   +-- di/
¦   +-- l10n/
¦   ¦   +-- app_localizations.dart
¦   +-- logging/
+-- models/
¦   +-- meditation.dart
¦   +-- user.dart
+-- providers/
¦   +-- affirmation_provider.dart
¦   +-- journey_provider.dart
¦   +-- meditation_provider.dart
¦   +-- settings_provider.dart
¦   +-- subscription_provider.dart
¦   +-- support_provider.dart
+-- services/
¦   +-- mock_api_service.dart
+-- utils/
¦   +-- app_icons.dart
¦   +-- app_images.dart
¦   +-- app_routes.dart
¦   +-- app_strings.dart
¦   +-- constants.dart
+-- viewmodels/
¦   +-- affirmation/
¦   +-- meditation_list/
¦   +-- paywall/
¦   +-- settings/
+-- views/
¦   +-- affirmation/
¦   +-- choose_aura/
¦   +-- home/
¦   +-- journey/
¦   +-- meditation_list/
¦   +-- meditation_timer/
¦   +-- paywall/
¦   +-- privacy_policy/
¦   +-- settings/
¦   +-- splash/
¦   +-- support_development/
+-- widgets/
    +-- glass_card.dart
    +-- journey_stats_strip.dart
    +-- metric_stat_card.dart
    +-- quick_preset_card.dart
    +-- section_title.dart
```

---

## Getting started

Requires Flutter 3.10+ and Dart 3.0+.

```bash
git clone https://github.com/Mrxforte/zen_pulse.git
cd zen_pulse
flutter pub get
flutter run
```

```bash
flutter analyze
```

---

*Built with Flutter · Written by Azamat*
