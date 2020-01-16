import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/user.dart';
import 'package:lividcode/info/defs.dart';
import 'package:lividcode/mainScreen/AddTask.dart';
import 'package:lividcode/mainScreen/profile.dart';
import 'package:lividcode/taskClasses/ToDoList.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  final String id;
  MainPage(this.id);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .document('users/' + id)
            .snapshots(),
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
          DocumentSnapshot doc = snapshot.data;
          // User user = User.userStart();
          User user = User.fromFirestore(doc);
          return Provider<User>.value(
            value: user,
            child: MainSreen(),
          );
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
              Text("To do List"),
              Text("Done List"),
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
                builder: (_) => AddTask(),
              ),
            )
                .then((value) {
              if (value != null) {
                if (!Provider.of<User>(context).toDoList.isInTaskList(value))
                  Provider.of<User>(context)
                      .toDoList
                      .createAddTask(value.name, value.description);
              }
            });
          },
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: Colors.grey[600], // TODO: poned el que querais
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProfileWidget(),
                  ),
                ),
                Expanded(child: ToDoList()),
              ],
            ),
            Text("Done List"),
          ],
        ),
      ),
    );
  }
}