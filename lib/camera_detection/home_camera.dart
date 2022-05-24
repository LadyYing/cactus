import 'camera.dart';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:cactus_project/camera_detection/bounding_box.dart';

const String ssd = "Model";

class HomeCamera extends StatefulWidget {
  final List<CameraDescription> cameras;
  HomeCamera(this.cameras);
  
  @override
  State<HomeCamera> createState() => _HomeCameraState();
}

class _HomeCameraState extends State<HomeCamera> {
  
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  loadModel() async{
    String result;

    switch (_model){
      case ssd:
        result = (await Tflite.loadModel(
          labels: "assets/model/detect.txt",
          model: "assets/model/detect.tflite",
        ))!;
    }
    print('result');
  }

  onSelectModel(model) {
    setState(() {
      _model = model;
    });

    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screen;
    return Scaffold(
      body:  _model == ""
          ? Container()
          : Stack(
            children: <Widget> [
              Camera(
                widget.cameras, 
                _model, 
                setRecognitions,
              ),
              BoundingBox(
                _recognitions,
                math.max(_imageHeight, _imageWidth),
                math.min(_imageHeight, _imageWidth),
                screen.width,
                screen.height,
                _model
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              onSelectModel(ssd);
            },
            child: const Icon(Icons.photo_camera),
          ),
    );
  }
}