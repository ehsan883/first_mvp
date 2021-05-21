//Tutorial 2 Firebase Login


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication with ChangeNotifier{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String userUid;
  String get getUserUid => userUid;


  //This compares the email and password and then logs in
  Future logIntoAccount(String email, String password) async {

    UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    User user = userCredential.user;
    userUid = user.uid;
    print(userUid);
    notifyListeners();
  }

  //This is how to create an account in Firebase with Email and Password
  Future createAccount(String email, String password) async {

    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    User user = userCredential.user;
    userUid = user.uid;
    print(userUid);
    notifyListeners();
  }

  Future logOutViaEmail(){
    return firebaseAuth.signOut();
  }

  //Steps taken from official documentation
  Future signInWithGoogle() async{
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );
    //Here it signs in
    final UserCredential userCredential = await firebaseAuth.signInWithCredential(authCredential);
    final User user = userCredential.user;
    assert(user.uid != null);

    userUid = user.uid;
    print("Google User Uid => $userUid");
    notifyListeners();
  }

  Future signOutWithGoogle() async {
    return googleSignIn.signOut();
  }

}