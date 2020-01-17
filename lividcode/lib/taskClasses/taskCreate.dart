import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/extraWidgets/combo.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController descriptionCtrl = new TextEditingController();

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
                  // await showDialog<void>(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     // return AlertDialog(
                  //     //   title: const Text('Thanks!'),
                  //     //   content: Text('You typed "$value".'),
                  //     //   actions: <Widget>[
                  //     //     FlatButton(
                  //     //       onPressed: () {
                  //     //         Navigator.pop(context);
                  //     //       },
                  //     //       child: const Text('OK'),
                  //     //     ),
                  //     //   ],
                  //     // );
                  //   },
                  // );
                },
              ),
              TextField(
                controller: descriptionCtrl,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              Text('Stats'),
              ComboWidget(),
            ],
          ),
        ),
        floatingActionButton: /*(name_ctrl.text.isEmpty ? Container() : */ FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            auxTask = new Task(nameCtrl.text, descriptionCtrl.text);
            if (auxTask.name.isEmpty)
              Navigator.of(context).pop(null);
            else
              Navigator.of(context).pop(auxTask);
          },
        ) /*)*/
        );
  }
}
