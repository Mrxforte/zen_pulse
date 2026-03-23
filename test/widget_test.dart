
import 'package:flutter_test/flutter_test.dart';
import 'package:zen_pulse/app/zen_pulse_app.dart';
import 'package:zen_pulse/core/di/service_locator.dart';

void main() {
  testWidgets('App smoke test — MeditationListScreen loads', (
    WidgetTester tester,
  ) async {
    setupServiceLocator();
    await tester.pumpWidget(const ZenPulseApp());
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('ZenPulse'), findsOneWidget);
  });
}
