import 'package:cactus_project/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path/path.dart';

class Review extends StatefulWidget {
  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("รีวิว"),
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
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ความพึงพอใจ: $rating', style:  TextStyle(fontSize: 25),),
            const SizedBox(height: 32,),
            buildRating(),
            const SizedBox(height: 32,),
            TextButton(
              onPressed: () => showRating(context), 
              child:  Text('Show Dialog',style: TextStyle(fontSize: 20),),
            ),
          ], 
        ),
      ),
    );
  }

  Widget buildRating() => RatingBar.builder (
      initialRating: rating,
      minRating: 1, /// เริ่มต้นที่ 1
      itemSize: 30,
      itemPadding: EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context,_) =>  Icon(Icons.star, color: Colors.amber,),
      updateOnDrag: true, //// ลากได้แบบไม่ต้องนั้งกดที่ละอัน
      onRatingUpdate: (rating) => setState((){
        this.rating = rating;
      }),
  );

 void showRating(context) => showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text('ความพึงพอใจ'),
       content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('โปรดให้คะแนน', style: TextStyle(fontSize: 15),),
          SizedBox(height: 32),
          buildRating(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text('ตกลง', style: TextStyle(fontSize: 20),),
        ),
      ],
    ),
  );
}
      
    