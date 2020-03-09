import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'another.dart';
import 'contact.dart';
import 'footer.dart';
import 'header.dart';
import 'login.dart';
import 'right_menu.dart';
import 'teachers.dart';
import 'test_input_forms.dart';

void main() {
  //debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/contact_page': (BuildContext context) => Contact(),
        '/login': (BuildContext context) => Login(),
        '/right_menu': (BuildContext context) => RightMenu(),
        '/teachers': (BuildContext context) => Teachers(),
        '/another': (BuildContext context) => Another(),
        '/test_input_forms': (BuildContext context) => TestInputForm(),
      },
      title: 'task03 connect firestore',
      home: KatachiHomePage(),
    );
  }
}

class KatachiHomePage extends StatefulWidget {
  @override
  _KatachiHomePage createState() {
    return _KatachiHomePage();
  }
}

class _KatachiHomePage extends State<KatachiHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 380,
              height: 140.0,
              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Image.network(
                  'http://goope.akamaized.net/66978/191108172416e7zr_l.jpg'),
            ),
            Container(
              color: Colors.blue,
              width: 400.0,
              height: 160.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.fromLTRB(0, 0, 8.0, 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '-就労移行支援事業所「未来のはまち」-\n経験ゼロのオマエをIT就労できる人材に躾けます\nオマエに必要なのは『隷属』だけ！！',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color.fromRGBO(230, 230, 230, 0.8),
              width: 380.0,
              height: 250.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'images/katachi_row01.png',
                      width: 160.0,
                      color: Colors.purple,
                      colorBlendMode: BlendMode.plus,
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'images/katachi_row02.png',
                      width: 160.0,
                      color: Colors.lightGreenAccent.withOpacity(0.2),
                      colorBlendMode: BlendMode.srcOver,
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
                splashColor: Colors.greenAccent,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Teachers();
                      },
                    ),
                  );
                },
                child: Text(
                  '講師紹介',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
