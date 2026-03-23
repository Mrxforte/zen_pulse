import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zen_pulse/core/l10n/app_localizations.dart';
import 'package:zen_pulse/providers/journey_provider.dart';
import 'package:zen_pulse/providers/support_provider.dart';
import 'package:zen_pulse/utils/app_icons.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';
import 'package:zen_pulse/utils/constants.dart';

class MeditationTimerScreen extends StatefulWidget {
  const MeditationTimerScreen({super.key});

  @override
  State<MeditationTimerScreen> createState() => _MeditationTimerScreenState();
}

class _MeditationTimerScreenState extends State<MeditationTimerScreen> {
  Timer? _ticker;
  int _totalSeconds = 60;
  int _remainingSeconds = 60;
  bool _running = false;
  bool _initializedFromArgs = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initializedFromArgs) return;

    final args = ModalRoute.of(context)?.settings.arguments;
    final minutes = args is int ? args : 1;
    _totalSeconds = minutes * 60;
    _remainingSeconds = _totalSeconds;
    _initializedFromArgs = true;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _clock(int seconds) {
    final mm = (seconds ~/ 60).toString().padLeft(2, '0');
    final ss = (seconds % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  void _toggle() {
    if (_running) {
      _ticker?.cancel();
      setState(() => _running = false);
      return;
    }

    setState(() => _running = true);
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() {
          _remainingSeconds = 0;
          _running = false;
        });
        _onCompleted();
        return;
      }
      setState(() => _remainingSeconds -= 1);
    });
  }

  void _onCompleted() {
    final focusMinutes = _totalSeconds / 60;
    context.read<JourneyProvider>().recordSession(focusMinutes);
    context.read<SupportProvider>().addSparks(10);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.sessionComplete)));
  }

  @override
  Widget build(BuildContext context) {
    final progress = 1 - (_remainingSeconds / _totalSeconds);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: context.auraBackgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                      child: Text(
                        context.l10n.grounding,
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: CircularProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        strokeWidth: 2,
                        backgroundColor: Colors.white.withValues(alpha: 0.12),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _clock(_remainingSeconds),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 82 / 1.5,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 30 / 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _toggle,
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 2,
                    ),
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                  child: Icon(
                    _running ? AppIcons.timerPause : AppIcons.timerPlay,
                    color: Colors.white,
                    size: 42,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
