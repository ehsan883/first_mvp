import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/model/user_model.dart';

class CommentModel{
  final String comment;
  final UserModel user;
  final DateTime time;

  const CommentModel({
    @required this.user,
    @required this.comment,
    @required this.time
    });
}