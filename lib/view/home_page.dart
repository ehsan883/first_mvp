import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/view/widgets/post_card.dart';
import 'package:flutter_first_mvp/helper/demo_values.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Leaf"),
      ),
    body: ListView.builder(
        itemCount: DemoValues.posts.length, //Here I take the length of the posts which is a class in DemoValues
        itemBuilder: (BuildContext context, int index){ //Index is the item count. This should be here to know the length of the list
          //Must give argument because this is defined in the constructor of PostCard
          return PostCard(postData: DemoValues.posts[index]); //postData is type of data that is returned and shown on the screen as part of List

        }),


 //     body: Center(
 //       child: Text("Hello World"),
 //     ),
    );
  }
}
