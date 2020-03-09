import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Navigator.of(context).canPop(); // true or false
            Navigator.popUntil(context, ModalRoute.withName("/"));
          },
          child: Text('BACK'),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('This is Drawer Header.'),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, const Color(0x0000CCFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'ListTile01: Back to start page',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.amber,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: Text(
                'ListTile02: Go home!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.greenAccent,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/another');
              },
            ),
          ],
        ),
      ),
    );
  }
}
