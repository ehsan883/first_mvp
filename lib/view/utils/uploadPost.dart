//Tutorial 5
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingServices.dart';
import 'package:flutter_first_mvp/view/services/Authentication.dart';
import 'package:flutter_first_mvp/view/services/FirebaseOperations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadPost with ChangeNotifier {
  TextEditingController captionController = TextEditingController();
  ConstantColors constantColors = ConstantColors();
  File uploadPostImage;

  File get getUploadPostImage => uploadPostImage;
  String uploadPostImageUrl;

  String get getUploadPostImageUrl => uploadPostImageUrl;
  final picker = ImagePicker();
  UploadTask imagePostUploadTask;

  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final uploadPostImageVal = await picker.getImage(
        source: source); //Waiting to get img from source (Gallery or Camera)
    uploadPostImageVal == null
        ? print("Select image")
        : uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImage.path);

    uploadPostImage != null
        ? showPostImage(context)
        : print("Image upload error");
    notifyListeners();
  }

  //Here post is uploaded to firebase
  Future uploadPostImageToFirebase() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child("posts/${uploadPostImage.path}/${TimeOfDay.now()}");
    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask
        .whenComplete(() => print("Post image uploaded to storage"));
    imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        onPressed: () {
                          pickUploadPostImage(context, ImageSource.gallery);
                        }),
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text(
                          "Camera",
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        onPressed: () {
                          pickUploadPostImage(context, ImageSource.camera);
                        })
                  ],
                )
              ],
            ),
          );
        });
  }

  showPostImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.38,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.darkColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    height: 200.0,
                    width: 400.0,
                    child: Image.file(
                      uploadPostImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                            child: Text("Reselect",
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        constantColors.whiteColor)),
                            onPressed: () {
                              selectPostImageType(
                                  context); //Will again ask to select source to upload image
                            }),

                        //Here upload to cloud Firestore
                        //This is important
                        MaterialButton(
                            color: constantColors.blueColor,
                            child: Text("Confirm Image",
                                style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () {
                              uploadPostImageToFirebase().whenComplete(() {
                                editPostSheet(context);
                                print("Image uploaded");
                              });
                            }),
                      ]),
                )
              ],
            ),
          );
        });
  }

  //THis is for the caption of the image
  editPostSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
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
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.image_aspect_ratio,
                                  color: constantColors.greenColor,
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(
                                  Icons.fit_screen,
                                  color: constantColors.yellowColor,
                                ),
                                onPressed: () {})
                          ],
                        ),
                      ),
                      Container(
                        height: 200.0,
                        width: 300.0,
                        child: Image.file(
                          uploadPostImage,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: Image.asset("assets/icons/sunflower.png"),
                      ),
                      Container(
                        height: 110.0,
                        width: 5.0,
                        color: constantColors.blueColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 120.0,
                          width: 330.0,
                          child: TextField(
                            maxLines: 5,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                              //100 words/characters?
                            ],
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 100,
                            controller: captionController,
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Add a Caption...",
                              hintStyle: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //With this I will share the image
                MaterialButton(
                  child: Text(
                    "Share",
                    style: TextStyle(
                        color: constantColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  //this is the data that we need to store with the uploaded post
                  onPressed: () async {
                    Provider.of<FirebaseOperations>(context, listen: false)
                        .uploadPostData(captionController.text, {
                      "postimage": getUploadPostImageUrl,
                      "caption": captionController.text,
                      "username": Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .getInitUserName,
                      "userimage": Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .getInitUserImage,
                      "useruid":
                          Provider.of<Authentication>(context, listen: false)
                              .getUserUid,
                      "time": Timestamp.now(),
                      "useremail": Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .getInitUserEmail
                    }).whenComplete(() => Navigator.pop(context));
                  },
                  color: constantColors.whiteColor,
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }
}
