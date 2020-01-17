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
    var _jsonGames = jsonDecode(data);

    for (var i in _jsonGames['Tasks']) {
      costumTasksList.createAddTask(i['name'], i['description'], statFromString(i['type']));
    }
    // if (widget.user.costumTasks != null) {
    //   for (var task in widget.user.costumTasks) {
    //     _list.addTask(task);
    //   }
    // }

    try {
      /*Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/fav.json');
      String fileContents = await file.readAsString();
      dynamic jsonFav = jsonDecode(fileContents);
      for(var i in jsonFav){
        _favourites[i['name']] = i['fav'];
      }*/
    } catch (e) {
      print(e.toString());
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
            _list.createAddTask(task['name'], task['description'], statFromString(task['type']));
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
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                  );
                }),
          );
        });
  }
}
