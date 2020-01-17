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
  TextEditingController dif;
  statType type;

  EditTask(this.task, this.user)
      : name = TextEditingController(text: task.name),
        description = TextEditingController(text: task.description),
        dif = TextEditingController(text: task.difficult.toString()),
        type = task.type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task2'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              return Firestore.instance
                  .collection('users')
                  .document(user)
                  .collection('DoingTasks')
                  .document(task.id)
                  .delete()
                  .then((val) {
                Navigator.of(context).pop();
              });
            },
            icon: Icon(Icons.delete),
          )
        ],
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
            Row(
              children: <Widget>[
                ComboWidget(type, user, task.id),
                Flexible(
                  child: TextField(
                    controller: dif,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'dificulty'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: () {
                Firestore.instance
                    .document('users/$user/DoingTasks/${task.id}')
                    .setData(
                        Task(name.text, description.text, type, int.parse(dif.text)).toFirebase());
                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
            )
          ],
        ),
      ),
    );
  }
}
