import 'package:camera/camera.dart';
import 'package:flutter_first_mvp/view/widgets/camera_button.dart';
import 'package:flutter/material.dart';

//Provides a default layout for the camera screen
class CameraScreen extends StatefulWidget {
  const CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController cameracontroller; //Need to have this as well
  Future<void> cameraValue;

  //This is how you have to initialize the camera before using it
  @override
  void initState() {
    super.initState();
    cameracontroller = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = cameracontroller.initialize();

  }

  //Here I start what is shown on the screen
  @override
  Widget build(BuildContext context) {
    return Stack(
      //Use a stack where we have to put stuff on top of a screen. In this case the caption
      children: [
        //This is the camera widget and this shows the camera preview
        //We can see the view through the camera but no option for capturing
        FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(
                    cameracontroller); //Will show preview if connection established
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Positioned(
            //With this I can control where I want to place something. Can be anything e.g Text, pic
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              width: MediaQuery.of(context)
                  .size
                  .width, //take the width of the context
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(Icons.flash_off),
                          color: Colors.white,
                          iconSize: 24,
                          onPressed: () {}),
                      CameraButton( //What the camera button does and how it looks
                        cameraController: cameracontroller,
                        cameraValue: cameraValue,
                      ),
                      IconButton(
                        icon: Icon(Icons.flip_camera_ios),
                        color: Colors.white,
                        iconSize: 24,
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      "Press and hold for video",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
