import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/baseClasses/user.dart';
import 'package:lividcode/info/defs.dart';
import 'package:lividcode/mainScreen/AddTask.dart';
import 'package:lividcode/mainScreen/profile.dart';
import 'package:lividcode/taskClasses/ToDoList.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  final String id;
  MainPage(this.id);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User user;
  bool loaded = false;
  _MainPageState()
      : user = null,
        loaded = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.document('users/' + widget.id).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
          if (!loaded) {
            DocumentSnapshot doc = snapshot.data;
            user = User.defaultStats();
            user.fromFirestore(doc).then((val) {
              setState(() {
                loaded = true;
              });
            });
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Provider<User>.value(
              value: user,
              child: MainSreen(),
            );
          }
        });
  }
}

class MainSreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomeScreen"),
          bottom: TabBar(
            tabs: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("To do List"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Done List"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (_) => AddTask(Provider.of<User>(context)),
              ),
            )
                .then((value) {
              if (value != null) {
                if (!Provider.of<User>(context).toDoList.isInTaskList(value)) {
                  Task new_task = new Task(value.name, value.description);
                  Firestore.instance
                      .collection('users/' +
                          Provider.of<User>(context).idUser +
                          '/DoingTasks')
                      .add(new_task.ToFirebase());
                }
              }
            });
          },
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: Colors.deepPurple[200],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProfileWidget(),
                  ),
                ),
                Expanded(child: ToDoList()),
                Divider(color: Colors.grey[700]),
              ],
            ),
            DoneList(Provider.of<User>(context)),
          ],
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }

  Future saveCustomTask(String path, Task new_task) async {
    await Firestore.instance
        .collection('users/$path/CustomTasks')
        .add(new_task.ToFirebase());
  }
}

class DoneList extends StatelessWidget {
  final User user;
  DoneList(this.user);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: user.doneList.length(),
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index){
        return ListTile(title: Text(user.doneList.getTask(index).name),);
      },
    );
  }
}
