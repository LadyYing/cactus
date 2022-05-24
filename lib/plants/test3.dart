import 'package:cactus_project/model_mam/mo_bocasana.dart';
import 'package:cactus_project/model_mam/mo_plumose.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class Test3 extends StatefulWidget {
  @override
  State<Test3> createState() => _Test3State();
}

class _Test3State extends State<Test3> {

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test3"),
        backgroundColor: Colors.cyan[900],
      // Blck page
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("cactus").where("id", isEqualTo: 1).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData){  //ถ้าไม่มีข้อมูลให้แสดงหมุนๆ
            return const Center(child: CircularProgressIndicator(),);
          }
          
          return ListView.builder(
            //scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              var temp = snapshot.data!.docs[index];
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                    child: Text(temp["id"]),
                  ),
                );
            }
          );
        }
      ),
    );
  }
}