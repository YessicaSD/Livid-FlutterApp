import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/info/defs.dart';
import 'package:lividcode/taskClasses/taskCreate.dart';
import 'package:lividcode/baseClasses/user.dart';
import 'package:lividcode/baseClasses/stat.dart';

class AddTask extends StatefulWidget {
  User user;

  AddTask(this.user);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TaskList _list = TaskList();
  TaskList costumTasksList = TaskList();

  bool loaded = false;
  @override
  void initState() {
    _loadExamples();
    super.initState();
  }

  Future<void> _loadExamples() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('lib/info/tasksExamples.json');
    var _jsonTasks = jsonDecode(data);

    for (var i in _jsonTasks['Tasks']) {
      costumTasksList.createAddTask(
          i['name'], i['description'], statFromString(i['type']));
    }

    super.setState(() {});
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users/' + widget.user.idUser + '/CustomTasks')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(backgroundColor: Colors.red),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> docs = snapshot.data.documents;
          _list.taskList.clear();
          _list.taskList = new List<Task>.from(costumTasksList.taskList);
          for (var task in docs) {
            _list.addTask(Task.fromFirestore(task));
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Add Task'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.edit),
              backgroundColor: mainColor,
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (_) => CreateTask(),
                  ),
                )
                    .then((task) {
                  if (task != null) {
                    String userID = widget.user.idUser;
                    Task newTask = task;
                    Firestore.instance
                        .collection('users/$userID/CustomTasks')
                        .add(newTask.toFirebase());
                  }
                });
              },
            ),
            body: ListView.separated(
                itemCount: _list.length(),
                itemBuilder: (context, i) {
                  return ListTile(
                      onTap: () {
                        Navigator.of(context).pop(_list.getTask(i));
                      },
                      title: Text(_list.getTask(i).name),
                      subtitle: Text(_list.getTask(i).description),
                      trailing: Text(statToString(_list.getTask(i).type)),
                      onLongPress: () => _buildShowDialog(context, i));
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                  );
                }),
          );
        });
  }

  Future _buildShowDialog(BuildContext context, int i) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Firestore.instance
                      .document('users/' +
                          widget.user.idUser +
                          '/CustomTasks/' +
                          _list.getTask(i).id)
                      .delete();
                  Navigator.of(context).pop();
                },
                child: Text('DELETE', style: TextStyle(color: Colors.red))),
            FlatButton(
              child: Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
