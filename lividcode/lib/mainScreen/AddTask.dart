import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/info/defs.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TaskList _list = TaskList();

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
      _list.addTask(i['name'], i['description']);
    }

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: mainColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddTask(),
              //builder: (_) => CreateTask(),
            ),
          );
        },
      ),
      body: ListView.builder(
        itemCount: _list.length(),
        itemBuilder: (context, i){
          return ListTile(
            onTap: () {
              Navigator.of(context).pop(_list.getTask(i));
            },
            title: Text(_list.getTask(i).name),
            subtitle: Text(_list.getTask(i).description),
          );
        },
      ),
    );
  }
}
