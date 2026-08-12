import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:joblinfo/data/app_state.dart';
import 'package:joblinfo/main.dart';

void main() {
  Widget buildTestApp() {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const JoblInfoApp(),
    );
  }

  testWidgets('home form shows only quick-log fields by default',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Position / job title'), findsOneWidget);
    expect(find.text('Company'), findsOneWidget);
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('More details'), findsOneWidget);
    expect(find.text('We\'ll suggest a follow-up in 7 days'), findsOneWidget);

    expect(find.text('Location (optional)'), findsNothing);
    expect(find.text('Applied on'), findsNothing);
    expect(find.text('Remind me to follow up'), findsNothing);
    expect(find.text('Notes (optional)'), findsNothing);
  });

  testWidgets('more details reveals optional logging fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('More details'));
    await tester.pumpAndSettle();

    expect(find.text('Location (optional)'), findsOneWidget);
    expect(find.text('Applied on'), findsOneWidget);
    expect(find.text('Remind me to follow up'), findsOneWidget);
    expect(find.text('Notes (optional)'), findsOneWidget);
  });
}
