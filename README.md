# ZenPulse

ZenPulse is a Flutter meditation and wellness app built with an MVVM style architecture using Provider and get_it.

It focuses on a clean experience: guided sessions, progress tracking, mood-based affirmations, customizable visual themes, and multilingual support.

## Highlights

- Guided meditation session flow with timer and progress ring
- Journey analytics with streaks, weekly rhythm, and recent sessions
- Aura theme system with unlockable premium themes
- Sparks economy (earn from sessions, spend on aura unlocks)
- Mood-based affirmation generator
- Localization support (English, Russian, Uzbek)
- Android, iOS, and web support

## App Functionality

### Meditation Home
- Dynamic dashboard with quick presets and personal stats
- Responsive layout for phone and larger screens
- Entry points to timer, journey, settings, and mood booster

### Timer Experience
- Full-screen session timer
- Visual progress indicator
- Session completion reward flow (adds sparks and records journey data)

### Journey Tracking
- Weekly activity chart
- Mindfulness points and streak metrics
- Recent session history

### AI Mood Booster
- Mood selection (Joy, Calm, Energy)
- Generated affirmations per mood
- Refresh action for new affirmation

### Aura and Personalization
- Multiple visual palettes (free and premium)
- Theme affects gradients, surfaces, and emphasis colors across screens
- Premium auras unlocked with sparks

### Settings and Preferences
- Session phase durations
- Language selector
- Aura selector
- Privacy policy screen

## Architecture

ZenPulse follows a practical MVVM pattern:

Model -> Service -> Provider -> ViewModel -> View

- models: data models
- services: data source and business API layer (mock service currently)
- providers: state holders using ChangeNotifier
- viewmodels: view-specific orchestration logic
- views: UI screens and page composition
- widgets: reusable UI building blocks
- core: app bootstrap, localization, theming, dependency injection

## Project Structure

    lib/
      main.dart
      app/
        zen_pulse_app.dart
      core/
        bootstrap/
        config/
        di/
        l10n/
        logging/
      models/
      providers/
      services/
      utils/
      viewmodels/
      views/
      widgets/

## Tech Stack

- Flutter
- Dart
- Provider
- get_it
- shared_preferences
- intl

## Installation

Prerequisites:
- Flutter SDK 3.10+
- Dart SDK 3.10+
- Android Studio or Xcode (for mobile builds)

Clone and run:

    git clone https://github.com/Mrxforte/zen_pulse.git
    cd zen_pulse
    flutter pub get
    flutter run

Useful checks:

    flutter analyze
    flutter test

## Build Commands

Android APK:

    flutter build apk --release

iOS (macOS only):

    flutter build ios --release

Web:

    flutter build web --release

## Localization

Localization lives in app localizations and currently supports:
- en
- ru
- uz

If you add a new language, update supported locales and all localization keys before release.

## Roadmap Ideas

- Replace mock API with production backend
- Add authentication and cloud sync
- Add real subscription billing integration
- Add onboarding and habit reminders
- Add CI pipeline for test, analyze, and build

## Contributing

Contributions are welcome.

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a pull request

## License

This project is private unless a license is explicitly added.

## Author

Built by Azamat.
