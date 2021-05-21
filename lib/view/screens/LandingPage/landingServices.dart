//Tutorial 2 Firebase Login
//Tutorial 3 as well

//Have Overflow problem here. Fix it later

//Listen false when only reading values

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/constants/Constantcolors.dart';
import 'package:flutter_first_mvp/view/screens/Homepage/Homepage.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingUtils.dart';
import 'package:flutter_first_mvp/view/services/Authentication.dart';
import 'package:flutter_first_mvp/view/services/FirebaseOperations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LandingService with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  //Tutorial 3
  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 4.0,
                  color: constantColors.whiteColor,
                ),
              ),
              CircleAvatar(
                  radius: 80.0,
                  backgroundColor: constantColors.transperant,
                  backgroundImage: FileImage(
                      //Here we are simply getting userAvatar from Utils
                      Provider.of<LandingUtils>(context, listen: false)
                          .userAvatar)),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        child: Text("Reselect",
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: constantColors.whiteColor)),
                        onPressed: () {
                          Provider.of<LandingUtils>(context, listen: false)
                              .pickUserAvatar(context, ImageSource.gallery);
                        }),
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text("Confirm Image",
                            style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () {
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .uploadUserAvatar(
                                  context) //Upload Avatar to Firebase
                              .whenComplete(() {
                            signInSheet(context);
                          });
                        })
                  ],
                ),
              )
            ]),
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(15.0)),
          );
        });
  }

//Functionality implemented in tutorial 7
  Widget passwordLessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        //This is here to stream userdata to sizedbox so that they dont have to give data again
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return new ListView(
              children:
                  snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                return ListTile(
                  trailing: Container(
                    width: 120.0,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(
                              FontAwesomeIcons.check,
                              color: constantColors.blueColor,
                            ),
                            onPressed: () {
                              Provider.of<Authentication>(context,
                                      listen: false)
                                  .logIntoAccount(
                                      documentSnapshot.get("useremail"),
                                      documentSnapshot.get("userpassword"))
                                  .whenComplete(() {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: Homepage(),
                                        type: PageTransitionType.leftToRight));
                              });
                            }),
                        IconButton(
                            icon: Icon(
                              FontAwesomeIcons.trashAlt,
                              color: constantColors.redColor,
                            ),
                            onPressed: () {
                              Provider.of<FirebaseOperations>(context,
                                      listen: false)
                                  .deleteUserData(
                                      documentSnapshot.get("useruid"));
                            }),
                      ],
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: constantColors.darkColor,
                    backgroundImage:
                        NetworkImage(documentSnapshot.get('userimage')),
                  ),
                  subtitle: Text(
                    documentSnapshot.get('useremail'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: constantColors.whiteColor,
                        fontSize: 12.0),
                  ),
                  title: Text(
                    documentSnapshot.get('username'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: constantColors.greenColor),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }

  logInSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 150.0),
                          child: Divider(
                            thickness: 4.0,
                            color: constantColors.whiteColor,
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: userEmailController,
                              decoration: InputDecoration(
                                hintText: 'Enter Email....',
                                hintStyle: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            )),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: userPasswordController,
                              decoration: InputDecoration(
                                hintText: 'Enter Password....',
                                hintStyle: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            )),
                        FloatingActionButton(
                            backgroundColor: constantColors.blueColor,
                            child: Icon(
                              FontAwesomeIcons.check,
                              color: constantColors.whiteColor,
                            ),
                            onPressed: () {
                              //Here it checks credentials
                              if (userEmailController.text.isNotEmpty) {
                                Provider.of<Authentication>(context,
                                        listen: false)
                                    .logIntoAccount(userEmailController.text,
                                        userPasswordController.text)
                                    .whenComplete(() {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: Homepage(),
                                          type:
                                              PageTransitionType.bottomToTop));
                                });
                              } else {
                                warningText(context, "Fill all the data");
                              }
                            })
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: constantColors.blueGreyColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0))),
                  )));
        });
  }

  signInSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: constantColors.blueGreyColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0))),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 150.0),
                          child: Divider(
                            thickness: 4.0,
                            color: constantColors.whiteColor,
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: FileImage(
                              Provider.of<LandingUtils>(context, listen: false)
                                  .getUserAvatar),
                          backgroundColor: constantColors.transperant,
                          radius: 60.0,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                hintText: 'Enter name....',
                                hintStyle: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            )),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: userEmailController,
                              decoration: InputDecoration(
                                hintText: 'Enter Email....',
                                hintStyle: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            )),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: userPasswordController,
                              decoration: InputDecoration(
                                hintText: 'Enter Password....',
                                hintStyle: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            )),
                        Padding(
                            //This is the tickButton to submit the details
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FloatingActionButton(
                                backgroundColor: constantColors.redColor,
                                child: Icon(
                                  FontAwesomeIcons.check,
                                  color: constantColors.whiteColor,
                                ),
                                onPressed: () {
                                  //Here Account is being created on Firebase
                                  //Here it only needs email and password
                                  if (userEmailController.text.isNotEmpty) {
                                    Provider.of<Authentication>(context,
                                            listen: false)
                                        .createAccount(userEmailController.text,
                                            userPasswordController.text)
                                        .whenComplete(() {
                                      print("Creating Collection");
                                      //Creates a user collection
                                      //With all the details
                                      Provider.of<FirebaseOperations>(context,
                                              listen: false)
                                          .createUserCollection(context, {
                                        //Here onwards is all data which is passed
                                        "userpassword":
                                            userPasswordController.text,
                                        "useruid": Provider.of<Authentication>(
                                                context,
                                                listen: false)
                                            .getUserUid,
                                        "useremail": userEmailController.text,
                                        "username": userNameController.text,
                                        "userimage": Provider.of<LandingUtils>(
                                                context,
                                                listen: false)
                                            .getUserAvatarUrl,
                                      });
                                    }).whenComplete(() {
                                      Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                              child: Homepage(),
                                              type: PageTransitionType
                                                  .bottomToTop));
                                    });
                                  } else {
                                    warningText(context, "Fill all the data");
                                  }
                                }))
                      ],
                    ),
                  )));
        });
  }

  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: constantColors.darkColor,
                borderRadius: BorderRadius.circular(15.0)),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                warning,
                style: TextStyle(
                    color: constantColors.whiteColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
  }
}
