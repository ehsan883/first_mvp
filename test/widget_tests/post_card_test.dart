import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/view/widgets/post_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_first_mvp/helper/demo_values.dart';
import 'package:flutter_first_mvp/model/post_model.dart';
import 'package:flutter_first_mvp/model/user_model.dart';

void main() {
  testWidgets("Testing the Post Card Widgets", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp (home: PostCard()));

    expect(find.byType(AspectRatio), findsOneWidget);

    // Test: Finds Card
    expect(find.byType(Card), findsOneWidget);

    // Test: Finds CircleAvatar
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Test: Finds Image
    expect(find.byType(Image), findsOneWidget);

    // Test: Find text user name
    expect(find.text(PostModel.author.name), findsOneWidget);

    // Test: Find text user email
    expect(find.text(DemoValues.userEmail), findsOneWidget);

    // Test: Find text post title
    expect(find.text(PostModel.), findsOneWidget);

    // Test: Find text post summary
    expect(find.text(DemoValues.postSummary), findsOneWidget);

    // Test: Find text post time
    expect(find.text(DemoValues.postTime), findsOneWidget);


  });
}