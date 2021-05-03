import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/model/user_model.dart';
import 'package:flutter_first_mvp/view/inherited_widgets/inherited_post_model.dart';
import 'package:flutter_first_mvp/view/inherited_widgets/inherited_user_model.dart';
import 'package:flutter_first_mvp/view/post_page.dart';
import 'package:flutter_first_mvp/model/post_model.dart';


bool _isLandscape(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.landscape;

class PostCard extends StatelessWidget {
  final PostModel postData;


  //This is how it will take data from the constructor
  const PostCard({Key key, @required this.postData}): super (key: key);

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = _isLandscape(context) ? 6/2 :  6/3;

    //When tap on the post then it goes to the next screen
    return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return PostPage(postData: postData);
          }
      ));
    },
      //This is apart from tap. When there is no tapping on it
    child: AspectRatio(
      aspectRatio: aspectRatio,
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          margin: const EdgeInsets.all(4.0),
          child: InheritedPostModel( //Added inheritedModel here(in Top most widget) and then can call it in the lower widgets
            postData: postData,

            child: Column(
            children: <Widget>[
                _Post(),
                Divider(color: Colors.grey,),
                _PostDetails()],
        ),
      ),
      ),
    ),
    ),
    );
  }
}

class _Post extends StatelessWidget {
  const _Post({Key key}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Row(
          children: [_PostImage(), _PostTitleSummaryAndTime()],
        ),
    );
  }
}

class _PostTitleSummaryAndTime extends StatelessWidget {

  const _PostTitleSummaryAndTime({Key key}): super (key: key);

  @override
  Widget build(BuildContext context) {

    final PostModel postData = InheritedPostModel.of(context).postData;
    final TextStyle titleTheme = Theme.of(context).textTheme.headline6;
    final TextStyle summaryTheme = Theme.of(context).textTheme.bodyText2;
    final String title = postData.title;
    final String summary = postData.summary;
    final int flex = _isLandscape(context) ? 5 : 3;
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: titleTheme),
                  SizedBox(height: 2.0),
                  Text(summary, style: summaryTheme),
                ],
              ),
              PostTimeStamp(),]
        ),
      ),
    );
  }
}


class _PostImage extends StatelessWidget {

  const _PostImage({Key key}): super (key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    return Expanded(
        flex: 2,
        child: Image.asset(postData.imageURL)
    );
  }
}

class UserDetails extends StatelessWidget {

  final UserModel userData;
  const UserDetails({Key key, @required this.userData}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return InheritedUserModel(userData: userData,
      child: Container(
        child: Row(children: [_UserImage(),
        _UserNameAndEmail()],
    ),
    )
    );
  }
}

class _UserNameAndEmail extends StatelessWidget {
  const _UserNameAndEmail({Key key}): super (key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    return Expanded(
      flex: 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Text(postData.author.name),
          Text(postData.author.email),
        ],
      ),

    );
  }
}

class PostTimeStamp extends StatelessWidget {
  final Alignment alignment;

  const PostTimeStamp({Key key, this.alignment = Alignment.centerLeft}): super (key: key);

  @override
  //final TextStyle timeTheme = TextThemes.dateStyle;
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    //final TextStyle timeTheme = TextThemes.dateStyle;
    return Container(
      width: double.infinity,
      alignment: alignment,
      child: Text(postData.postTimeFormatted), //, style: timeTheme),
    );
  }
}

class _UserImage extends StatelessWidget {

  const _UserImage({Key key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel
        .of(context)
        .postData;
    return Expanded(
        flex: 1,
        child: CircleAvatar(
          backgroundImage: AssetImage(postData.author.image),
        )
    );
  }
}
class PostStats extends StatelessWidget {
  const PostStats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;

    return Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _ShowStat(
            icon: Icons.favorite,
            number: postData.reacts,
            color: Colors.red,
          ),
          _ShowStat(
            icon: Icons.remove_red_eye,
            number: postData.views,
            color: Colors.green[900],
          ),
        ],

    );
  }
}

class _ShowStat extends StatelessWidget {
  final IconData icon;
  final int number;
  final Color color;
  const _ShowStat({
    Key key,
    @required this.icon,
    @required this.number,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: Icon(icon, color: color),
        ),
        Text(number.toString()),
      ],
    );
  }
}


class _PostDetails extends StatelessWidget {
  const _PostDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;

    return Row(
      children: <Widget>[
        Expanded(flex: 3, child: UserDetails(userData: postData.author)),
        Expanded(flex: 1, child: PostStats()),
      ],
    );
  }
}