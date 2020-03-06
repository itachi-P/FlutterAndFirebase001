import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'teachers_update.dart';

class Teachers extends StatefulWidget {
  @override
  _TeachersState createState() {
    return _TeachersState();
  }
}

class _TeachersState extends State<Teachers> {
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
          leading: Text("講師"),
          subtitle: Text(record.document_id),
          title: Text(record.full_name),
          trailing: Text(record.specialty),
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
