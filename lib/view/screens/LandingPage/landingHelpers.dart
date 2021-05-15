import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  Widget mainButtons(BuildContext context){
    return Positioned(
        top: 630,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
              child:Container(
                child: Icon(EvaIcons.emailOutline, color: constantColors.yellowColor,),
                width: 80.0,
                  height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(color: constantColors.yellowColor),
                  borderRadius: BorderRadius.circular(10.0)
                ),
              )
              ),
              GestureDetector(
                  child:Container(
                    child: Icon(FontAwesomeIcons.google, color: constantColors.redColor,),
                    width: 80.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: constantColors.redColor),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  )
              ),
              GestureDetector(
                  child:Container(
                    child: Icon(FontAwesomeIcons.facebookF, color: constantColors.blueColor,),
                    width: 80.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: constantColors.blueColor),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  )
              )],
          ),
        ));
  }
  Widget privacyText(BuildContext context){
    return Positioned(
        top: 740.0,
        left: 20.0,
        right: 20.0,
        child: Container(
          child: Column(
            children: [
              Text("By continuing you agree to the Terms of",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),),
              Text("Services & Privacy Policy",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),),
            ],
          ),
        ));
  }

}
