import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TestInputForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "Welcome to Flutter",
      home: Material(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          color: Colors.white,
          child: Container(
            child: Center(
              child: Column(children: [
                Padding(padding: EdgeInsets.only(top: 140.0)),
                Text(
                  'Beautiful Flutter TextBox',
                  style:
                      TextStyle(color: hexToColor("#F2A03D"), fontSize: 25.0),
                ),
                Padding(padding: EdgeInsets.only(top: 50.0)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter full name.",
                    fillColor: Colors.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
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
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    'Home',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
