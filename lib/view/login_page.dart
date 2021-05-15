import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; //base of all authentication
import 'package:flutter_first_mvp/view/home_page.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart'; // used for Email link authentication

//You have to initialize it like this


final FirebaseAuth _auth = FirebaseAuth.instance;

class LogInPage extends StatefulWidget {
  final String title;

  const LogInPage({Key key, this.title}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //Line 20-47 is only appbar stuff
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
//5
            return TextButton(
              //style: TextButton.styleFrom(backgroundColor: Colors.black),
              child: const Text(
                "Sign out", style: TextStyle(color: Colors.white),
              ),
              //This is in the app bar and will logout a person if he is signed in
              onPressed: () async { //When pressed it does this
                final User user = _auth.currentUser; //getting the current user
                if (user == null) {
//6
                //Snackbar is this banner that pops up at the bottom e.g for undo
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                //else it will wait until the user is signed out
                await _auth.signOut();
                final String uid = user.uid; // gets the user id
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out.'),
                ));
              },
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
//7
        return ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),

          children: <Widget>[
            _RegisterEmailSection(),
            _EmailPasswordForm()
          ],
            );
      }),
      );
  }
}
// This is the code to register a new user with email and pwd
class _RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration'; //We declare the variables here
  @override
  State<StatefulWidget> createState() =>
      _RegisterEmailSectionState();
}
class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); //will be used to validate entered data
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    return  Form( //Is where you can enter text
        key: _formKey,
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            TextFormField( //for Email
              controller: _emailController, //tracks changes in this field and saves them
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText:
              'Password'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async { //This is what happens when you press the button
                  if (_formKey.currentState.validate()) {
                    _register(); //here we will retrieve the information from the form that you just created and send it to Firebase through a call to FlutterFire Authentication’s method
                  }
                },
                child: const Text('Submit'), //text on the button
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(_success == null
                  ? ''
                  : (_success
                  ? 'Successfully registered ' + _userEmail
                  : 'Registration failed')),
            )
          ],
        )
    );
  }
  void _register() async {
    final User user = (await
    _auth.createUserWithEmailAndPassword( //this is a flutterfire authentication method
      email: _emailController.text,
      password: _passwordController.text,
    )
    ).user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }
//These methods happen when we close the app or it runs in background
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}


// Here is the login part. This is after the user is already registered

class _EmailPasswordForm extends StatefulWidget {
  const _EmailPasswordForm({Key key}) : super(key: key);

  @override
  __EmailPasswordFormState createState() => __EmailPasswordFormState();
}

//The whole class is the same. This is for creating the UI
//I can separate this into a separate class
//Only difference here is that submit calls a separate function
// _signInWithEmailAndPassword()
//Later you also have to add this to your widget list in line 64

class __EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: const Text('Test sign in with email and password'),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: ()  async {
                if (_formKey.currentState.validate()) {
                    _signInWithEmailAndPassword();
                }
              },
              child: const Text('Submit'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  :(_success == true
                  ?Navigator.push(context, MaterialPageRoute(builder: (
                  builder) => HomePage()))//'Successfully signed in ' + _userEmail
                  :"Sign in failed"),
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //This is where the authentication takes place
  // You need to add a try catch because if you dont then in case of wrong password
  //and many other reasons it will throw an exception (add other reasons as well)
   _signInWithEmailAndPassword() async { try{
    final User user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )).user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }}
    catch (e){
      setState(() {
        _success = false;
      });
    }
  }

}


