// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:my_plan/main.dart';

void main() {
  testWidgets('displays the health dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const NutritionApp());

    expect(find.text('Good morning, Alex 👋'), findsOneWidget);
    expect(find.text("Today's Progress"), findsOneWidget);
    expect(find.text('Daily Insight'), findsOneWidget);
    expect(find.text('Search for food'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('open-settings')));
    await tester.pumpAndSettle();
    expect(find.text('Manage your account and preferences.'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text("Today's Plan"),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text("Today's Plan"), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('app-nav-1')));
    await tester.pumpAndSettle();
    expect(find.text('Plan your meals. Stay on track.'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('app-nav-2')));
    await tester.pumpAndSettle();
    expect(find.text('Log Food'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('app-nav-3')));
    await tester.pumpAndSettle();
    expect(
      find.text('Track your journey. See how far you have come.'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('app-nav-add')));
    await tester.pumpAndSettle();
    expect(find.text('Add Food'), findsOneWidget);
    expect(find.byKey(const ValueKey('app-nav-0')), findsOneWidget);
  });
}
