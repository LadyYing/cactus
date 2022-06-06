import 'package:cactus_project/screens/home.dart';
import 'package:flutter/material.dart';



Future<Null> normalBack(BuildContext context, String string) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        //leading: Image.asset('images/logo.png'),
        title: Text(string),
      ),
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
                MaterialPageRoute(builder: (context) => MenuHome()),
            );
          },
          child: Text('ตกลง'),
        )
      ],
    ),
  );
}
