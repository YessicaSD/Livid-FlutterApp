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
  TextEditingController number = TextEditingController();
  statType type = statType.ST_FUN;
  String errorText = "";

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
            Row(
              children: <Widget>[
                ComboWidget(type, null, null),
                Flexible(child: TextField(controller: number,keyboardType: TextInputType.number,decoration: InputDecoration(hintText: 'difficulty'),))
              ],
            ),
            Text(errorText, style: TextStyle(color: Colors.red))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (descriptionCtrl.text == "" &&
              nameCtrl.text == "" &&
              type == null) {
            setState(() {
              errorText = 'Error! Some parameter is empty!';
            });
            return;
          }

          auxTask = Task(nameCtrl.text, descriptionCtrl.text, statType.ST_FUN, int.parse(number.text));
          if (auxTask.name.isEmpty)
            Navigator.of(context).pop(null);
          else
            Navigator.of(context).pop(auxTask);
        },
      ),
    );
  }
}
