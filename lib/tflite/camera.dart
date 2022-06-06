import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'filebase_api.dart';
import 'package:path/path.dart' as path;
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
import 'package:cactus_project/screens/home.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'pop_up.dart';
import 'pop_upload.dart';


class Tflite2 extends StatefulWidget {
  const Tflite2({ Key? key }) : super(key: key);

  @override
  State<Tflite2> createState() => _Tflite2State();
}

class _Tflite2State extends State<Tflite2> {
    late CameraController controller;
    UploadTask? task;
    File?  _image;
    List _results = [];
    bool imageSelect = false;
    var indexX; //// เช็คค่ามากกว่า 0 ////
    var testX;

    @override
    void initState() {
      super.initState();
      loadModel();
    }

    Future loadModel() async {
      Tflite.close();
      String res;
        res = (await Tflite.loadModel(
          model: "assets/model/cactus8.tflite",
          labels: "assets/model/labels_cnn.txt",
          )
        )!;
      print("Models loading status: $res");
    }

  ///////////////////////  Tflite ///////////////////////////////////
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
      testX = _results[0]['confidence'].toString();
      double d = double.parse(testX);
      if(d <= 0.74){
        imageNot(context, 'ไม่สามารถจำแนกประเภทได้');
      } else if (d >= 0.75) {
        testX = d.toStringAsFixed(2);
      }
      _image = image;
      imageSelect = true;
      print('_resulte => $testX');
    });
  }

/////////////////////////// Camera //////////////////////////////////
  Future _getCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        final imageTmp = File(image.path);
        setState(() {
          this._image = imageTmp;
          imageSelect = true;
        });
        imageClassification(imageTmp);
      }
    } catch (e) {
      print('err image => $e');
    }
  }

////////////////////////// Upload Image ///////////////////////////
  Future uplpadFile() async {
    if (_image == null) return;

    final fileName = path.basename(_image!.path);
    final destination = 'imageCollect/$fileName';

    task = FirebaseApi.uploadFile(destination, _image!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    await FirebaseFirestore.instance
        .collection("imgCollect")
        //.doc()
        .add({"Image": urlDownload}).then((value) {
    });
    normalDialog(context, 'อัปโหลดไฟล์เสร็จสิ้น');
  }

////////////////////////// Upload Image Not ///////////////////////////
  Future uploadImageNot() async {
    if (_image == null) return;

    final fileName = path.basename(_image!.path);
    final destination = 'imageNotCollect/$fileName';

    task = FirebaseApi.uploadFile(destination, _image!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    await FirebaseFirestore.instance
        .collection("imgNotCollect")
        .add({"Image": urlDownload}).then((value) {
    });
    normalBack(context, 'อัปโหลดไฟล์เสร็จสิ้น');
  }

  ///////////////////////////////////////////////////////////////
  Future<Null> imageNot(BuildContext context, String string) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          //leading: Image.asset('images/logo.png'),
          title: Text(string),
        ),
        children: [
          TextButton(
            onPressed: () {
              uploadImageNot();
            },
            child: const Text('อัปโหลดไฟล์'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
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
      ),
      
      body: ListView(
        children: [ _image != null  //////////////// แสดงรูปภาพ   ///////////
        ? Container ( 
            margin: const EdgeInsets.all(20),
            child: Card( 
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [ 
                   ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)
                    ),
                    child: Container(
                      color: Colors.grey[300],
                      child: Image.file (_image!, fit:BoxFit.fill,),
                    ),
                  ),
                  upload(), ///// Button UpImage /////
                ],
              ),
            ),
        )
        : Container(   //// ยังไม่ได้เลือกรูปภาพพ /////
          margin: const EdgeInsets.all(10),
            child: const Center(
              child: Opacity(
                opacity: 0.8,
                child: Center(
                  child: Text("กรุณาถ่ายภาพ"),
                ),
              ),
            ),
        ),
           
          SingleChildScrollView( /// แสดงชื่อ ////
            child: Column(
              children: _image != null ? _results.map((result) { 
                return Card(
                  margin: EdgeInsets.all(20),
                  elevation: 8,
                  shadowColor: Colors.teal,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)
                      )
                    ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: 340,
                    child: Column(
                      children: [
                        Text( "${result['label']} $testX",
                          style: const TextStyle (
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10,),

                         TextButton(  //// ปุ่มแสดง Dec /////
                            style: TextButton.styleFrom(
                              primary: Colors.cyan[700],
                            ),
                            onPressed: () {
                              print("${result['label']}");

                              if ("${result['label']}" == 'Plumose') {
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => MamPlumose()),
                                );
                              } else if ("${result['label']}" == 'Perbella') {
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => MamPerbella()),
                                );
                              } else if ("${result['label']}" == 'Humboldtii'){
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => MamHumboldtii()),
                                );
                              } else if ("${result['label']}" == 'Carmenae'){
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => MamCarmenae()),
                                );
                              } else if ("${result['label']}" == 'Bocasana'){
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => MamBocasana()),
                                );
                              } else if ("${result['label']}" == 'Baldianum'){
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => GymBaldianum()),
                                );
                              } else if ("${result['label']}" == 'Ragonesei'){
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => GymRagonesei()),
                                );
                              } else if ("${result['label']}" == 'Damsii'){
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => GymDamsii()),
                                );
                              } else if ("${result['label']}" == 'Bruchii'){
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => GymBruchii()),
                                );
                              } else if ("${result['label']}" == 'Mihanovichii'){
                                Navigator.push(
                                context,
                                  MaterialPageRoute(builder: (context) => GymMihanovichii()),
                                );
                              } 
                            },
                            child: const Text('รายละเอียด', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList():[],
            ),
          )
        ],
      ),

      floatingActionButton: Container (  //// ปุ่มเลือกรูป //////
        height: 65.0, width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFE57373),
            onPressed: _getCamera,
            tooltip: "Pick Image Camera",
            child: const Icon(Icons.camera, color: Colors.white,),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // ย้ายไอคอน ///
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.cyan[900],
        child: Container(height: 60),
      ),
    );
  }

  TextButton add() => TextButton(   //// ดูรายเอียด ///
    onPressed: () {
      Tflite.close();
      dynamic result;
      print(result);
    }, 
    child: const Text('รายละเอียด'),
  );

  Container upload() {   //////  upload Image ////
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: () {
          uplpadFile();
        },
        child: const Text('อัปโหลดไฟล์'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}