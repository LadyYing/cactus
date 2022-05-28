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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'home.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  
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
        model: "assets/test/model2.tflite",
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

////////////////////////// Upload Image ///////////////////////////
  PickedFile? pickedFile;
  UploadTask? uploadTask;
  Future uploadImage() async{
    final path = 'ImageCollect/${imageSelect}';
    final file= File(pickedFile!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
    
    final snapshot = await uploadTask!.whenComplete(() {});
    final ulrDownload = await snapshot.ref.getDownloadURL();
      print('Download Link: $ulrDownload');
  }
///////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text("ผลลัพธ์"),
        backgroundColor: Colors.cyan[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => MenuHome()),);
          },
        ),
      ),
      
      body: ListView(
        children: [ (imageSelect)
        ? Container (     /// แสดงรูปภาพ   ///////////
            margin: const EdgeInsets.all(10),
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
                      child: Image.file (_image, fit:BoxFit.fill,),
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
                  child: Text("กรุณาเลือกรูปภาพ"),
                ),
              ),
            ),
        ),  
          
          SingleChildScrollView(  /// แสดงชื่อ ////
            child: Column(
              children: (imageSelect)?_results.map((result) {
                return Card(
                  elevation: 8,
                  shadowColor: Colors.teal,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)
                    )
                  ),
                  child: Container(
                    width: 340,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text (
                          "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
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
                            Tflite.close();
                            print("${result['label']}");
                            print('${result['confidence']}');

                            if ("${result['label']}" == '0 Perbella') {
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => MamPerbella()),
                              );
                            } else if ("${result['label']}" == '1 Carmenae') {
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => MamCarmenae()),
                              );
                            } else if ("${result['label']}" == '2 Plumose'){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => MamPlumose()),
                              );
                            } else if ("${result['label']}" == '3 Humboldtii'){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => MamHumboldtii()),
                              );
                            } else if ("${result['label']}" == '4 Bocasana'){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => MamBocasana()),
                              );
                            } else if ("${result['label']}" == '5 Baldianum'){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => GymBaldianum()),
                              );
                            } else if ("${result['label']}" == '6 Damsii'){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => GymDamsii()),
                              );
                            } else if ("${result['label']}" == '7 Bruchii'){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => GymBruchii()),
                              );
                            } else if ("${result['label']}" == '8 Mihanovichii'){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => GymMihanovichii()),
                              );
                            } else if ("${result['label']}" == '9 Ragonesei'){
                              Navigator.push(
                              context,
                                MaterialPageRoute(builder: (context) => GymRagonesei()),
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
          ), 
        ],
      ),

      floatingActionButton: Container (  //// ปุ่มเลือกรูป //////
        height: 65.0, width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFE57373),
            onPressed: pickImage,
            tooltip: "Pick Image",
            child: const Icon(Icons.image, color: Colors.white,),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // ย้ายไอคอน ///
    );
  }

  Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    imageClassification(image);
  }

  TextButton add() => TextButton(   //// ดูรายเอียด ///
    onPressed: () {
      Tflite.close();
      dynamic result;
      print(result);
    }, 
    child: Text('รายละเอียด'),
  );

  ElevatedButton upload() => ElevatedButton(  /// uploadImage ///////
    
    onPressed: uploadImage, 
    child: Text('อัปโหลด'),
  );

}