//Tutorial 4
//For displaying the user profile

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingPage.dart';
import 'package:flutter_first_mvp/view/screens/Profile/profileHelpers.dart';
import 'package:flutter_first_mvp/view/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              EvaIcons.settings2Outline,
              color: constantColors.lightBlueColor,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
                icon: Icon(
                  EvaIcons.logOutOutline,
                  color: constantColors.greenColor,
                ),
                onPressed: () {
                  Provider.of<ProfileHelpers>(context, listen: false)
                      .logOutDialog(context);
                })
          ],
          title: RichText(
            text: TextSpan(
                text: "My",
                style: TextStyle(
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Profile",
                    style: TextStyle(
                      color: constantColors.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  )
                ]),
          ),
        ),
        body: SingleChildScrollView( //Because of this I can scroll the body
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(Provider.of<Authentication>(context, listen: false)
                        .getUserUid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return new Column(
                      children: [
                        Provider.of<ProfileHelpers>(context, listen: false)
                            .headerProfile(context, snapshot),
                        Provider.of<ProfileHelpers>(context, listen: false)
                            .divider(),
                        Provider.of<ProfileHelpers>(context, listen: false)
                            .middleProfile(context, snapshot),
                        Provider.of<ProfileHelpers>(context, listen: false)
                            .footerProfile(context, snapshot)
                      ],
                    );
                  }
                },
              ),
              decoration: BoxDecoration(
                  color: constantColors.blueGreyColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
        ));
  }
}
