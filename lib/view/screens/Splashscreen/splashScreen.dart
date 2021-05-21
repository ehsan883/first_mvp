import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingPage.dart';
import 'package:page_transition/page_transition.dart';


//because it changes to the login page or landing page
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  ConstantColors constantColors = ConstantColors();
  @override
//initState is only called the first time when the widget is added to the stateTree
  //So add anything required to be performed only once here
  //Widget is rebuilt again and again therefore it should not be done there

  void initState() { //Transition from SplashScreen to the Landing page done here
    Timer( //Timer starts when the widget created for the first time and then after
      //the given time it transitions
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: LandingPage(), type: PageTransitionType.leftToRight)));

    //This is required to run the initState()
    super.initState();
  }
  @override
  Widget build(BuildContext context) { //Contains the styling of the splashScreen
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: Center(
        child: RichText(
          text: TextSpan(
            text: "the",
            style: TextStyle(
              fontFamily: "Poppins",
              color: constantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 30.0
            ),
            children: <TextSpan>[
              TextSpan(
                text: "BillionEuroApp",
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: constantColors.blueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.0
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}
