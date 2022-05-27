import 'package:cactus_project/screens/home.dart';
import 'package:flutter/material.dart';

class MyPlants extends StatefulWidget {

  @override
  State<MyPlants> createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สวนของฉัน'),
        backgroundColor: Colors.cyan[900],
        //// back home /////
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => MenuHome()),);
          },
        ),
      ),
      
      body: ListView(
        
      ),
    );
  }
}