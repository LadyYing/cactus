import 'package:cactus_project/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final Future<FirebaseApp> firebase = Firebase.initializeApp();

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
      
       body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Myplants').snapshots(),
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
                    leading: Image.network(document['picture'], fit:BoxFit.fill,),
                    title: Text(document['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                    subtitle: Text(document['oname'], style: const TextStyle(fontSize: 14),),
                    //trailing: const Icon(Icons.more_vert),
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