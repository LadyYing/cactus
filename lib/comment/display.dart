import 'package:cactus_project/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Future<FirebaseApp> firebase = Firebase.initializeApp();

class Display extends StatefulWidget {
  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        centerTitle: true,
        title: const Text("สรุป"),
        // Blck page
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => MenuHome()),);
          },
        ),
      ),
      
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('usercom').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          return ListView(
            children: snapshot.data!.docs.map((document) { //// ดึงข้อมูล ////
              return Container(
                margin: const EdgeInsets.only(top: 10,),
                padding: const EdgeInsets.only(left: 15, right: 15,),
                child: Card(
                  color: Colors.teal[100],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)
                    )
                  ),
                  child: ListTile(
                     leading: const Image(image: AssetImage('assets/images/talk.png'),),
                     title: Text(document['comments'], style: const TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}