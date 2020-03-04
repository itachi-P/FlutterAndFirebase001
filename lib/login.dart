import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login page'),
      ),
      body: Center(
        child: Text(
          'This is authentication page.',
          style: TextStyle(
            fontSize: 25,
            decorationStyle: TextDecorationStyle.dotted, // 変化なし、無効な設定？
          ),
        ),
      ),
    );
  }
}
