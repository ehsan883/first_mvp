//Tutorial 3
//Here we want to upload user Image along with his credentials on firebase Storage
//Shows how to upload user avatar under a firebase storage


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/view/screens/LandingPage/landingUtils.dart';
import 'package:provider/provider.dart';

import 'Authentication.dart';

class FirebaseOperations with ChangeNotifier{

  Future uploadUserAvatar(BuildContext context) async{

    UploadTask imageUploadTask; //TO upload an image

    //This is to get the image for the Avatar
    Reference imageReference = FirebaseStorage.instance.ref().child(
      "userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false)
      .getUserAvatar.path}/${TimeOfDay.now()}");
    //here in brackets have given the file
    imageUploadTask = imageReference.putFile(Provider.of<LandingUtils>(context, listen: false)
        .getUserAvatar);
    await imageUploadTask.whenComplete(() {
      print("Image uploaded");
    });
    imageReference.getDownloadURL().then((url){
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl = url.toString();
      print("The user profile avatar url => ${Provider.of<LandingUtils>(context, listen: false)
          .getUserAvatarUrl}");
      notifyListeners();
    });

  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance.collection("users")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

}