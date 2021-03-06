import 'package:cactus_project/screens/home.dart';
import 'package:cactus_project/tflite/pop_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MamBocasana extends StatefulWidget {
  @override
  State<MamBocasana> createState() => _MamBocasanaState();
}

class _MamBocasanaState extends State<MamBocasana> {
  
  final imageList = [ //// รูปภาพ 10 /////
    "image", "image1", "image2", "image3","image4", 
    "image5","image6", "image7", "image8", "image9",
  ];

  ////// เตรีสยม firebase ////////
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ผลลัพธ์"),
        backgroundColor: Colors.cyan[900],
        leading: IconButton(  ///// Blck page ////
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
             Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => MenuHome()),);
          },
        ),
      ),
      
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("MamBocasana").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData){  ///// ถ้าไม่มีข้อมูลให้แสดงหมุนๆ //////
            return const Center(child: CircularProgressIndicator(),);
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(  ///// รอรับรูปจากกล้อง  ////
                    margin: const EdgeInsets.only(top: 15, bottom: 15,),
                    padding: const EdgeInsets.only(left: 15, right: 15,),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Image.network(document['image0'], width: 230,height: 300,fit:BoxFit.fill,),
                          ),
                          const ListTile(
                            title: Text('CACTACEAE : MAMMILLARIA'),
                            subtitle: Text('ตระกลู : แมมมิลลาเรีย'),
                          ),
                        ],
                      ),
                    ), 
                  ),
                  Container(  ///// โชว์รูปต้นไม้  ////
                    margin: EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15,),
                     child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 140,
                            child: ListView.builder(
                              itemCount: imageList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, indext) => 
                              Container(
                                height: 200,
                                width: 130,
                                margin: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network (document[imageList[indext]],fit:BoxFit.fill,),
                              ),
                            ), 
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(  ///// ชื่อต้นไม้  ////
                    margin: const EdgeInsets.only(top: 10, bottom: 15,),
                    padding: const EdgeInsets.only(left: 15, right: 15,),
                    child: Card(
                      color: Colors.teal[100],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)
                        )
                      ),
                      child: Column(
                        children: <Widget> [
                          const ListTile(
                            title: Text('ข้อมูลทั่วไป Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),), 
                          ),
                          ListTile(
                            leading: const Image(image: AssetImage('assets/images/chart.png'),),
                            title: const Text('ชื่อทางวิทยาศาสตร์', style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(document["botname"], style: TextStyle(fontSize: 15), ),
                          ),
                          ListTile(
                            leading: Image(image: AssetImage('assets/images/chart.png'),),
                            title: Text('ชื่อสามัญ', style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(document["comname"], style: TextStyle(fontSize: 15),),
                          ),
                          ListTile(
                            leading: Image(image: AssetImage('assets/images/chart.png'),),
                            title: Text('ชื่ออื่น', style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(document["oname"], style: TextStyle(fontSize: 15),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(  ///// รายละเอียด  ////
                    margin: const EdgeInsets.only(top: 2, bottom: 2),
                    padding: const EdgeInsets.only(left: 15, right: 15,),
                    child: Card(
                      color: Colors.teal[100],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)
                        )
                      ),
                      child: Column(
                        children: <Widget>[
                          const ListTile(
                            title: Text('รายละเอียด Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          ListTile(
                            leading: Image(image: AssetImage('assets/images/files.png'),),
                            title: Text('ลักษณะทางพฤกษศาสตร์', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            subtitle: Text(document["des"], style: TextStyle(fontSize: 15),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(  ///// การปลูกเลี้ยง  ////
                    margin: const EdgeInsets.only(top: 8, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 15,),
                    child: Card(
                      color: Colors.teal[100],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)
                        )
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('การปลูกเลี้ยง Care', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                          ),
                          ListTile(
                            leading:  Image(image: AssetImage('assets/images/sunny.png'),),
                            title: Text('แสงแดด', style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(document["sun"], style: TextStyle(fontSize: 15),),
                          ),
                          ListTile(
                            leading: Image(image: AssetImage('assets/images/watering.png'),),
                            title: Text('น้ำ', style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(document["water"], style: TextStyle(fontSize: 15),),
                          ),
                          ListTile(
                            leading: Image(image: AssetImage('assets/images/soil.png'),),
                            title: Text('ดิน', style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(document["soil"], style: TextStyle(fontSize: 15),),
                          ),
                          ListTile(
                            leading: Image(image: AssetImage('assets/images/fertilizer2.png'),),
                            title: Text('ปุ๋ย', style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(document["fertilizer"], style: TextStyle(fontSize: 15),),
                          ),
                          ListTile(
                            leading:  Image(image: AssetImage('assets/images/malware.png'),),
                            title: Text('แมลงศัตรูพืช', style: TextStyle(fontWeight: FontWeight.bold,)),
                            subtitle: Text(document["pest"], style: TextStyle(fontSize: 15),),
                          ),
                         
                        ],
                      ),
                    ), 
                  ),
                  Container(  ///// การขยายพันธุ์ ///
                    margin: const EdgeInsets.only(top: 8, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 15,),
                    child: Card(
                      color: Colors.teal[100],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)
                        )
                      ),
                      child: Column(
                        children: [
                          const ListTile(
                            title: Text('ขยายพันธุ์ Propagation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                           ListTile(
                            leading: Image(image: AssetImage('assets/images/chemistry.png'),),
                            title: Text('การเพาะเมล็ด', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            subtitle: Text(document["propagation"], style: TextStyle(fontSize: 15),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
      
      floatingActionButton: Container( ///// ปุ่มเพิ่มสวนของฉัน  /////////
        height: 65.0, width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFE57373),
            onPressed: (){
              addbocasana();
            },
            child: const Icon(Icons.add, color: Colors.white,),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.cyan[900],
        child: Container(height: 60),
      ),
    );
  }
  
  /////////////////// Add My Plants ///////////////////////////
  String name = "Mammillaria bocasana Poselg. ";
  String oname = "Powder Puff Cactus, Powder Puff Pincushion, แมมขนแมว";
  String picture = "https://firebasestorage.googleapis.com/v0/b/cuctus2022.appspot.com/o/Cactus%2FMBocasana%2FMBocasana.jpg?alt=media&token=d87bbb8e-efa9-4d6e-b6ef-8ed927907a77";
  
  Future<void> addbocasana() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().then((value) async {
      print('----------Firebase---------');
      await FirebaseFirestore.instance
          .collection("Myplants")
          .add({
              "name": name,
              "oname": oname,
              "picture": picture,
      }).then((_) {
        print("success!");
        normalDialog(context, 'เสร็จสิ้น');
      });
    });
  }

}

