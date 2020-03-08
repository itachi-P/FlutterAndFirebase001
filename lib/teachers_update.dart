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
  // Formウィジェット内の各フォームを識別するためのキーを設定
  final _formKey = GlobalKey<FormState>();
  // フォーカス管理用のFocusNode
  final documentIdFocus = FocusNode();
  final fullNameFocus = FocusNode();
  final specialtyFocus = FocusNode();

  String _documentId = "";
  String _fullName = "";
  String _specialty = "";

  // 登録処理完了後、全てのフォームの値を空白にするにはTextEditingControllerを使用
  final TextEditingController _documentIdController = TextEditingController();

  // ※参考用に追加、入力内容を整数値に制限させる & onSavedじゃない変数保持
  var _teachersAge = 0;
  final ageFocus = FocusNode();
  // 年齢更新用メソッド
  void _updateAge(int age) {
    setState(() {
      _teachersAge = age;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('講師追加入力フォーム')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              width: 380,
              height: 400.0,
              padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    autocorrect: true, // ?
                    controller: _documentIdController,
                    maxLength: 20,
                    autovalidate: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.book),
                      labelText:
                          "Please enter the teacher's nickname in lowercase letters.",
                      errorStyle:
                          TextStyle(fontSize: 15.0, color: Colors.deepOrange),
                      hintText: "Teachers documentID",
                      fillColor: Colors.greenAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    focusNode: documentIdFocus,
                    onFieldSubmitted: (v) {
                      // フォーム入力完了後、fullNameFocusにフォーカスを移す
                      FocusScope.of(context).requestFocus(fullNameFocus);
                    },
                    validator: (value) {
                      return value.isEmpty ? '必須入力です。' : null;
                    },
                    onSaved: (value) {
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
                    ),
                    focusNode: fullNameFocus,
                    onFieldSubmitted: (v) {
                      // フォーム入力完了後specialtyFocusにフォーカスを移す
                      FocusScope.of(context).requestFocus(specialtyFocus);
                    },
                    validator: (value) {
                      return value.isEmpty ? '必須入力です。' : null;
                    },
                    onSaved: (value) {
                      this._fullName = value;
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
                    ),
                    focusNode: specialtyFocus,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(ageFocus);
                    },
                    validator: (value) {
                      return value.isEmpty ? '必須入力です。' : null;
                    },
                    onSaved: (value) {
                      this._specialty = value;
                    },
                  ),
                  // 別途定義したTextFormFieldを呼び出し
                  ageFormField(context),
                ],
              ),
            ),
            Container(
              child: FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                disabledColor: Colors.blueGrey, // ?
                disabledTextColor: Colors.pink, // ?
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueGrey,
                onPressed: _submission,
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

  void _submission() {
    //　以下で全てのバリデーションが実行され、その結果が返される。
    if (_formKey.currentState.validate()) {
      // バリデーションが通ればスナックバーを表示
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text('更新しました。')));

      // このsave()を呼び出すまで各フォームのonSaved()に記述した処理は実行されない
      this._formKey.currentState.save();
      print('document: $_documentId $_fullName $_specialty $_teachersAge');
      Map<String, dynamic> data = {
        "full_name": _fullName,
        "specialty": _specialty,
        "age": _teachersAge,
      };
      setData('teachers', _documentId, data);

      // 後処理(不完全)
      _documentIdController.clear(); // フォームのdocumentID入力欄を空白に戻す
      _documentId = '';
      Navigator.popAndPushNamed(context, '/teachers');
    }
  }

  TextFormField ageFormField(BuildContext context) {
    return TextFormField(
      maxLength: 3,
      maxLengthEnforced: true,
      // キーボードタイプを指定。ここでは数字キーボードを表示
      // https://api.flutter.dev/flutter/services/TextInputType-class.html
      keyboardType: TextInputType.number, // 効果あるのか未確認
      // テキスト入力完了時の動作、ボタン見た目の指定
      textInputAction: TextInputAction.done,
      focusNode: ageFocus,
      onFieldSubmitted: (v) {
        // 年齢フォームからフォーカスを外し、キーボードをしまう
        ageFocus.unfocus();
      },
      validator: (value) {
        // 年齢が１６歳以上であるか確認
        if (value.length == 0 || int.parse(value) < 16) {
          return '年齢は１６歳以上である必要があります。';
        } else {
          return null;
        }
      },
      // フォームの装飾を定義
      decoration: InputDecoration(
        labelText: "年齢を入力してください。",
        hintText: '講師の年齢（１６歳以上）',
        icon: Icon(Icons.person_outline),
        fillColor: Colors.white,
      ),
      onSaved: (value) {
        _updateAge(int.parse(value));
      },
    );
  }
}
