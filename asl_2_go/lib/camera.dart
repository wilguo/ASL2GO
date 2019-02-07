import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(CameraApp());
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: CameraPreview(controller));
  }
}


//import 'dart:async';
//import 'dart:io';
//import 'package:path_provider/path_provider.dart';
//import 'package:camera/camera.dart';
//import 'package:flutter/material.dart';
//
//class CameraExampleHome extends StatefulWidget {
//  @override
//  _CameraExampleHomeState createState() {
//    return _CameraExampleHomeState();
//  }
//}
//
///// Returns a suitable camera icon for [direction].
//IconData getCameraLensIcon(CameraLensDirection direction) {
//  switch (direction) {
//    case CameraLensDirection.back:
//      return Icons.camera_rear;
//    case CameraLensDirection.front:
//      return Icons.camera_front;
//    case CameraLensDirection.external:
//      return Icons.camera;
//  }
//  throw ArgumentError('Unknown lens direction');
//}
//
//void logError(String code, String message) =>
//    print('Error: $code\nError Message: $message');
//
//class _CameraExampleHomeState extends State<CameraExampleHome> {
//  CameraController controller;
//  String imagePath;
//  String videoPath;
//  VoidCallback videoPlayerListener;
//  List<CameraDescription> cameras;
//
//  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//
//  @override
//  void initState() {
//    loadCameras();
//  }
//
//  Future<void> loadCameras() async {
//    // Fetch the available cameras before initializing the app.
//    try {
//      cameras = await availableCameras();
//    } on CameraException catch (e) {
//      logError(e.code, e.description);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: _key,
//      appBar: null,
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: Container(
//              child: Padding(
//                padding: const EdgeInsets.all(1.0),
//                child: Center(
//                  child: _cameraPreviewWidget(),
//                ),
//              ),
//              decoration: BoxDecoration(
//                color: Colors.black,
//                border: Border.all(
//                  color: controller != null && controller.value.isRecordingVideo
//                      ? Colors.redAccent
//                      : Colors.grey,
//                  width: 3.0,
//                ),
//              ),
//            ),
//          ),
//          _captureControlRowWidget(),
//          Padding(
//            padding: const EdgeInsets.all(5.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                _cameraTogglesRowWidget(),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  /// Display the preview from the camera (or a message if the preview is not available).
//  Widget _cameraPreviewWidget() {
//    if (controller == null || !controller.value.isInitialized) {
//      return const Text(
//        'Tap a camera',
//        style: TextStyle(
//          color: Colors.white,
//          fontSize: 24.0,
//          fontWeight: FontWeight.w900,
//        ),
//      );
//    } else {
//      return AspectRatio(
//        aspectRatio: controller.value.aspectRatio,
//        child: CameraPreview(controller),
//      );
//    }
//  }
//
//  /// Display the control bar with buttons to take pictures and record videos.
//  Widget _captureControlRowWidget() {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      mainAxisSize: MainAxisSize.max,
//      children: <Widget>[
//        IconButton(
//          icon: const Icon(Icons.camera_alt),
//          color: Colors.blue,
//          onPressed: controller != null &&
//              controller.value.isInitialized &&
//              !controller.value.isRecordingVideo
//              ? onTakePictureButtonPressed
//              : null,
//        ),
//        IconButton(
//          icon: const Icon(Icons.stop),
//          color: Colors.red,
//          onPressed: controller != null &&
//              controller.value.isInitialized &&
//              controller.value.isRecordingVideo
//              ? onStopButtonPressed
//              : null,
//        )
//      ],
//    );
//  }
//
//  /// Display a row of toggle to select the camera (or a message if no camera is available).
//  Widget _cameraTogglesRowWidget() {
//    final List<Widget> toggles = <Widget>[];
//
//    if (cameras.isEmpty) {
//      return const Text('No camera found');
//    } else {
//      for (CameraDescription cameraDescription in cameras) {
//        toggles.add(
//          SizedBox(
//            width: 90.0,
//            child: RadioListTile<CameraDescription>(
//              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
//              groupValue: controller?.description,
//              value: cameraDescription,
//              onChanged: controller != null && controller.value.isRecordingVideo
//                  ? null
//                  : onNewCameraSelected,
//            ),
//          ),
//        );
//      }
//    }
//
//    return Row(children: toggles);
//  }
//
//  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
//
//  void showInSnackBar(String message) {
//    _key.currentState.showSnackBar(SnackBar(content: Text(message)));
//  }
//
//  void onNewCameraSelected(CameraDescription cameraDescription) async {
//    if (controller != null) {
//      await controller.dispose();
//    }
//    controller = CameraController(cameraDescription, ResolutionPreset.high);
//
//    // If the controller is updated then update the UI.
//    controller.addListener(() {
//      if (mounted) setState(() {});
//      if (controller.value.hasError) {
//        showInSnackBar('Camera error ${controller.value.errorDescription}');
//      }
//    });
//
//    try {
//      await controller.initialize();
//    } on CameraException catch (e) {
//      _showCameraException(e);
//    }
//
//    if (mounted) {
//      setState(() {});
//    }
//  }
//
//  void onTakePictureButtonPressed() {
//    takePicture().then((String filePath) {
//      if (mounted) {
//        setState(() {
//          imagePath = filePath;
//        });
//        if (filePath != null) showInSnackBar('Picture saved to $filePath');
//      }
//    });
//  }
//
//  void onStopButtonPressed() {
//
//  }
//
//  Future<String> takePicture() async {
//    if (!controller.value.isInitialized) {
//      showInSnackBar('Error: select a camera first.');
//      return null;
//    }
//    final Directory extDir = await getApplicationDocumentsDirectory();
//    final String dirPath = '${extDir.path}/Pictures/flutter_test';
//    await Directory(dirPath).create(recursive: true);
//    final String filePath = '$dirPath/${timestamp()}.jpg';
//
//    if (controller.value.isTakingPicture) {
//      // A capture is already pending, do nothing.
//      return null;
//    }
//
//    try {
//      await controller.takePicture(filePath);
//    } on CameraException catch (e) {
//      _showCameraException(e);
//      return null;
//    }
//    return filePath;
//  }
//
//  void _showCameraException(CameraException e) {
//    logError(e.code, e.description);
//    showInSnackBar('Error: ${e.code}\n${e.description}');
//  }
//}
