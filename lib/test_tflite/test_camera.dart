import 'dart:io';
import 'package:cactus_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Tflite2 extends StatefulWidget {
  const Tflite2({ Key? key }) : super(key: key);

  @override
  State<Tflite2> createState() => _Tflite2State();
}

class _Tflite2State extends State<Tflite2> {
    File?  _image;
    late List _results;
    bool imageSelect = false;

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
      imageSelect = true;
    });
  }

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
        children: [ (imageSelect)
        ? Container(
          margin: const EdgeInsets.all(10),
          child: Image.file(_image!),
        )

        : Container(   //// ยังไม่ได้เลือกรูปภาพพ /////
          margin: const EdgeInsets.all(10),
            child: const Opacity(
              opacity: 0.8,
              child: Center(
                child: Text("กรุณาถ่ายรูปภาพ", textAlign: TextAlign.center,),
              ),
            ),
        ),
          SingleChildScrollView( /// แสดงชื่อ ////
            child: Column(
              children: (imageSelect)?_results.map((result) {
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
        onPressed: pickImageC,
        tooltip: "Pick Image Camera",
        hoverElevation: 50,
        child: const Icon(Icons.camera),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}