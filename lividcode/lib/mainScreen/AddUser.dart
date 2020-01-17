import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/stat.dart';

class AddUser extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add User')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (name.text.isNotEmpty && email.text.isNotEmpty) {
            Firestore.instance
                .collection('users')
                .document('${email.text}')
                .setData({
              'name': name.text,
              'imagePath':
                  'https://firebasestorage.googleapis.com/v0/b/livid-cd312.appspot.com/o/AhcCOt1Q_400x400.png?alt=media&token=45669dc1-4f51-496b-b6ce-133a12e3dcb4'
            }).then((val) {
              for (var stats in statType.values) {
                if (stats != statType.ST_MAX)
                  Firestore.instance
                      .collection('users')
                      .document('${email.text}')
                      .collection('Stats')
                      .document(statToString(stats))
                      .setData({'maxValue': 50, 'value': 10});
              }
              Navigator.of(context).pop();
            });
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'email'),
            )
          ],
        ),
      ),
    );
  }
}
