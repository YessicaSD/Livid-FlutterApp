import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/stat.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/extraWidgets/combo.dart';

class EditTask extends StatelessWidget {
  Task task;
  String user;
  TextEditingController name;
  TextEditingController description;
  statType type;

  EditTask(this.task, this.user)
      : name = TextEditingController(text: task.name),
        description = TextEditingController(text: task.description),
        type = task.type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: name,
            ),
            TextField(
              controller: description,
              maxLines: 4,
            ),
            ComboWidget(type, user, task.id),
            SizedBox(height: 50,),
            RaisedButton(
              onPressed: () {
                return Firestore.instance.collection('users').document(user).collection('DoingTasks').document(task.id).delete().then((val){
                  Navigator.of(context).pop();
                });
              },
              child: Text('Delete',style: TextStyle(color: Colors.white),),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
