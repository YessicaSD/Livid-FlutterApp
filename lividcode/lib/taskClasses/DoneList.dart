import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/stat.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/baseClasses/user.dart';

class DoneList extends StatelessWidget {
  final User user;
  TaskList _list = TaskList();
  DoneList(this.user);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users/' + user.idUser + '/DoneTasks')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          _list.taskList.clear();
          for (var task in docs) {
            _list.addTask(Task.fromFirestore(task));
          }

          return ListView.separated(
            itemCount: _list.length(),
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              Task currentTask = _list.getTask(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(currentTask.name),
                    subtitle: Text(statToString(currentTask.type)),
                    trailing: Text(currentTask.finishedDate),
                  ),
                ),
              );
            },
          );
        });
  }
}
