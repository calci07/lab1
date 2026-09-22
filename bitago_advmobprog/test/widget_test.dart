import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:bitago_advmobprog/main.dart';
import 'package:bitago_advmobprog/app_state.dart' as app_state;

void main() {
  testWidgets('Counter increments using local state', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => app_state.ThemeModel(),
        child: const StateManagementActivity(),
      ),
    );
    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });

  testWidgets(
    'Theme changes preserve the counter and counting preserves theme',
    (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => app_state.ThemeModel(),
          child: const StateManagementActivity(),
        ),
      );
      Brightness brightness() =>
          Theme.of(tester.element(find.byType(Scaffold))).brightness;

      expect(brightness(), Brightness.light);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(brightness(), Brightness.dark);
      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
      expect(brightness(), Brightness.dark);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(brightness(), Brightness.light);
      expect(find.text('2'), findsOneWidget);
    },
  );

  testWidgets('Switch changes the app theme in both directions', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => app_state.ThemeModel(),
        child: const app_state.MyApp(),
      ),
    );
    Brightness brightness() =>
        Theme.of(tester.element(find.byType(Scaffold))).brightness;

    expect(brightness(), Brightness.light);
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(brightness(), Brightness.dark);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(brightness(), Brightness.light);
  });
}
