import 'package:flutter/material.dart';
import "package:flutter_first_mvp/model/post_model.dart";

class InheritedPostModel extends InheritedWidget{
  final PostModel postData;
  final Widget child;

  //Constructor
  InheritedPostModel({Key key, @required this.postData, this.child}) : super(key: key, child: child);

  static InheritedPostModel of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedPostModel>());
  }

  @override
  bool updateShouldNotify(covariant InheritedPostModel oldWidget) {
    return true;
  }

}