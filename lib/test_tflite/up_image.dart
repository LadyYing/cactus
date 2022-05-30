// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'filebase_api.dart';

class Uploadregistrationdocuments extends StatefulWidget {
  Uploadregistrationdocuments({Key? key}) : super(key: key);

  @override
  State<Uploadregistrationdocuments> createState() =>
      _UploadregistrationdocumentsState();
}

class _UploadregistrationdocumentsState
    extends State<Uploadregistrationdocuments> {
  late double screen;
  UploadTask? task;
  String? femail;
  File? file;
  File? file1;
  File? file2;
  File? file3;
  TextEditingController dataemail = TextEditingController();
  TextEditingController facePhoto = TextEditingController();
  TextEditingController gradeComplete = TextEditingController();

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? path.basename(file!.path) : 'ไฟล์ pdf หรือ jpg เท่านั้น';
    final fileName1 =
        file1 != null ? path.basename(file1!.path) : 'ไฟล์ pdf เท่านั้น';

    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('อัปโหลดเอกสารขึ้นทะเบียน'),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Card(
                  elevation: 18,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'รูปภาพขนาด 1 นิ้ว ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      idcardselectFile(),
                      Text(
                        fileName,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      newButton(),
                      Divider(
                        height: 25,
                        thickness: 5,
                      ),
                      Text(
                        'เอกสารผลการเรียนฉบับสมบูรณ์',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      gradeselectFile(),
                      Text(
                        fileName1,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      newButton1(),
                      
                    ],
                  ),
                ),
              )),
        ));
  }

  Future selectFile() async {
    await FilePicker.platform.clearTemporaryFiles();
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg']);

    if (result == null) return;
    final path = result.files.single.path!;
    if ((result.files.first.size) / (pow(10, 6)) <= 10) {
      print((result.files.first.size) / (pow(10, 6))); // mb
      setState(() => file = File(path));
    } else {
      return Text('data');
      //normalDialog(context, 'ไฟล์มีขนาดใหญ่ไป');
    }

    // setState(() => file = File(path));
  }

  Future selectFile1() async {
    await FilePicker.platform.clearTemporaryFiles();
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);

    if (result == null) return;
    final path = result.files.single.path!;
    if ((result.files.first.size) / (pow(10, 6)) <= 10) {
      print((result.files.first.size) / (pow(10, 6))); // mb
      setState(() => file1 = File(path));
    } else {
      return Text('data');
      //normalDialog(context, 'ไฟล์มีขนาดใหญ่ไป');
    }
    // setState(() => file1 = File(path));
  }

  Future uplpadFile() async {
    if (file == null) return;

    final fileName = path.basename(file!.path);
    final destination = 'regis/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Future uplpadFile1() async {
    if (file1 == null) return;

    final fileName = path.basename(file1!.path);
    final destination = 'Regit/$fileName';

    task = FirebaseApi.uploadFile(destination, file1!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  TextButton idcardselectFile() => TextButton(
      onPressed: () {
        selectFile();
      },
      child: Text('>> เลือกไฟล์ <<',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900)));

  TextButton gradeselectFile() => TextButton(
      onPressed: () {
        selectFile1();
      },
      child: Text('>> เลือกไฟล์ <<',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900)));

  Container newButton() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.40,
      child: ElevatedButton(
        onPressed: () {
          uplpadFile();
        },
        child: Text('อัปโหลดไฟล์'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Container newButton1() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.40,
      child: ElevatedButton(
        onPressed: () {
          uplpadFile1();
        },
        child: Text('อัปโหลดไฟล์'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

}
