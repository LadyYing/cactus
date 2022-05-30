import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

const String ssd = "SSD MobileNet";

class TfilteHome extends StatefulWidget {
  @override
  State<TfilteHome> createState() => _TfilteHomeState();
}

class _TfilteHomeState extends State<TfilteHome> {
  final String _model = ssd;
  File? _image;
  double? _imageWidth;
  double? _imageHeight;
  bool _busy = false;
  List? _recognitions;

  @override
  void initState() {
    super.initState();
    _busy = true;
    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });  
  }

  loadModel() async{
    Tflite.close();
    try {
      String res;
      if (_model == ssd) {
        res = (await Tflite.loadModel(
          labels: "assets/test/labels.txt",
          model: "assets/test/model2.tflite",
        ))!;
      }  
    } on PlatformException{
        print("Failed to load the model");
      }
  }

  selectFromImagePicker() async {
    var imageSelect = await ImagePicker().getImage(source: ImageSource.gallery);
    File image = File (imageSelect!.path);
    if (image == null) return;
    setState(() {
      _busy = true;
    });
    predictImage(image);
  }

  predictImage(File image) async {
    if (image == null) return;
    if (_model == ssd) {
      await ssdModelNet(image);
    }

    FileImage(image)
      .resolve(const ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
        setState(() {
          _imageWidth = info.image.width.toDouble();
          _imageHeight = info.image.height.toDouble();
        });
      }));
      setState(() {
        _image = image;
        _busy = false;
      });
  }
  
  ssdModelNet(File image) async {
    var _recognitions = await Tflite.detectObjectOnImage(
      path: image.path, numResultsPerClass: 1);
    setState((){
      _recognitions = _recognitions;
    });
  }

  List<Widget> rederBoxes(Size screen){
    if(_recognitions == null) return[];
    if (_imageWidth == null || _imageHeight == null) return[];

    double factorX = screen.width;
    double factorY = _imageHeight! / _imageHeight! * screen.width;

    Color blue = Colors.blue;
    return _recognitions!.map((re) {
      return Positioned(
        left: re ["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 3,
            )
          ),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}",
            style: TextStyle(
              background: Paint()..color = blue,
              fontSize: 15,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        child: _image == null ?  const Text('No Image Selected') : Image.file(_image!),
      )
    );

    stackChildren.addAll(rederBoxes(size));
    if(_busy){
      stackChildren.add( 
        const Center(
          child: CircularProgressIndicator(),
        )
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("TFlite Demo"),),
      body: Stack(
        
      ),
       
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.image),
        tooltip: "Pick Image From gallery",
        onPressed: selectFromImagePicker(),
      ),
    );
  }
}
