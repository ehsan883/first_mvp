import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingHelpers.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {


  final ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.whiteColor,
      body: Stack(
        children: [bodyColor(),
          //He just made the widget separately and called it here
          Provider.of<LandingHelpers>(context, listen: false).bodyImage(context),
          Provider.of<LandingHelpers>(context, listen: false).taglineText(context),
          Provider.of<LandingHelpers>(context, listen: false).mainButtons(context),
          Provider.of<LandingHelpers>(context, listen: false).privacyText(context),

        ],
      ),
    );
  }
  bodyColor(){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.5, 0.9
          ],
            colors: [
              constantColors.darkColor,
            constantColors.blueGreyColor
            ]
        )
      ),
    );
  }
}
