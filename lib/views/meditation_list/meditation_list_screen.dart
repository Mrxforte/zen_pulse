import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/config/aura_theme.dart';
import '../../core/l10n/app_localizations.dart';
import '../../providers/journey_provider.dart';
import '../../providers/meditation_provider.dart';
import '../../providers/support_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_routes.dart';
import '../../utils/constants.dart';
import '../../viewmodels/meditation_list/meditation_list_viewmodel.dart';
import '../home/widgets/home_dashboard.dart';
import '../home/widgets/meditation_card.dart';

class MeditationListScreen extends StatelessWidget {
  const MeditationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scale = screenScale(context);
    final maxWidth = responsiveMaxContentWidth(context);
    final columns = meditationGridColumns(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appName,
          style: TextStyle(
            fontSize: sp(context, isPhone(context) ? 22 : 26),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          _TopIconAction(
            icon: AppIcons.journey,
            tooltip: 'Journey',
            onTap: () => Navigator.pushNamed(context, AppRoutes.journey),
          ),
          SizedBox(width: 8 * scale),
          _TopIconAction(
            icon: AppIcons.settings,
            tooltip: 'Settings',
            onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
          _TopIconAction(
            icon: Icons.auto_awesome_rounded,
            tooltip: 'AI Mood Booster',
            onTap: () => Navigator.pushNamed(context, AppRoutes.affirmation),
          ),
          SizedBox(width: 8 * scale),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: context.auraBackgroundGradient),
        child:
            Consumer4<
              MeditationProvider,
              SubscriptionProvider,
              JourneyProvider,
              SupportProvider
            >(
              builder:
                  (
                    context,
                    meditationProvider,
                    subscriptionProvider,
                    journeyProvider,
                    supportProvider,
                    _,
                  ) {
                    final vm = MeditationListViewModel(
                      meditationProvider: meditationProvider,
                      subscriptionProvider: subscriptionProvider,
                      journeyProvider: journeyProvider,
                    );

                    if (vm.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (vm.error != null) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              vm.error!,
                              style: const TextStyle(color: Colors.white54),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  meditationProvider.loadMeditations(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    return SafeArea(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0 * scale,
                              vertical: AppSpacing.sm * scale,
                            ),
                            child: _buildMeditationContent(
                              context,
                              vm,
                              journeyProvider,
                              supportProvider,
                              columns,
                              scale,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
            ),
      ),
    );
  }
}

class _TopIconAction extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _TopIconAction({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
              width: 1.2,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

Widget _buildMeditationContent(
  BuildContext context,
  MeditationListViewModel vm,
  JourneyProvider journey,
  SupportProvider support,
  int columns,
  double scale,
) {
  if (vm.meditations.isEmpty) {
    return SingleChildScrollView(
      child: HomeDashboard(
        journey: journey,
        support: support,
        scale: scale,
        emptyState: true,
      ),
    );
  }

  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: HomeDashboard(journey: journey, support: support, scale: scale),
      ),
      SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg * scale)),
      if (columns == 1)
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index.isOdd) {
              return SizedBox(height: AppSpacing.md * scale);
            }
            final meditationIndex = index ~/ 2;
            final m = vm.meditations[meditationIndex];
            return MeditationCard(
              meditation: m,
              canAccess: vm.canAccess(m),
              scale: scale,
              onTap: () => vm.onCardTap(context, m),
            );
          }, childCount: vm.meditations.length * 2 - 1),
        )
      else
        SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            final m = vm.meditations[index];
            return MeditationCard(
              meditation: m,
              canAccess: vm.canAccess(m),
              scale: scale,
              onTap: () => vm.onCardTap(context, m),
            );
          }, childCount: vm.meditations.length),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: AppSpacing.md * scale,
            mainAxisSpacing: AppSpacing.md * scale,
            childAspectRatio: 0.95,
          ),
        ),
      SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg * scale)),
    ],
  );
}
