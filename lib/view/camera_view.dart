import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CameraViewPage extends StatelessWidget {
  final String path;

  const CameraViewPage({Key key, this.path}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(icon: Icon(Icons.crop_rotate), iconSize: 27, onPressed: (){},),
          IconButton(icon: Icon(Icons.emoji_emotions_outlined), iconSize: 27, onPressed: (){},),
          IconButton(icon: Icon(Icons.title), iconSize: 27, onPressed: (){},),
          IconButton(icon: Icon(Icons.edit), iconSize: 27, onPressed: (){},),
        ]
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-150,
              child: Image.file(File(path),
              fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
            color: Colors.black38,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: TextFormField(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
              ),
              maxLines: 6,
              minLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Add Caption...",
                prefixIcon: Icon(Icons.add_photo_alternate, color: Colors.white,
                size: 27,),
                  hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),
                  suffixIcon: CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.tealAccent[700],
                    child: Icon(Icons.check, color: Colors.white,size: 27,),
                  )
              ),
            )
            )
            )
          ],
        ),
      ),
    );
  }
}
