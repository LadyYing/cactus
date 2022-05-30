import 'package:cactus_project/camera_detection/camera.dart';
import 'package:cactus_project/camera_detection/capture.dart';
import 'package:cactus_project/camera_detection/home_camera.dart';
import 'package:cactus_project/comment/comment.dart';
import 'package:cactus_project/main.dart';
import 'package:cactus_project/plants/gym_baldianum.dart';
import 'package:cactus_project/plants/gym_bruchii.dart';
import 'package:cactus_project/plants/gym_damsii.dart';
import 'package:cactus_project/plants/gym_mihanovichii.dart';
import 'package:cactus_project/plants/gym_ragonesei.dart';
import 'package:cactus_project/plants/mam_carmenae.dart';
import 'package:cactus_project/plants/mam_humboldtii.dart';
import 'package:cactus_project/plants/mam_perbella.dart';
import 'package:cactus_project/plants/mam_plumose.dart';
import 'package:cactus_project/add_myplants/my_plants.dart';
import 'package:cactus_project/plants/mam_bocasana.dart';
import 'package:cactus_project/screens/tips.dart';
import 'package:cactus_project/test_tflite/test_camera.dart';
import 'package:cactus_project/test_tflite/test_gallery.dart';
import 'package:cactus_project/test_tflite/up_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MenuHome extends StatefulWidget {

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // this gonna total height and with of our device 
    
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: <Widget>[
          Container(  ////// พื้นเขียววว /////
            height: size.height * .55,
            color: Colors.teal[700],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[500],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.search_rounded),
                      onPressed:(){
                        showSearch(
                          context: context, 
                          delegate: CustomSearchDelegate(),);
                      }, 
                    ),
                  ),
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
                  SizedBox(
                    height: 40,
                  ),
                 /* Container(   ////  ค้นหา  /////
                    margin:  const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10,),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(80, 255, 255, 255),
                      borderRadius: BorderRadius.circular(27),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'ค้นหา',
                        hintStyle: TextStyle(color: Colors.white),
                        icon: Icon(Icons.search, color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),*/
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
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
                                  Image.asset('assets/images/plant.png', width: 100, height: 100, fit:BoxFit.fill),
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
                            onTap: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) =>  TestCamera(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  const Spacer(),
                                  Image.asset('assets/images/camera.png', width: 100, height: 100, fit:BoxFit.fill),
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
                                  Image.asset('assets/images/book.png', width: 100, height: 100, fit:BoxFit.fill),
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
                                  builder: (context) =>Gallery2(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  const Spacer(),
                                  Image.asset('assets/images/picture_icon.png', width: 100, height: 100, fit:BoxFit.fill),
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

class CustomSearchDelegate extends SearchDelegate{  ///// ค้นหา  //////
  
  List<String> searchTerms = [
    'Mammillaria', 'Mammillaria Plumose', 'Mammillaria Bocasana',
    'Mammillaria Perbella', 'Mammillaria Carmenae', 'Mammillaria Humboldtii',
    'Gymnocalycium', 'Gymnocalycium Mihanovichii', 'Gymnocalycium Bruchii',
    'Gymnocalycium Baldianum', 'Gymnocalycium Damsii', 'Gymnocalycium Ragonesei',
    'แมมมิลลาเรีย', 'แมมขนนก', 'แมมขนแมว', 'แมมนกฮูก', 'แมมคาร์มีเน', 'แมมลูกกอล์ฟ',
    'ยิมโนคาไลเซียม', 'ยิมโนมิฮาโน', 'ยิมโนบรูชิ', 'ยิมโนบาเนียนัม', 'ยิมโนลูกชุบ', 'ยิมโนจานบิน'
    'ยิมโน', 'แมม', 'ขนนก', 'ขนแมว', 'นกฮูก', 'คาร์มีเน', 'ลูกกอล์ฟ', 
    'มิฮาโน', 'โนบรูชิ', 'ลูกชุบ', 'ลูกดก', 'บาเนียนัม', 'จานบิน',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query ='';
        }, 
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return (
      IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        }, 
      )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
  List<String> matchQuer = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuer.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuer.length,
      itemBuilder: (context, index) {
        var result = matchQuer[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuer = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuer.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuer.length,
      itemBuilder: (context, index) {
        var result = matchQuer[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

