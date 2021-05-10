import 'package:camera/camera.dart';
import 'package:flutter_first_mvp/view/camera_screen.dart';
import 'package:flutter/material.dart';
import 'view/home_page.dart';
import 'view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
//comes from the camera_screen.dart
  cameras = await availableCameras();

  await Firebase.initializeApp();
  runApp(Leaf());}

class Leaf extends StatelessWidget {

  const Leaf({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*theme: ThemeData(
        primaryColor: Colors.green,
        brightness: Brightness.light,
      ),*/
      //title: "Firebase Auth Demo",
      //home: LogInPage(title: "Firebase Auth Demo"),
      home: HomePage(), //For the social media app earlier
    );
  }
}
