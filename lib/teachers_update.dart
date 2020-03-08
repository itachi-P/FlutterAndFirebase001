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
  //final _formKey = GlobalKey<FormState>();

  String _documentId = "";
  String _full_name = "";
  String _specialty = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('講師追加入力フォーム')),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 380,
              height: 280.0,
              padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    maxLength: 20,
                    autovalidate: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.book),
                      labelText:
                          "Please enter the teacher's nickname in lowercase letters.",
                      hintText: "Teachers documentID",
                      fillColor: Colors.greenAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (String value) {
                      return value.isEmpty ? '必須入力です。' : null;
                    },
                    onSaved: (String value) {
                      this._documentId = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 20,
                    maxLengthEnforced: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Enter Teacher's full name.",
                      hintText: "Teachers full name",
                      fillColor: Colors.greenAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (String value) {
                      return value.isEmpty ? '必須入力です。' : null;
                    },
                    onSaved: (String value) {
                      this._full_name = value;
                    },
                  ),
                  TextFormField(
                    maxLength: 30,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.star),
                      labelText: "Enter Teacher's specialty.",
                      fillColor: Colors.greenAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (String value) {
                      return value.isEmpty ? '必須入力です。' : null;
                    },
                    onSaved: (String value) {
                      this._specialty = value;
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.black,
                disabledColor: Colors.blueGrey, // ?
                disabledTextColor: Colors.pink, // ?
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueGrey,
                onPressed: () {
                  // TODO
                  //dummy
                  String documentID = "abc";
                  Map<String, dynamic> data = {
                    "full_name": _full_name,
                    "specialty": _specialty,
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
