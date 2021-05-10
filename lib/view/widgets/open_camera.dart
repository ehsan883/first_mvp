import 'package:camera/camera.dart';
import 'package:flutter_first_mvp/view/camera_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

//This will always return the camera screen.
//Can be accessed from multiple areas or multiple buttons

class OpenCamera extends StatelessWidget {
  const OpenCamera({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CameraScreen();
  }
}
