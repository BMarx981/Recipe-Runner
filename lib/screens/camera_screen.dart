import 'package:camera/camera.dart' as cam;
import 'package:camera/new/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  cam.CameraController controller;
  List cameras;
  int selectedCameraIndex;
  String imagePath;

  @override
  void initState() {
    super.initState();
    cam.availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });

        _initCameraController(cameras[selectedCameraIndex]).then((void v) {});
      } else {
        print('No camera available');
      }
    }).catchError((err) {
      print('Errors: ${err.code} \n Error Message: ${err.message}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Screen'),
      ),
      body: Container(
        child: Text('Camera button'),
      ),
    );
  }

  Future _initCameraController(camera) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller =
        cam.CameraController(cameraDescription, cam.ResolutionPreset.high);

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hashError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on cam.CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) setState(() {});
  }

  void _showCameraException(cam.CameraException e) {}
}
