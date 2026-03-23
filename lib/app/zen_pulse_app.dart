import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';
import 'package:zen_pulse/core/di/service_locator.dart';
import 'package:zen_pulse/core/l10n/app_localizations.dart';
import 'package:zen_pulse/providers/affirmation_provider.dart';
import 'package:zen_pulse/providers/journey_provider.dart';
import 'package:zen_pulse/providers/meditation_provider.dart';
import 'package:zen_pulse/providers/settings_provider.dart';
import 'package:zen_pulse/providers/subscription_provider.dart';
import 'package:zen_pulse/providers/support_provider.dart';
import 'package:zen_pulse/services/mock_api_service.dart';
import 'package:zen_pulse/utils/app_routes.dart';
import 'package:zen_pulse/views/affirmation/affirmation_screen.dart';
import 'package:zen_pulse/views/choose_aura/choose_aura_screen.dart';
import 'package:zen_pulse/views/journey/journey_screen.dart';
import 'package:zen_pulse/views/meditation_list/meditation_list_screen.dart';
import 'package:zen_pulse/views/meditation_timer/meditation_timer_screen.dart';
import 'package:zen_pulse/views/paywall/paywall_screen.dart';
import 'package:zen_pulse/views/privacy_policy/privacy_policy_screen.dart';
import 'package:zen_pulse/views/settings/settings_screen.dart';
import 'package:zen_pulse/views/splash/splash_screen.dart';
import 'package:zen_pulse/views/support_development/support_development_screen.dart';

class ZenPulseApp extends StatelessWidget {
  const ZenPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JourneyProvider()),
        ChangeNotifierProvider(create: (_) => SupportProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(
          create: (_) => MeditationProvider(serviceLocator<MockApiService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => AffirmationProvider(serviceLocator<MockApiService>()),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            onGenerateTitle: (context) => context.l10n.appName,
            debugShowCheckedModeBanner: false,
            theme: buildAuraTheme(settings.selectedAura),
            locale: settings.selectedLocale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: AppRoutes.splash,
            routes: {
              AppRoutes.splash: (_) => const SplashScreen(),
              AppRoutes.home: (_) => const MeditationListScreen(),
              AppRoutes.paywall: (_) => const PaywallScreen(),
              AppRoutes.affirmation: (_) => const AffirmationScreen(),
              AppRoutes.settings: (_) => const SettingsScreen(),
              AppRoutes.chooseAura: (_) => const ChooseAuraScreen(),
              AppRoutes.privacyPolicy: (_) => const PrivacyPolicyScreen(),
              AppRoutes.journey: (_) => const JourneyScreen(),
              AppRoutes.timer: (_) => const MeditationTimerScreen(),
              AppRoutes.supportDevelopment: (_) =>
                  const SupportDevelopmentScreen(),
            },
          );
        },
      ),
    );
  }
}
