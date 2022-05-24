import 'package:cactus_project/screens/home.dart';
import 'package:flutter/material.dart';

class Tisp extends StatefulWidget {

  @override
  _TispState createState() => _TispState();
}

class _TispState extends State<Tisp> {

  var titleList = [
    "จัดตำแหน่ง",
    "ขนาดกระบองเพชร",
    "ตรวจสอบแสง",
    "จำนวนกระบองเพชร",
    "ความคมชัดภาพ",
  ];

  var descList = [
    "วางต้นกระบองเพชรให้กลางกรอบที่กำหนด",
    "ถ้าขนาดใหญ่เกินไป ให้ถ่ายดอกหรือแค่บางส่วนที่สามารถเห็นได้",
    "แสงสว่างเพียงพอต่อการถ่ายภาพ",
    "หากมีกระบองเพชรหลายต้นให้ถ่ายแค่ต้นเดียว ห้ามถ่ายรวมเป็นกลุ่มๆ",
    "ความชัดเจนของภาพ หรือความเบลอของภาพมีผลต่อการให้ข้อมูล",
  ];

  var imgList = [
    "assets/images/Slide2.PNG",
    "assets/images/Slide3.PNG",
    "assets/images/Slide4.PNG",
    "assets/images/Slide5.PNG",
    "assets/images/Slide6.PNG",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("คู่มือถ่ายภาพ"),
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
      body: ListView.builder(
        itemCount: imgList.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              ShowDialogFunc(context, imgList[index], titleList[index], descList[index],);
            },
            child: Card( 
              margin: const EdgeInsets.all(6.0),
              color: Colors.teal[400],
              child: Row( 
                children: <Widget>[ 
                  Container( 
                    width: 100, height: 100,
                    child: Image.asset(imgList[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          titleList[index],
                          style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,),
                        ),
                        const SizedBox (height: 10,),
                      Container(                    //ตัวDESC 
                          width: width,
                          child: Text(
                            descList[index],
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ],),  
            ),
          );
        }), 
    );
  }
}

ShowDialogFunc(context, img, title, desc){
  return showDialog(
    context: context,
    builder: (context){
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child:  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.teal[200],
            ),
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.85,
            height: 330,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(img, width: 200, height: 200,),
                ),
                const SizedBox(height: 10,),
                Text(
                  title, 
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  desc, 
                  style: const TextStyle(
                    fontSize: 15, color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      );
    }
  );
}
