import 'package:flutter/material.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';
import 'package:zen_pulse/models/meditation.dart';
import 'package:zen_pulse/utils/constants.dart';

class MeditationCard extends StatelessWidget {
  final Meditation meditation;
  final bool canAccess;
  final double scale;
  final VoidCallback onTap;

  const MeditationCard({
    super.key,
    required this.meditation,
    required this.canAccess,
    required this.scale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tints = context.aura.meditationTints;
    final cardColor = tints[meditation.colorIndex % tints.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8 * scale,
              offset: Offset(0, 4 * scale),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSpacing.md * scale),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.self_improvement_rounded,
                        color: Colors.white70,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          meditation.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sp(context, 16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg * scale),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_rounded,
                        color: Colors.white54,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        meditation.duration,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: sp(context, 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!canAccess)
              Positioned(
                top: 10 * scale,
                right: 10 * scale,
                child: Container(
                  padding: EdgeInsets.all(6 * scale),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    color: Colors.white70,
                    size: 16 * scale,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
