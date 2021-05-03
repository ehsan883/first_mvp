import 'package:flutter_first_mvp/view/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/view/widgets/post_card.dart';

void main() {
  testWidgets("Testing HomePage Widget", (WidgetTester tester) async{

    await tester.pumpWidget(MaterialApp(home: HomePage()));

    //Test Scaffold Widget presence
    expect(find.byType(Scaffold), findsOneWidget);

    //Test AppBar Widget presence
    expect(find.byType(AppBar), findsOneWidget);


    //Test Text Widget presence
    //expect(find.byType(Text), findsNWidgets(2));

    //Test Text "Leaf"  presence
    expect(find.text("Leaf"), findsOneWidget);

    //Test Text "Leaf"  presence

    //expect(find.text("Hello World"), findsOneWidget);

    expect(find.byType(ListView), findsWidgets);

    // Test: PostCard presence
    expect(find.byType(PostCard), findsWidgets);


  });
}