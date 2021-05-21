import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/services/Authentication.dart';
import 'package:flutter_first_mvp/view/services/FirebaseOperations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PostFunctions with ChangeNotifier {
  //we already have a collection of posts
  //we will create a subcollection containing the number of likes

  //PostId is CaptionId
  ConstantColors constantColors = ConstantColors();
  TextEditingController commentController = TextEditingController();

  Future addLike(BuildContext context, String postId, String subDocId) async {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(subDocId)
        .set({
      "likes": FieldValue.increment(1),
      "username": Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserName,
      "useruid": Provider.of<Authentication>(context, listen: false).getUserUid,
      "userimage": Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserImage,
      "useremail": Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserEmail,
      "time": Timestamp.now()
    });
  }

  Future addComment(BuildContext context, String postId, String comment) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(comment)
        .set({
      "comment": comment,
      "username": Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserName,
      "useruid": Provider.of<Authentication>(context, listen: false).getUserUid,
      "userimage": Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserImage,
      "useremail": Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserEmail,
      "time": Timestamp.now()
    });
  }

  showCommentsSheet(
      BuildContext context, DocumentSnapshot snapshot, String docId) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                Container(
                  width: 100.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.whiteColor),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text(
                      "Comments...",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: constantColors.blueColor,
                          fontSize: 14.0),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("posts")
                        .doc(docId)
                        .collection("comments")
                        .orderBy("time")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return new ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot documentSnapshot) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: GestureDetector(
                                          child: CircleAvatar(
                                            backgroundColor:
                                                constantColors.darkColor,
                                            radius: 15.0,
                                            backgroundImage: NetworkImage(
                                                documentSnapshot
                                                    .get("userimage")),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                            child: Text(
                                          documentSnapshot.get("username"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: constantColors.whiteColor,
                                              fontSize: 18.0),
                                        )),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.arrowUp,
                                                  color:
                                                      constantColors.blueColor,
                                                  size: 12.0,
                                                ),
                                                onPressed: () {}),
                                            Text(
                                              "0",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      constantColors.whiteColor,
                                                  fontSize: 14.0),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.reply,
                                                  color: constantColors
                                                      .yellowColor,
                                                  size: 12.0,
                                                ),
                                                onPressed: () {}),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: constantColors.blueColor,
                                              size: 12.0,
                                            ),
                                            onPressed: () {}),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: Text(
                                            documentSnapshot.get("comment"),
                                            style: TextStyle(
                                                color:
                                                    constantColors.whiteColor,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.trashAlt,
                                              color: constantColors.redColor,
                                              size: 16.0,
                                            ),
                                            onPressed: () {}),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: constantColors.darkColor
                                        .withOpacity(0.2),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  //I had not given the height here earlier so had an error

                  width: 400.0,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 300.0,
                        height: 20.0,
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                              hintText: "Add Comment...",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: constantColors.whiteColor,
                                  fontSize: 16.0)),
                          controller: commentController,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: constantColors.whiteColor,
                              fontSize: 16.0),
                        ),
                      ),
                      FloatingActionButton(
                          backgroundColor: constantColors.greenColor,
                          child: Icon(
                            FontAwesomeIcons.comment,
                            color: constantColors.whiteColor,
                          ),
                          onPressed: () {
                            print("Adding Comment...");
                            addComment(context, snapshot.get("caption"),
                                    commentController.text)
                                .whenComplete(() {
                              commentController.clear();
                              notifyListeners();
                            });
                          })
                    ],
                  ),
                )
              ]),
              decoration: BoxDecoration(
                  color: constantColors.blueGreyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
            ),
          );
        });
  }

  showLikes(BuildContext context, String postId) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 4.0,
                  color: constantColors.whiteColor,
                ),
              ),
              Container(
                width: 100.0,
                decoration: BoxDecoration(
                    border: Border.all(color: constantColors.whiteColor),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Center(
                  child: Text(
                    "Likes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: constantColors.blueColor,
                        fontSize: 14.0),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: 400.0,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("posts")
                      .doc(postId)
                      .collection("likes")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return new ListView(
                        children: snapshot.data.docs
                            .map((DocumentSnapshot documentSnapshot) {
                          return ListTile(
                            leading: GestureDetector(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    documentSnapshot.get("userimage")),
                              ),
                            ),
                            title: Text(
                              documentSnapshot.get("username"),
                              style: TextStyle(
                                  color: constantColors.blueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            subtitle: Text(
                              documentSnapshot.get("useremail"),
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                            //Shows follow button only for other people
                            trailing: Provider.of<Authentication>(context,
                                            listen: false)
                                        .getUserUid ==
                                    documentSnapshot.get("useruid")
                                ? Container(
                                    width: 0.0,
                                    height: 0.0,
                                  )
                                : MaterialButton(
                                    child: Text(
                                      "Follow",
                                      style: TextStyle(
                                          color: constantColors.whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                    onPressed: () {},
                                    color: constantColors.blueColor,
                                  ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              )
            ]),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
          );
        });
  }

  showRewards(BuildContext context, String postId) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                Container(
                  width: 100.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.whiteColor),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text(
                      "Rewards",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: constantColors.blueColor,
                          fontSize: 14.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("awards")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data.docs
                                .map((DocumentSnapshot documentSnapshot) {
                              return GestureDetector(
                                onTap: () async {
                                  print("Rewarding user....");
                                  print(documentSnapshot.get("image"));
                                  await Provider.of<FirebaseOperations>(context,
                                          listen: false)
                                      .addAward(postId, {
                                    "username": Provider.of<FirebaseOperations>(
                                            context,
                                            listen: false)
                                        .getInitUserName,
                                    "userimage":
                                        Provider.of<FirebaseOperations>(context,
                                                listen: false)
                                            .getInitUserImage,
                                    "useruid": Provider.of<Authentication>(
                                            context,
                                            listen: false)
                                        .getUserUid,
                                    "time": Timestamp.now(),
                                    "award": documentSnapshot.get("image")
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    //With this name the rewards are saved on Firestore
                                    child: Image.network(
                                        documentSnapshot.get("image")),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                )),
          );
        });
  }
}
