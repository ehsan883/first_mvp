//Tutorial 4

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/screens/Chatroom/chatroom.dart';
import 'package:flutter_first_mvp/view/screens/Feed/feed.dart';
import 'package:flutter_first_mvp/view/screens/Homepage/homepageHelpers.dart';
import 'package:flutter_first_mvp/view/screens/Profile/profile.dart';
import 'package:flutter_first_mvp/view/services/FirebaseOperations.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  void initState(){
    Provider.of<FirebaseOperations>(context, listen: false).initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: PageView(
        controller: homepageController,
        children: [ //This is to have 3 different views for feed, messaging and profile
          Feed(),
          Chatroom(),
          Profile()
        ],
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page){
          setState(() {
            pageIndex = page;
          });
        },
      ),
      bottomNavigationBar: Provider.of<HomepageHelpers>(context, listen: false)
      .bottomNavBar(context, pageIndex, homepageController),
    );
  }
}
