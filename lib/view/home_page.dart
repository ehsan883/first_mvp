//Use the way given here to create a bottom navigation bar

import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/view/widgets/posts_list_view_home.dart';
import 'package:flutter_first_mvp/view/widgets/open_camera.dart';

//Is stateful because state changes with bottom navigation bar
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; //This is for the bottom navigation

  //This is what happens when you select any of the options from the bottom navigation.
  //Arranged according to index
  //This is what is hidden behind those icons
  List<Widget> _widgetOptions = <Widget>[
    PostsListHome(),
    OpenCamera(),
    Text("Settings")
  ];

  //This is how setState() functions are created
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  //Here I start to build the main homepage()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Leaf"),
        ),
        // Show in body whatever is at _currentIndex
        body: _widgetOptions.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          //Here the layout of the bottomnavigationbar is given
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt), label: "Camera"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
          onTap:
              _onItemTapped, //Whenever it is tapped this function is called to change the index
        )
    );
    //     body: Center(
    //       child: Text("Hello World"),
  }
}
