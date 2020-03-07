import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeachersUpdate extends StatefulWidget {
  @override
  _TeachersUpdateState createState() {
    return _TeachersUpdateState();
  }
}

// documentIDを指定しない場合はFirestore側で自動的に一意なIDが生成される。
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
              padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Email",
                      fillColor: Colors.greenAccent,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Email cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
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
                  String documentID = "moheji";
                  Map<String, dynamic> data = {
                    "full_name": "屁野 茂平次",
                    "specialty": "Cobol/C#/Go",
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
