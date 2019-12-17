import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/extraWidgets/combo.dart';

class CreateTask extends StatelessWidget {
  TextEditingController name_ctrl = new TextEditingController();
  TextEditingController description_ctrl = new TextEditingController();
  TextEditingValue duration;
  Task auxTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Task")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: name_ctrl,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: description_ctrl,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            Text('Stats'),
            ComboWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()
        {
          auxTask = new Task(name_ctrl.text, description_ctrl.text);
          Navigator.of(context).pop(auxTask);
        },
      ),
    );
  }
}
