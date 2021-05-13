import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewPage extends StatefulWidget {
  final String path;
  const VideoViewPage({Key key, this.path}) : super(key: key);

  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  VideoPlayerController _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {

    _controller = VideoPlayerController.file(File(widget.path)) //This is how you get the path which was passed as an argument in a stateful widget
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        //
        _controller.play();
        _controller.setLooping(true); //these two lines are to loop the video after it has been recorded
        super.initState();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, actions: [
        IconButton(
          icon: Icon(Icons.crop_rotate),
          iconSize: 27,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.emoji_emotions_outlined),
          iconSize: 27,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.title),
          iconSize: 27,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.edit),
          iconSize: 27,
          onPressed: () {},
        ),
      ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child:  _controller.value.isInitialized //check if it is initialized. If not initialized then shows empty container
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : Container(),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black38,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 17),
                      maxLines: 6,
                      minLines: 1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add Caption...",
                          prefixIcon: Icon(
                            Icons.add_photo_alternate,
                            color: Colors.white,
                            size: 27,
                          ),
                          hintStyle:
                          TextStyle(color: Colors.white, fontSize: 17),
                          suffixIcon: CircleAvatar(
                            radius: 27,
                            backgroundColor: Colors.tealAccent[700],
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 27,
                            ),
                          )),
                    ))
            ),
            /*Align(
              alignment: Alignment.center,
            child: InkWell(
              onTap: (){
                setState(() {
                  _controller.value.isPlaying?_controller.pause():_controller.play();
                });
              },
              child: CircleAvatar(
                radius: 33,
              backgroundColor: Colors.black38,
              child: Icon(_controller.value.isPlaying?Icons.pause:Icons.play_arrow,
              color: Colors.white, size: 50,),
            )))*/

          ],
        ),
      ),
    );
  }
}


