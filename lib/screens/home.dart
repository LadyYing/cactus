import 'package:cactus_project/comment/comment.dart';
import 'package:cactus_project/add_myplants/my_plants.dart';
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
import 'package:cactus_project/screens/tips.dart';
import 'package:cactus_project/tflite/camera.dart';
import 'package:cactus_project/tflite/pop_up.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../tflite/gallery.dart';

class MenuHome extends StatefulWidget {

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  @override
  Widget build(BuildContext context) {
    String? search;
    var size = MediaQuery.of(context).size; // this gonna total height and with of our device 
    
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: <Widget>[
          Container(  ////// พื้นเขียววว /////
            height: size.height * .60,
            color: Colors.teal[700],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.teal[500],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Image.asset('assets/images/message.png'),
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => HomeCom()),);
                        },
                      )
                    ),
                  ),
                  Text('Good Mornning \nThis Cactus',
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox( height: 15,),
                  Container( ////////////////////  ช่องค้นหา  /////
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5,),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(80, 255, 255, 255),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: TextFormField(
                      onChanged: (value) => search = value.trim() ,
                      decoration: const InputDecoration(
                        hintText: 'ค้นหา',
                        hintStyle: TextStyle(color: Colors.white),
                        icon: Icon(Icons.search, color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Column(   /////// ปุ่มค้นหา /////////////
                    children: [
                      Container( 
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            if ((search == "Plumose") || (search == "plumose") || (search == 'แมมขนนก') || (search == 'ขนนก')) {
                               Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MamPlumose()),
                              );
                            } else if ((search == "Bocasana") || (search == "bocasana") || (search == 'แมมขนแมว') || (search == 'ขนแมว') ) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MamBocasana()),
                              );
                            } else if ((search == "Perbella") || (search == "perbella") || (search == 'แมมนกฮูก') || (search == "นกฮูก")) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MamPerbella()),
                              );
                            } else if ((search == "Carmenae") || (search == "carmenae") || (search == 'คาร์มีเน') ) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MamCarmenae()),
                              );
                            } else if ((search == "Humboldtii") || (search == "humboldtii") || (search == 'แมมลูกกอล์ฟ') || (search == 'ลูกกอล์ฟ')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MamHumboldtii()),
                              );
                            } else if ((search == "Mihanovichii") || (search == "mihanovichii") || (search == 'ยิมโนมิฮาโน') || (search == 'มิฮาโน')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GymMihanovichii()),
                              );
                            } else if ((search == "Bruchii") || (search == "bruchii") || (search == 'ยิมโนบรูชิ') || (search == 'บรูชิ')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GymBruchii()),
                              );
                            } else if ((search == "Baldianum") || (search == "baldianum") || (search == 'ยิมโนบาเนียนัม') || (search == 'บาเนียนัม')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GymBaldianum()),
                              );
                            } else if ((search == "Damsii") || (search == "damsii") || (search == 'ยิมโนลูกชุบ') || (search == 'แม่ลูกดก') || (search == 'ลูกชุบ')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GymDamsii()),
                              );
                            } else if ((search == "Ragonesei") || (search == 'Ragonesei') || (search == 'จานบิน') ) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GymRagonesei()),
                              );
                            } else {
                               normalDialog(context, 'ไม่พบข้อมูล');
                            }
                          },
                          child: const Text('ค้นหา'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox( height: 10,),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      children: <Widget>[
                        Card(
                          shape:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13), 
                              borderSide: const BorderSide(color: Colors.white)
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => MyPlants(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  const Spacer(),
                                  Image.asset('assets/images/plant.png', width: 70, height: 70, fit:BoxFit.fill),
                                  const Spacer(),
                                  Text(
                                    'สวนของฉัน',
                                    textAlign: TextAlign.center,
                                    style: 
                                      Theme.of(context)
                                      .textTheme.headline6!
                                      .copyWith(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13), 
                              borderSide: const BorderSide(color: Colors.white)
                          ),
                          child: InkWell(
                            onTap: () async {
                              await availableCameras().then(
                              (value) => Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) =>  Tflite2(),
                                ),
                              ),);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  const Spacer(),
                                  Image.asset('assets/images/camera.png', width: 70, height: 70, fit:BoxFit.fill),
                                  const Spacer(),
                                  Text(
                                    'กล้อง',
                                    textAlign: TextAlign.center,
                                    style: 
                                      Theme.of(context)
                                      .textTheme.headline6!
                                      .copyWith(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13), 
                              borderSide: const BorderSide(color: Colors.white)
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => Tisp(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  const Spacer(),
                                  Image.asset('assets/images/book.png', width: 70, height: 70, fit:BoxFit.fill),
                                  const Spacer(),
                                  Text(
                                    'คู่มือแนะนำ',
                                    textAlign: TextAlign.center,
                                    style: 
                                      Theme.of(context)
                                      .textTheme.headline6!
                                      .copyWith(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13), 
                              borderSide: const BorderSide(color: Colors.white)
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) =>Gallery(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  const Spacer(),
                                  Image.asset('assets/images/picture_icon.png', width: 70, height: 70, fit:BoxFit.fill),
                                  const Spacer(),
                                  Text(
                                    'รูปภาพ',
                                    textAlign: TextAlign.center,
                                    style: 
                                      Theme.of(context)
                                      .textTheme.headline6!
                                      .copyWith(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

