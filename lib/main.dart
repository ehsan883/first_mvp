import 'package:camera/camera.dart';
import 'package:flutter_first_mvp/view/screens/Feed/feedHelpers.dart';
import 'package:flutter_first_mvp/view/screens/Homepage/homepageHelpers.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingHelpers.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingServices.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingUtils.dart';
import 'package:flutter_first_mvp/view/screens/Profile/profileHelpers.dart';
import 'package:flutter_first_mvp/view/screens/Splashscreen/splashScreen.dart';
import 'package:flutter_first_mvp/view/services/Authentication.dart';
import 'package:flutter_first_mvp/view/services/FirebaseOperations.dart';
import 'package:flutter_first_mvp/view/utils/postOptions.dart';
import 'package:flutter_first_mvp/view/utils/uploadPost.dart';
import 'package:flutter_first_mvp/view/widgets/camera_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/home_page.dart';
import 'view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/screens/Splashscreen/splashScreen.dart';

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
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
        child: MaterialApp(
            theme: ThemeData(
                accentColor: constantColors.blueColor,
                fontFamily: "Poppins",
                canvasColor: Colors.transparent
            ),
            //title: "Firebase Auth Demo",
            debugShowCheckedModeBanner: false,
            home: SplashScreen()),
        providers: [ //All the classes with CHangeNotifier have been initialized here
          ChangeNotifierProvider(create: (_)=>PostFunctions()),
          ChangeNotifierProvider(create: (_)=>FeedHelpers()),
          ChangeNotifierProvider(create: (_)=>UploadPost()),
          ChangeNotifierProvider(create: (_)=>ProfileHelpers()),
          ChangeNotifierProvider(create: (_)=>HomepageHelpers()),
          ChangeNotifierProvider(create: (_)=>LandingUtils()),
          ChangeNotifierProvider(create: (_)=>FirebaseOperations()),
          ChangeNotifierProvider(create: (_)=>LandingService()),
          ChangeNotifierProvider(create: (_)=>Authentication()),
          ChangeNotifierProvider(create: (_)=>LandingHelpers())]);
      //LogInPage(title: "Firebase Auth Demo"),
       //For the social media app earlier
  }
}
