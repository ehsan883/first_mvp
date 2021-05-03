import 'package:flutter_first_mvp/model/post_model.dart';
import 'package:flutter_first_mvp/model/user_model.dart';
import 'package:flutter_first_mvp/model/comment_model.dart';

class DemoValues {

  //here I have created a list of users
  static final List<UserModel> users = [
  UserModel(
  id: "1",
  name: "Ishfar",
  email: "ishfar@gmail.com",
    image: "assets/images/user.jpg",
  followers: 123,
  joined: DateTime(2019, 4, 30),
  posts: 12,

  ),
  UserModel(
  id: "2",
  name: "Ishrak",
  email: "ishrak@gmail.com",
    image: "assets/images/user.jpg",
  followers: 456,
  joined: DateTime(2018, 5, 30),
  posts: 13,
  ),
  UserModel(
  id: "3",
  name: "Shakleen",
  email: "shakleen@gmail.com",
    image: "assets/images/user.jpg",
  followers: 789,
  joined: DateTime(2017, 6, 30),
  posts: 14,
  ),
  ];

  static final String _body =
  """Test Body """;


  static final List<CommentModel> _comments = <CommentModel>[
    CommentModel(
      comment:
      "Et hic et sequi inventore. Molestiae laboriosam commodi exercitationem eum. ",
      user: users[0],
      time: DateTime(2019, 4, 30),
    ),
    CommentModel(
      comment: "Unde id provident ut sunt in consequuntur qui sed. ",
      user: users[1],
      time: DateTime(2018, 5, 30),
    ),
    CommentModel(
      comment: "Eveniet nesciunt distinctio sint ut. ",
      user: users[0],
      time: DateTime(2017, 6, 30),
    ),
    CommentModel(
      comment: "Et facere a eos accusantium culpa quaerat in fugiat suscipit. ",
      user: users[2],
      time: DateTime(2019, 4, 30),
    ),
    CommentModel(
      comment: "Necessitatibus pariatur harum deserunt cum illum ut.",
      user: users[1],
      time: DateTime(2018, 5, 30),
    ),
    CommentModel(
      comment:
      "Accusantium neque quis provident voluptatem labore quod dignissimos eum quaerat. ",
      user: users[2],
      time: DateTime(2017, 6, 30),
    ),
    CommentModel(
      comment:
      "Accusantium neque quis provident voluptatem labore quod dignissimos eum quaerat. ",
      user: users[1],
      time: DateTime(2019, 4, 30),
    ),
    CommentModel(
      comment: "Neque est ut rerum vel sunt harum voluptatibus et. ",
      user: users[0],
      time: DateTime(2018, 5, 30),
    ),
    CommentModel(
      comment:
      "Hic accusantium minus fuga exercitationem id aut expedita doloribus. ",
      user: users[1],
      time: DateTime(2017, 6, 30),
    ),
  ];



  //List of demo posts. In each I have created an instance of PostModel
  static final List<PostModel> posts = [
  PostModel(
  id: "1",
  author: users[0],
  title: "Maple Trees",
  summary: "An in-depth study on maple trees.",
  body: "The study is a lie. I just really really like maple trees.",
  imageURL: "assets/images/post.jpeg",
  postTime: DateTime(2019, 6, 29),
  reacts: 123,
  views: 456,
    comments: _comments
  ),
  PostModel(
  id: "2",
  author: users[1],
  title: "Oak Trees",
  summary: "Preaching about oak trees",
  body: "Oak trees are the best. All other trees are sub-par.",
  imageURL: "assets/images/post.jpeg",
  postTime: DateTime(2019, 4, 13),
  reacts: 321,
  views: 654,
      comments: _comments
  ),
  PostModel(
  id: "3",
  author: users[2],
  title: "Mango Trees",
  summary: "Gives shadow and fruit. Absolute win, no?",
  body: "I just love mangos. What's better than mangos? The tree that gives mangos.",
  imageURL: "assets/images/post.jpeg",
  postTime: DateTime(2019, 1, 12),
  reacts: 213,
  views: 546,
      comments: _comments
  ),
  ];
  }





  //static final String userImage = "assets/images/user.jpg";
  //static final String postImage = "assets/images/post.jpeg";
  //static final String userName = "Usama Ehsan";
  //static final String userEmail = "usama@gmail.com";
  //static final String postTime = "30 April, 2019";
  //static final String postTitle = "Billion Euros";
//static final String postSummary = "My name is Usama the Billionaire";





//Obviously I do not want to change the userName anywhere else in the code so that is why it is final
//Static because do not want to create instances of class elsewhere and access values directly from here