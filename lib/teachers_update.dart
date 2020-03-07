import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeachersUpdate extends StatefulWidget {
  @override
  _TeachersUpdateState createState() {
    return _TeachersUpdateState();
  }
}

void setData(String collection, String documentID, Map data) {
  Firestore.instance.collection(collection).document(documentID).setData(data);
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
              child: Column(
                children: <Widget>[],
              ),
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
                  //dummy
                  String documentID = "yamada";
                  Map<String, dynamic> data = {
                    "full_name": "山田太郎",
                    "specialty": "Cobol/Elixir/Haskell",
                  };
                  setData('teachers', documentID, data);
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
