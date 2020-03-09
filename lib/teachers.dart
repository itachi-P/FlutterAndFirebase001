import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'teachers_update.dart';

class Teachers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<Teachers> {
  var _selectedMenu = '';
  final _popupMenuContent = ["modify", "delete"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Katachi Teachers')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 削除機能は画面遷移せずに完結するUIに
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return TeachersUpdate();
              },
            ),
          );
        },
        tooltip: 'Teachers Add',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('teachers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.full_name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: Text(record.document_id),
          title: Text(record.full_name),
          subtitle: Text(record.specialty),
          trailing: PopupMenuButton<String>(
            initialValue: _selectedMenu,
            onSelected: (String selected) {
              setState(() {
                _selectedMenu = selected;
                if (_selectedMenu == "modify") {
                  // TODO 3.下記をデータ修正(=値入り新規登録画面)への遷移に改修
                  updateData('teachers', data);
                } else if (_selectedMenu == "delete") {
                  deleteData('teachers', record.document_id);
                }
              });
            },
            tooltip: 'メニューを表示します',
            itemBuilder: (BuildContext context) {
              return _popupMenuContent.map((String menuContent) {
                var menuLabel = menuContent;
                if (menuContent == "modify") {
                  menuLabel = "修正";
                } else if (menuContent == "delete") {
                  menuLabel = "削除";
                }
                return PopupMenuItem(
                  child: Text(menuLabel),
                  value: menuContent,
                  height: 30.0,
                );
              }).toList();
            },
          ),
          //onTap: () => record.reference.updateData({'votes': record.votes + 1}),
        ),
      ),
    );
  }
}

class Record {
  final String document_id;
  final String full_name;
  final String specialty;
  //final int age;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(reference.documentID != null),
        assert(map['full_name'] != null),
        assert(map['specialty'] != null),
        document_id = reference.documentID,
        full_name = map['full_name'],
        specialty = map['specialty'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

void deleteData(String collectionName, String documentId) {
  Firestore.instance.collection(collectionName).document(documentId).delete();
}

// このメソッドを以下のように変更する。
// データを更新するロジック自体は遷移先の画面(teachers_update)の中で別メソッドとして用意
// 選択（タップ）した行のドキュメントIDを含むデータを「講師追加登録」画面に渡して遷移
// 前のページから受け取った該当行のデータを講師追加登録用の各フォームに初期値として入れる
void updateData(String collectionName, DocumentSnapshot documentSnapshot) {
  //Firestore.instance.collection(collectionName).document(documentSnapshot.documentID).get();
  Map record = documentSnapshot.data;
  print(record);
}
