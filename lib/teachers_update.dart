//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeachersUpdate extends StatefulWidget {
  @override
  _TeachersUpdateState createState() {
    return _TeachersUpdateState();
  }
}

class _TeachersUpdateState extends State<TeachersUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('講師追加入力フォーム')),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 380,
              height: 140.0,
              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Text("ここに入力フォームを並べる"),
            ),
            Container(
              child: FlatButton(
                color: Colors.white,
                textColor: Colors.black,
                disabledColor: Colors.blueGrey, // ?
                disabledTextColor: Colors.pink, // ?
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueGrey,
                onPressed: () {
                  // TODO
                  print("講師追加イベント");
                },
                child: Text(
                  '追加',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
//      bottomNavigationBar: Footer(),
    );
  }
}
