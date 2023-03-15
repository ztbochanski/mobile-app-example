import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wasteagram/widgets/app_scaffold.dart';

void main() {
  testWidgets('Scaffold must contain a title', (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: AppScaffold(title: 'Test Title')));

    expect(find.text('Test Title'), findsOneWidget);
  });

  testWidgets('Scaffold can contain a FAB', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: AppScaffold(
            title: 'Test Title',
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ))));

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Scaffold can contain a child', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: AppScaffold(title: 'Test Title', child: Text('Test Child'))));

    expect(find.text('Test Child'), findsOneWidget);
  });
}
