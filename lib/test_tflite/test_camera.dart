import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';


class Tflite2 extends StatefulWidget {
  const Tflite2({ Key? key }) : super(key: key);

  @override
  State<Tflite2> createState() => _Tflite2State();
}

class _Tflite2State extends State<Tflite2> {
    late CameraController controller;
    File?  _image;
    late List _results;
    //bool imageSelect = false;


    @override
    void initState()
    {
      super.initState();
      loadModel();
    }

    Future loadModel() async {
      Tflite.close();
      String res;
        res = (await Tflite.loadModel(
          model: "assets/test/model_unquant.tflite",
          labels: "assets/test/labels.txt",
          )
        )!;
      print("Models loading status: $res");
    }

    Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 10,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      //imageSelect = true;
    });
  }

   /////////////////////////////////////////////////////////////
  Future _getCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        final imageTmp = File(image.path);
        setState(() {
          this._image = imageTmp;
          imageClassification(imageTmp);
        });
      }
    } catch (e) {
      print('err image => $e');
    }
  }
   ////////////////////////////////////////////////////////////////////////

  Future pickImageC() async { /// กล้อง ///////
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      final imageTemp = File(pickedFile!.path);
      imageClassification(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar( 
        centerTitle: true,
        title: const Text("กล้อง"),
        backgroundColor: Colors.cyan[900],
        leading: IconButton( //// กลับไปหน้าแรก ///
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => MenuHome()),);
          },
        ),
      ),*/
      body: ListView(
        children: [ 
           _image != null ? Image.file(_image!) : Text('กรุณาถ่ายภาพ', textAlign: TextAlign.center,),
        
          SingleChildScrollView( /// แสดงชื่อ ////
            child: Column(
              children: _image != null ? _results.map((result) { 
                return Card(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      "${result['label']}",
                      style: const TextStyle(color: Colors.red,
                      fontSize: 15),
                    ),
                  ),
                );
              }).toList():[],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(  //// ถ่ายรูป //////
        onPressed: _getCamera,
        tooltip: "Pick Image Camera",
        hoverElevation: 50,
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}