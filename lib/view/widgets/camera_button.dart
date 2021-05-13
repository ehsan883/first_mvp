import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_mvp/view/video_view.dart';
import 'package:flutter_first_mvp/view/camera_view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//gives the list of all available cameras. back camera, front etc.
List<CameraDescription> cameras;

class CameraButton extends StatefulWidget {

  CameraController cameraController;
  Future<void> cameraValue;
  CameraButton({Key key, @required this.cameraController, @required this.cameraValue}) : super(key: key);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {

  bool isRecording = false;
  String videoPath;

  //This is also important to save resources
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    widget.cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //In case of an image
      onLongPress: () async {
        //This is the directory where it will be stored and the name of file
        final path = join(
            (await getTemporaryDirectory()).path,
            "${DateTime.now()}.mp4");
        // I start recording video
        if (!widget.cameraController.value.isRecordingVideo) {
          widget.cameraController.startVideoRecording();
          setState(() {
            isRecording =
            true; //The boolean we defined for changing the recording button
          });
        }
      },
      onLongPressUp: () async {
        if (widget.cameraController.value.isRecordingVideo) {
          XFile videoFile =
          await widget.cameraController.stopVideoRecording();
          videoPath = videoFile.path; //and there is more in this XFile object
          setState(() {
            isRecording = false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (
              builder) => VideoViewPage(path: videoPath)));
        }
      },
      onTap: () {
        //pass the context where the image is being taken
        if (!isRecording) {
          takePhoto(context);
        }
      },
      child: isRecording
          ? Icon(
        Icons.radio_button_on,
        color: Colors.red,
        size: 70,
      )
          : Icon(
        Icons.panorama_fish_eye,
        color: Colors.white,
        size: 70,
      ),
    );
  }

  //This function takes the image
  void takePhoto(BuildContext context) async {
    final path = await join(
        (await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    final image = await widget.cameraController.takePicture();

    //This is how to go to another page
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(
              path: image?.path,
            )));
  }

}
