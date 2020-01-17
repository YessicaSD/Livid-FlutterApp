import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lividcode/baseClasses/stat.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/extraWidgets/combo.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  final statType type = statType.ST_FUN;

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
              controller: nameCtrl,
              decoration: InputDecoration(labelText: 'Name'),
              onSubmitted: (String value) async {
                setState(() {
                  nameCtrl.text = value;
                });
              },
            ),
            TextField(
              controller: descriptionCtrl,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            Text('Stats'),
            ComboWidget(type, null, null),
          ],
        ),
      ),
      floatingActionButton: /*(name_ctrl.text.isEmpty ? Container() : */ FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          auxTask = Task(nameCtrl.text, descriptionCtrl.text, type);
          if (auxTask.name.isEmpty)
            Navigator.of(context).pop(null);
          else
            Navigator.of(context).pop(auxTask);
        },
      ),
    );
  }
}
