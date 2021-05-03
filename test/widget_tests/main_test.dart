import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_first_mvp/view/home_page.dart';

void main() {
  /*testWidgets("Testing Leaf Widgets", (WidgetTester tester) async{
    await tester.pumpWidget(Leaf());

    //test presence of material app widget
    expect(find.byType(MaterialApp), findsOneWidget);

    //test presence of homepage widget
    expect(find.byType(HomePage), findsOneWidget);
  */
  void _runTest(WidgetTester tester, Function test) async {
    await tester.pumpWidget(Leaf());
  }
    group("Testing Leaf Widgets",() {
      testWidgets("Exactly One MaterialApp widget",
          (WidgetTester tester) async {
        _runTest(
            tester, () => expect(find.byType(MaterialApp), findsOneWidget));
      },
      );
      testWidgets("Exactly One HomePage widget",
            (WidgetTester tester) async {
          _runTest(
              tester, () => expect(find.byType(HomePage), findsOneWidget));
        },
      );



  });

}