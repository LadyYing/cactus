
import 'package:cactus_project/add_myplants/my_plants.dart';
import 'package:cactus_project/camera_detection/camera.dart';
import 'package:cactus_project/camera_detection/capture.dart';
import 'package:cactus_project/plants/gym_baldianum.dart';
import 'package:cactus_project/plants/gym_bruchii.dart';
import 'package:cactus_project/plants/gym_damsii.dart';
import 'package:cactus_project/plants/gym_mihanovichii.dart';
import 'package:cactus_project/plants/gym_ragonesei.dart';
import 'package:cactus_project/plants/mam_carmenae.dart';
import 'package:cactus_project/plants/mam_humboldtii.dart';
import 'package:cactus_project/plants/mam_perbella.dart';
import 'package:cactus_project/plants/mam_plumose.dart';
import 'package:cactus_project/plants/mam_bocasana.dart';
import 'package:cactus_project/screens/gallery.dart';
import 'package:cactus_project/test_tflite/test_camera.dart';
import 'package:cactus_project/test_tflite/test_gallery.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cactus_project/camera_detection/home_camera.dart';
import 'package:cactus_project/screens/home.dart';
import 'package:cactus_project/screens/tips.dart';


late List<CameraDescription> cameras;
const String ssd = "SSD MobileNet";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error $e.code \n Error Message: $e.message');
  }
  runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "mali", 
        backgroundColor: Colors.cyan[900],
      ),
      debugShowCheckedModeBanner: false, 

      //// กำหนดเส้นทางหน้าอื่นโดยไม่ต้องแก้ไข /////
      initialRoute: '/',
      routes: {
        '/' : (context) => MenuHome(),
        '/two' : (context) => MyPlants(),
        '/three' : (context) => MamPerbella(),
        '/four' : (context) => Tisp(),
        '/Five' : (context) =>  Gallery(),
      }
    );
  }
}