import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/model/user_model.dart';
import 'package:flutter_first_mvp/view/widgets/post_card.dart';

class UserDetailsWithFollowKeys {
  static final ValueKey userDetails = ValueKey("UserDetails");
  static final ValueKey follow = ValueKey("Follow");
}

class UserDetailsWithFollow extends StatelessWidget {

  final UserModel userData;
  const UserDetailsWithFollow({Key key, @required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(flex: 2
            ,child: UserDetails(
              userData: userData,
              key: UserDetailsWithFollowKeys.userDetails,
            ),
        ),
        Expanded(flex: 1,
            child: Container(
              key: UserDetailsWithFollowKeys.follow,
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.group_add), onPressed: () {},
              ),
            ))
      ],
    );
  }
}
