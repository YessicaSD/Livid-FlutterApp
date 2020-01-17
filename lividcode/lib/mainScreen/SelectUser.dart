import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/mainScreen/AddUser.dart';
import 'package:lividcode/mainScreen/MainPage.dart';

class SelectUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddUser())),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () { 
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MainPage(docs[index].documentID)));
                  },
                  title: Text(docs[index].data['name']),
                  subtitle: Text(docs[index].documentID),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
