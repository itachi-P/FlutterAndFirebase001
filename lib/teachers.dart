import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'teachers_update.dart';

class Teachers extends StatefulWidget {
  @override
  _TeachersState createState() {
    return _TeachersState();
  }
}

// This is the type used by the popup menu below.
enum RowMenu { update, delete }

class _TeachersState extends State<Teachers> {
  var _selection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Katachi Teachers')),
      body: _buildBody(context, _selection),
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

  Widget _buildBody(BuildContext context, var _selection) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('teachers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents, _selection);
      },
    );
  }

  Widget _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot, var _selection) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot
          .map((data) => _buildListItem(context, data, _selection))
          .toList(),
    );
  }

  Widget _buildListItem(
      BuildContext context, DocumentSnapshot data, var _selection) {
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
          leading: Text("講師"),
          title: Text("${record.document_id} ${record.full_name}"),
          subtitle: Text(record.specialty),
          trailing: PopupMenuButton<RowMenu>(
            onSelected: (RowMenu result) {
              setState(() {
                _selection = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<RowMenu>>[
              const PopupMenuItem<RowMenu>(
                value: RowMenu.update,
                child: Text('更新'),
              ),
              const PopupMenuItem<RowMenu>(
                value: RowMenu.delete,
                child: Text('削除'),
              ),
            ],
            tooltip: "Modify or Delete the data in this row.",
            enabled: true,
            //initialValue: RowMenu.update,
            elevation: 15.0, // Controls the size of the shadow below the menu
          ),
          //onTap: () => record.reference.updateData({}),
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
