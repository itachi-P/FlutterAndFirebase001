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
  var _selectedMenu = 'modify';
  var _popupMenuContent = ["modify", "delete"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Katachi Teachers')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // できれば画面遷移せずに追加登録・削除できるUIにしたい
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
                  record.reference.updateData(
                      {'specialty': record.specialty.toUpperCase()});
                  // TODO 2.下記を画面遷移無しで当該データ削除に改修
                } else if (_selectedMenu == "delete") {
                  record.reference.updateData(
                      {'specialty': record.specialty.toLowerCase()});
                }
              });
            },
            tooltip: 'メニューを表示します',
            itemBuilder: (BuildContext context) {
              return _popupMenuContent.map((String menuContent) {
                var menuLavel = menuContent;
                if (menuContent == "modify") {
                  menuLavel = "修正";
                } else if (menuContent == "delete") {
                  menuLavel = "削除";
                }
                return PopupMenuItem(
                  child: Text(menuLavel),
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
/*
  @override
  String toString() => "Record<$full_name:$number>;
   */
}
