import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/screens/Homepage/Homepage.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingServices.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingUtils.dart';
import 'package:flutter_first_mvp/view/services/Authentication.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../home_page.dart';

class LandingHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

  Widget bodyImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/login.png"))),
    );
  }

  Widget taglineText(BuildContext context) {
    return Positioned(
        top: 450.0,
        left: 10.0,
        child: Container(
          constraints: BoxConstraints(maxWidth: 190.0),
          child: RichText(
            text: TextSpan(
                text: "Are ",
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: constantColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                children: <TextSpan>[
                  TextSpan(
                      text: "You ",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 34.0)),
                  TextSpan(
                      text: "Motivated",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: constantColors.blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 34.0)),
                  TextSpan(
                      text: "?",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 34.0))
                ]),
          ),
        ));
  }

  //This is where new screens are being opened and app goes further
  Widget mainButtons(BuildContext context) {
    return Positioned(
        top: 630,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    emailAuthSheet(context);
                  },
                  child: Container(
                    //This is the container of the single button
                    child: Icon(
                      EvaIcons.emailOutline,
                      color: constantColors.yellowColor,
                    ),
                    width: 80.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: constantColors.yellowColor),
                        borderRadius: BorderRadius.circular(10.0)),
                  )),
              GestureDetector(
                  onTap: () {
                    print("SignIn with Google");
                    Provider.of<Authentication>(context, listen: false)
                        .signInWithGoogle() //Used to sign-in
                        .whenComplete(() {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: Homepage(),
                              type: PageTransitionType.leftToRight));
                    });
                  },
                  child: Container(
                    child: Icon(
                      FontAwesomeIcons.google,
                      color: constantColors.redColor,
                    ),
                    width: 80.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: constantColors.redColor),
                        borderRadius: BorderRadius.circular(10.0)),
                  )),
              GestureDetector( //onTap is not yet defined
                  child: Container(
                child: Icon(
                  FontAwesomeIcons.facebookF,
                  color: constantColors.blueColor,
                ),
                width: 80.0,
                height: 40.0,
                decoration: BoxDecoration(
                    border: Border.all(color: constantColors.blueColor),
                    borderRadius: BorderRadius.circular(10.0)),
              ))
            ],
          ),
        ));
  }

  Widget privacyText(BuildContext context) {
    return Positioned(
        top: 740.0,
        left: 20.0,
        right: 20.0,
        child: Container(
          child: Column(
            children: [
              Text(
                "By continuing you agree to the Terms of",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
              ),
              Text(
                "Services & Privacy Policy",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
              ),
            ],
          ),
        ));
  }

  //This is for the email login. When the form opens
  //any function inside a widget must take the BuildContext
  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet( //This is the sheet that opens from the bottom
        context: context,
        builder: (context) { //If we want to access the context of the upper widget
          //Then we have to use the builder. In this case use context in Provider
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                //This is the second child of column which is the passwordless sign in
                //This contains all the design and functionality
                Provider.of<LandingService>(context, listen: false)
                    .passwordLessSignIn(context),
                //This is the third child with the Log-in and Signin buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          //It opens a loginSheet
                          Provider.of<LandingService>(context, listen: false)
                              .logInSheet(context);
                        }),
                    MaterialButton(
                        color: constantColors.redColor,
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          //Provider.of<LandingService>(context, listen: false).signInSheet(context);

                          //Here a signIn Sheet is opened to create profile for the first time
                          Provider.of<LandingUtils>(context, listen: false)
                              .selectAvatarOptionsSheet(context);
                        })
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
          );
        });
  }
}
