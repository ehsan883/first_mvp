import 'package:flutter/material.dart';
import "package:flutter_first_mvp/model/user_model.dart";

class InheritedUserModel extends InheritedWidget{
  final UserModel userData;
  final Widget child;

  //Constructor
  InheritedUserModel({Key key, @required this.userData, this.child}) : super(key: key, child: child);

  static InheritedUserModel of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedUserModel>());
  }

  @override
  bool updateShouldNotify(covariant InheritedUserModel oldWidget) {
    return true;
  }

}