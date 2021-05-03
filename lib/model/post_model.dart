import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_first_mvp/model/comment_model.dart';

class PostModel{
  final String id;
  final String title;
  final String summary;
  final String body;
  final String imageURL;
  final DateTime postTime;
  final int reacts;
  final int views;
  final UserModel author;
  final List<CommentModel> comments;


  const PostModel({
    @required this.id,
    @required this.title,
    @required this.summary,
    @required this.body,
    @required this.imageURL,
    @required this.author,
    @required this.postTime,
    @required this.reacts,
    @required this.views,
    @required this.comments,
  });

  // This done using the intl.dart package
  String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(postTime);
}