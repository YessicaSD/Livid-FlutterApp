import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/user.dart';
import 'package:lividcode/info/defs.dart';
import 'package:lividcode/mainScreen/AddTask.dart';
import 'package:provider/provider.dart';
import 'baseClasses/task.dart';
import 'mainScreen/profile.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .document('users/alex2521999@gmail.com')
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
            child: MaterialApp(
              theme: ThemeData(primaryColor: Color.fromRGBO(47, 44, 66, 1.0)),
              home: MainSreen(),
              initialRoute: '/',
              routes: {},
            ),
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

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "To do list",
              style: TextStyle(fontSize: 17),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                Task actualTask = user.toDoList.getTask(index);
                return Container(
                  child: Card(
                      child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          actualTask.name,
                          style: TextStyle(fontSize: 15),
                        ),
                        Checkbox(
                          value: actualTask.done,
                          onChanged: (value) {
                            setState(() {
                              actualTask.done = value;
                              if (actualTask.done) {
                                Timer(Duration(milliseconds: 500), () {
                                  setState(() {
                                    Provider.of<User>(context)
                                        .toDoList
                                        .removeTask(index);
                                  });
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )),
                );
              },
              itemCount: user.toDoList.length(),
            ),
          )
        ],
      ),
    );
  }
}
