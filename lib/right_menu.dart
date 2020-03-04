import 'package:flutter/material.dart';

class RightMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 700,
          margin: EdgeInsets.only(right: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 300,
                height: 200,
                padding: EdgeInsets.only(top: 80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/home');
                      },
                      child: Text(
                        'HOME',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/contact_page');
                      },
                      child: Text(
                        'CONTACT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/login');
                      },
                      child: Text(
                        'LOGIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.lightBlueAccent],
              begin: const FractionalOffset(1.0, 0.0),
              end: const FractionalOffset(0.0, 0.0),
              //stops: [0.0, 1.0],
              //tileMode: TileMode.clamp),
            ),
          ),
        ),
      ),
    );
  }
}
