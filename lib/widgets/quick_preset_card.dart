import 'package:flutter/material.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';

class QuickPresetCard extends StatelessWidget {
  final IconData icon;
  final String duration;
  final String label;
  final VoidCallback onTap;
  final List<Color>? gradientColors;

  const QuickPresetCard({
    super.key,
    required this.icon,
    required this.duration,
    required this.label,
    required this.onTap,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                gradientColors ??
                [
                  context.aura.accent.withValues(alpha: 0.26),
                  context.aura.primary.withValues(alpha: 0.2),
                ],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: context.aura.glassBorder.withValues(alpha: 0.92),
            width: 1.4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const Spacer(),
            Text(
              duration,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34 / 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 13,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
