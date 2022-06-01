import 'package:cactus_project/add_myplants/my_plants.dart';
import 'package:cactus_project/tflite/gallery.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
        /*'/two' : (context) => MyPlants(),
        '/three' : (context) => TestCamera(),
        '/four' : (context) => Tisp(),
        '/Five' : (context) =>  Gallery(),*/
      }
    );
  }
}