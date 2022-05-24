import 'package:cactus_project/comment/review.dart';
import 'package:cactus_project/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'display.dart';
import 'get_com.dart';

class HomeCom extends StatefulWidget {
  @override
  State<HomeCom> createState() => _HomeComState();
}

class _HomeComState extends State<HomeCom> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.cyan[900],

        body: TabBarView(
          children: [
            GetComment(),
            Review(),
            Display(),
          ],
        ),
        bottomNavigationBar: TabBar(  ///กดเลือกกี่เมนู///
          tabs: [
            Tab( icon: Icon(Icons.message_rounded), text: 'Suggestion'),
            Tab(icon: Icon(Icons.rate_review_rounded), text: 'Rating',),
            Tab(icon: Icon(Icons.summarize_rounded), text: 'Comment'),
          ],
        ),
      ),
    );
  }
}