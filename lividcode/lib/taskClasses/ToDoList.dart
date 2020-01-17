import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/baseClasses/user.dart';
import 'package:lividcode/baseClasses/stat.dart';
import 'package:lividcode/mainScreen/EditTask.dart';

class ToDoList extends StatefulWidget {
  User user;
  ToDoList(this.user);
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    final User user = widget.user;
    TaskList _list = TaskList();
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users/' + widget.user.idUser + '/DoingTasks')
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

          return Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Text(
                    "To do list",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Divider(color: Colors.grey[700]),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      Task actualTask = _list.getTask(index);
                      return Card(
                        child: ListTile(
                          title: Text(actualTask.name),
                          subtitle: Text(statToString(actualTask.type)),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      EditTask(actualTask, user.idUser))),
                          trailing: FlatButton(
                            shape: StadiumBorder(),
                            color: Theme.of(context).buttonColor,
                            child: Text('Done'),
                            onPressed: () {
                              actualTask.finishedTime = Timestamp.now();
                              Firestore.instance
                                  .collection('users')
                                  .document(user.idUser)
                                  .collection('Stats')
                                  .document(statToString(actualTask.type))
                                  .get()
                                  .then((doc) {
                                int val = doc.data['value'];
                                if (doc.data['value'] + actualTask.difficult >
                                    doc.data['maxValue'])
                                  val = doc.data['maxValue'];
                                else
                                  val += actualTask.difficult;
                                doc.reference.updateData({
                                  'value':
                                      doc.data['value'] + actualTask.difficult
                                });
                              });
                              Firestore.instance
                                  .collection(
                                      'users/' + user.idUser + '/DoneTasks')
                                  .add(actualTask.toFirebase())
                                  .then((onValue) {});
                              Firestore.instance
                                  .document('users/' +
                                      user.idUser +
                                      '/DoingTasks/' +
                                      actualTask.id)
                                  .delete();
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: _list.length(),
                  ),
                )
              ],
            ),
          );
        });
  }
}
