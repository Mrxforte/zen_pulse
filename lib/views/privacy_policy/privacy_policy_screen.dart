import 'package:flutter/material.dart';
import 'package:zen_pulse/core/config/aura_theme.dart';
import 'package:zen_pulse/utils/constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: Container(
        decoration: BoxDecoration(gradient: context.auraBackgroundGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ZenPulse Privacy Policy',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                'We respect your privacy. This app stores session configuration '
                'locally on your device during runtime and does not sell your data. '
                'No personal data is shared with third parties in this demo build.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              Text(
                'Data We Use',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                '- Session durations you configure\n'
                '- Selected appearance aura\n'
                '- Subscription state in mock/demo mode',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              Text(
                'Contact',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'If you have privacy concerns, contact support@zenpulse.app',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
