import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

//Tells the cameras which are available
List<CameraDescription> cameras;

//Provides a default layout for the camera screen

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {


  CameraController _cameracontroller;
  Future<void> cameraValue;
  bool isRecording = false;


  void initState() {
    super.initState();
    _cameracontroller = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameracontroller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //This is the camera widget and this shows the camera preview
        //We can see the view through the camera but no option for capturing
        FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameracontroller);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              width: MediaQuery.of(context).size.width, //take the width of the context
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
                      /*InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),*/
                      GestureDetector(
                        onLongPress: () async {
                          //This is the directory where it will be stored and the name of file
                          final path = 
                              join((await getTemporaryDirectory()).path, "${DateTime.now()}.mp4");
                          // I start recording video
                          if (!_cameracontroller.value.isRecordingVideo) {
                            _cameracontroller.startVideoRecording();
                            setState(() {
                              isRecording = true; //The boolean we defined for changing the recording button
                            });
                          }
                        },
                        onLongPressUp: () async{
                          if (_cameracontroller.value.isRecordingVideo) {
                            XFile videoFile = await _cameracontroller.stopVideoRecording();
                            print(videoFile.path);//and there is more in this XFile object
                            setState(() {
                              isRecording = false;
                            });
                          }
                        },
                        child: isRecording? Icon(
                            Icons.radio_button_on,
                        color: Colors.red,
                        size: 70,)
                            : Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 70,
                        ),
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
                    child: Text("Press and hold for video",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
