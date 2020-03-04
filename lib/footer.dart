import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer();

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 10, fontWeight: FontWeight.bold, backgroundColor: Colors.white);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /* MaterialクラスをラッパーにしてBoxDecoration:gradientを適用したContainerを親にしたり
     SizedBox()やStack()を親にしてWidgetを重ねてみたりしてみたが、いずれの方法も
     BottomNavigationBarItemをバラバラに囲んで背景をグラデーションにすることは叶わず
     BottomNavigationBarを使わずRow, Column, Containerの組み合わせで作った方が早そう
   */
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey,
      child: Row(
        children: <Widget>[
          Expanded(
            child: BottomNavigationBar(
              backgroundColor: Colors.lightBlue,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blue,
                  title: Text('HOME', style: optionStyle),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.yellow,
                  title: Text(
                    'CONTACT',
                    style: optionStyle,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.red,
                  title: Text(
                    'LOGIN',
                    style: optionStyle,
                  ),
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              //selectedItemColor: Colors.amber[800],
              fixedColor: Colors.pinkAccent[200],
              selectedFontSize: 30,
              //selectedLabelStyle: TextStyle(color: Colors.blueAccent),
              type: BottomNavigationBarType.shifting,
              //unselectedItemColor: Colors.orangeAccent,
            ),
          ),
        ],
      ),
    );
  }
}
