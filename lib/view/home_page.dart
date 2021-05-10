import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/view/widgets/post_card.dart';
import 'package:flutter_first_mvp/helper/demo_values.dart';
import 'package:flutter_first_mvp/view/widgets/tab_item.dart';
import 'package:flutter_first_mvp/view/widgets/open_camera.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentTab = TabItem.red;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  int _currentIndex = 0;
  List <Widget> _widgetOptions = <Widget>[
    ListView.builder(
        itemCount: DemoValues.posts.length, //Here I take the length of the posts which is a class in DemoValues
        itemBuilder: (BuildContext context, int index){ //Index is the item count. This should be here to know the length of the list
          //Must give argument because this is defined in the constructor of PostCard
          return PostCard(postData: DemoValues.posts[index]); //postData is type of data that is returned and shown on the screen as part of List

        }),
    OpenCamera(),
    Text("Settings")
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Leaf"),
      ),
    body: _widgetOptions.elementAt(_currentIndex),
    /*ListView.builder(
        itemCount: DemoValues.posts.length, //Here I take the length of the posts which is a class in DemoValues
        itemBuilder: (BuildContext context, int index){ //Index is the item count. This should be here to know the length of the list
          //Must give argument because this is defined in the constructor of PostCard
          return PostCard(postData: DemoValues.posts[index]); //postData is type of data that is returned and shown on the screen as part of List

        }),*/
      bottomNavigationBar:BottomNavigationBar (
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt),
              label: "Camera"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),
              label: "Settings"),
        ],
        onTap: _onItemTapped,)



    );

 //     body: Center(
 //       child: Text("Hello World"),
 //     ),


}}
