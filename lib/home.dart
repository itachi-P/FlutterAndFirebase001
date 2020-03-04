import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Home(仮)'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              size: 40,
              color: Color.fromRGBO(80, 40, 60, 0.6),
            ),
            onPressed: () {
              // TODO
              print("This menu is dummyだこりゃ。");
            },
          ),
        ],
      ),
      body: SizedBox(
        width: 300,
        height: 400,
        child: Stack(
          children: <Widget>[
            Container(
              width: 300,
              height: 400,
              color: Colors.purpleAccent,
            ),
            Container(
              width: 290.0,
              height: 250.0,
              padding: EdgeInsets.only(left: 30.0, top: 20.0),
              margin: EdgeInsets.only(top: 80.0, left: 5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 8.0,
                ),
              ),
              child: Text(
                '今現在実質的なホーム画面である'
                '初期画面からHeaderとFooterだけを共通部分として残し、'
                'メインのbody部分はメニュー選択によって入れ替わる静的画面の1つとして'
                'このページ(home.dart/Homeクラス)に分離したいところ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black12,
                    Colors.pink
                  ],
                ),
              ),
              child: Text(
                "This is Foreground Textだす。",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
