import 'package:flutter/material.dart';
import '../../models/meditation.dart';
import '../../providers/journey_provider.dart';
import '../../providers/meditation_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../utils/app_routes.dart';

class MeditationListViewModel {
  final MeditationProvider meditationProvider;
  final SubscriptionProvider subscriptionProvider;
  final JourneyProvider journeyProvider;

  const MeditationListViewModel({
    required this.meditationProvider,
    required this.subscriptionProvider,
    required this.journeyProvider,
  });

  bool get isLoading => meditationProvider.isLoading;
  String? get error => meditationProvider.error;
  List<Meditation> get meditations => meditationProvider.meditations;

  bool canAccess(Meditation meditation) =>
      !meditation.isPremium || subscriptionProvider.isSubscribed;

  void onCardTap(BuildContext context, Meditation meditation) {
    if (!canAccess(meditation)) {
      Navigator.of(context).pushNamed(AppRoutes.paywall);
    } else {
      journeyProvider.recordSessionFromDurationText(meditation.duration);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${meditation.title} tracked in your journey.'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
