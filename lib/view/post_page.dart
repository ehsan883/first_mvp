import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/model/post_model.dart';
import 'package:flutter_first_mvp/model/user_model.dart';
import 'package:flutter_first_mvp/view/inherited_widgets/inherited_post_model.dart';
import 'package:flutter_first_mvp/view/widgets/user_details_with_follow.dart';
import 'package:flutter_first_mvp/view/widgets/post_card.dart';
import 'package:flutter_first_mvp/view/widgets/comments_list.dart';


class PostPageKeys {
  static final ValueKey wholePage = ValueKey("wholePage");
  static final ValueKey bannerImage = ValueKey("bannerImage");
  static final ValueKey summary = ValueKey("summary");
  static final ValueKey mainBody = ValueKey("mainBody");
}

class PostPage extends StatelessWidget {

  final PostModel postData;
  //final UserModel userData;

  const PostPage({Key key, @required this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(postData.title)),
      body: InheritedPostModel( //Also add here to the top so that lower widgets can access
        postData: postData,
        child: ListView(
          key: PostPageKeys.wholePage,
          children: <Widget>[
            _BannerImage(key: PostPageKeys.bannerImage),
            _NonImageContents(),
          ],
        ),
      ),
    );
  }
}

class _NonImageContents extends StatelessWidget {

  const _NonImageContents({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData; //Need to understand this

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Summary(key: PostPageKeys.summary),
          PostTimeStamp(),
          _MainBody(key: PostPageKeys.mainBody),
          UserDetailsWithFollow(
            userData: postData.author
          ),
          SizedBox(height: 8.0,),
          PostStats(),
          CommentsList()
        ],
      ),

    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        InheritedPostModel.of(context).postData.summary,
        //style: TextThemes.title,
      ),
    );
  }
}

class _MainBody extends StatelessWidget {
  const _MainBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        InheritedPostModel.of(context).postData.body,
        //style: TextThemes.body1,
      ),
    );
  }
}


class _BannerImage extends StatelessWidget {

  const _BannerImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        InheritedPostModel.of(context).postData.imageURL, fit: BoxFit.fitWidth,
      ),
    );
  }
}

