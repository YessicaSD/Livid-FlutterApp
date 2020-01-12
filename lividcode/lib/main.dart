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
            ),
          );
        });
  }
}

class MainSreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomeScreen")),
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
                    .CreateAddTask(value.name, value.description);
            }
          });
        },
      ),
      body: Column(
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
    );
  }
}

class ToDoList extends StatelessWidget {
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
                return TaskWidget(user.toDoList.getTask(index));
              },
              itemCount: user.toDoList.length(),
            ),
          )
        ],
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final Task actualTask;
  TaskWidget(this.actualTask);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Text(
          actualTask.name,
          style: TextStyle(fontSize: 15),
        ),
      )),
    );
  }
}
