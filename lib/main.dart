import 'package:flutter/material.dart';
import 'view/home_page.dart';
import 'view/login_page.dart';

void main() => runApp(Leaf());

class Leaf extends StatelessWidget {

  const Leaf({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*theme: ThemeData(
        primaryColor: Colors.green,
        brightness: Brightness.light,
      ),*/
      title: "Firebase Auth Demo",
      home: LogInPage(title: "Firebase Auth Demo"),
      //home: HomePage(), //For the social media app earlier
    );
  }
}
