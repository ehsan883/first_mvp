//Tutorial 4: Only creation
//Tutorial 5: filling in logic


import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/screens/Feed/feedHelpers.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {

  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.blueGreyColor,
      drawer: Drawer(),
      appBar: Provider.of<FeedHelpers>(context, listen: false).appBar(context),
      //This is what fetches the feed and displays it
      body: Provider.of<FeedHelpers>(context, listen: false).feedBody(context),
    );
  }
}
