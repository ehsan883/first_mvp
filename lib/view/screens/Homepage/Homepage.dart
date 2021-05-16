import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';

class Homepage extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.redColor
    );
  }
}
