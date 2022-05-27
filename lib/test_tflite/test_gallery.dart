import 'dart:io';
import 'package:cactus_project/plants/gym_baldianum.dart';
import 'package:cactus_project/plants/gym_bruchii.dart';
import 'package:cactus_project/plants/gym_damsii.dart';
import 'package:cactus_project/plants/gym_mihanovichii.dart';
import 'package:cactus_project/plants/gym_ragonesei.dart';
import 'package:cactus_project/plants/mam_bocasana.dart';
import 'package:cactus_project/plants/mam_carmenae.dart';
import 'package:cactus_project/plants/mam_humboldtii.dart';
import 'package:cactus_project/plants/mam_perbella.dart';
import 'package:cactus_project/plants/mam_plumose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);
  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  late File _image;
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


  Future detaList() async {
    Tflite.close();
    dynamic result;
    if(result == 0) {
      return MamPerbella();
    } else if (result == 1) {
        return MamCarmenae();
    } else if (result == 2) {
        return MamPlumose();
    } else if (result == 3) {
        return MamHumboldtii();
    } else if (result == 4) {
        return MamBocasana();
    } else if (result == 5) {
        return GymBaldianum();
    } else if (result == 6) {
        return GymDamsii();
    } else if (result == 7) {
        return GymBruchii();
    } else if (result == 8) {
        return GymMihanovichii();
    } else if (result == 9) {
        return GymRagonesei();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text("ผลลัพธ์"),
        backgroundColor: Colors.cyan[900],
      ),
      body: ListView(
        children: [ (imageSelect)
        ? Container(
            margin: const EdgeInsets.all(10),
            child: Image.file(_image),
        )
        
        :Container(   //// ยังไม่ได้เลือกรูปภาพพ /////
          margin: const EdgeInsets.all(10),
            child: const Opacity(
              opacity: 0.8,
              child: Center(
                child: Text("กรุณาเลือกรูปภาพ"),
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
      floatingActionButton: FloatingActionButton (  //// ปุ่มเลือกรูป //////
        onPressed: pickImage,
        tooltip: "Pick Image",
        child: const Icon(Icons.image),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // ย้ายไอคอน ///
    );
  }

  Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}