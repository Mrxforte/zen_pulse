import 'package:flutter/material.dart';
import 'package:zen_pulse/widgets/glass_card.dart';

class JourneyStatsStrip extends StatelessWidget {
  final String leftLabel;
  final String leftValue;
  final String centerLabel;
  final String centerValue;
  final String rightLabel;
  final String rightValue;

  const JourneyStatsStrip({
    super.key,
    required this.leftLabel,
    required this.leftValue,
    required this.centerLabel,
    required this.centerValue,
    required this.rightLabel,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: BorderRadius.circular(24),
      child: Row(
        children: [
          Expanded(
            child: _StatCell(value: leftValue, label: leftLabel),
          ),
          _divider(),
          Expanded(
            child: _StatCell(value: centerValue, label: centerLabel),
          ),
          _divider(),
          Expanded(
            child: _StatCell(value: rightValue, label: rightLabel),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 52,
      color: Colors.white.withValues(alpha: 0.22),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String value;
  final String label;

  const _StatCell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 36 / 2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.72),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
