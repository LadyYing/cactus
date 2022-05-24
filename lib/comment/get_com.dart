import 'package:cactus_project/model_comments/user_com.dart';
import 'package:cactus_project/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


class GetComment extends StatefulWidget {
  @override
  State<GetComment> createState() => _GetCommentState();
}

class _GetCommentState extends State<GetComment> {
  
  final formKey = GlobalKey<FormState>();  /// เมื่อกดบันทึกข้อมูลในฟอร์มให้นำข้อมูลไปเก็บที่ใด เช็คผ่าน FormState ///
  Usercom myComment = Usercom('');

  final Future<FirebaseApp> firebase = Firebase.initializeApp();  /////////////// เตรียม Firebase ///////////////
  final CollectionReference _usercomCollection = FirebaseFirestore.instance.collection('usercom');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snpashot) {
        if(snpashot.hasError){
          var snapshot;
          return Scaffold(
            appBar: AppBar(title: const Text('Error'),),
            body: Center(child: Text('${snapshot.error}'),),
          );
        }
        if(snpashot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("คำแนะนำ"),
              backgroundColor: Colors.cyan[900],
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
            backgroundColor: Colors.grey[200],
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey, /// ระบุคีร์ที่สร้างขึ้นมา /////
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(     ////รูป//////////
                        child:(Image.asset ('assets/images/feedback.png', height: 220, width: 200,)),
                      ),
                      const SizedBox( height: 30,),
                      const Text('ความคิดเห็น', style: TextStyle(fontSize: 20),),
                      const SizedBox( height: 20,),
                      TextFormField(
                        validator: RequiredValidator(errorText: 'กรุณาป้อนความคิดเห็น'),  /// การตรวจสอบการถูกต้องของข้อมูล เมื่อไม่กรอกข้อมูลแล้วกดส่ง ///
                        onSaved: (String? comments){   /////
                          myComment.comments = comments!;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send,color: Theme.of(context).primaryColor,),
                            onPressed: () async{
                              if (formKey.currentState!.validate()){  /// ตรวจสอบเสร็จเรียบร้อยก็บันทึกได้  ////
                                formKey.currentState!.save();
                                await _usercomCollection.add ({  //// บันทึกข้อมูล Firebase
                                  'comments': myComment.comments,
                                });
                                formKey.currentState!.reset();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );   
        }
        return Scaffold(  //// รอโหลดข้อมูล ////
          body: Center(child: CircularProgressIndicator(),),
        );
      }
    );
  }
}