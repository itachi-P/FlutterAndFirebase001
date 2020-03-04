import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

/*  createState() => new _HeaderState();
}
class _HeaderState extends State<Header> {
  int _sel_menu_num = 0;
  void selectMenu() {
    setState(() {
      this._sel_menu_num = _sel_menu_num;
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Image.asset(
        'images/katachi_logo01.png',
        height: 30.0,
        width: 200.0,
        fit: BoxFit.contain,
      ),
      /*
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, const Color(0xFF3366FF)],
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(0.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
       */
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.menu,
            size: 40,
          ),
          iconSize: 35.0,
          color: Color.fromARGB(500, 0, 0, 200),
          tooltip: 'Show menu',
          onPressed: () {
            Navigator.of(context).pushNamed('/right_menu');
          },
        ),
      ],
    );
  }
}
