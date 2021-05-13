import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/view/widgets/post_card.dart';
import 'package:flutter_first_mvp/helper/demo_values.dart';

class PostsListHome extends StatelessWidget {
  const PostsListHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder( //This creates a list which is scrollable. Column is non-scrollable
        itemCount: DemoValues.posts.length,
        //Here I take the length of the posts which is a class in DemoValues
        itemBuilder: (BuildContext context, int index) { //This is to create widgets in a Listview
          //Index is the item count. This should be here to know the length of the list
          //Must give argument because this is defined in the constructor of PostCard
          return PostCard(
              postData: DemoValues.posts[
              index]); //postData is type of data that is returned and shown on the screen as part of List
        });
  }
}
