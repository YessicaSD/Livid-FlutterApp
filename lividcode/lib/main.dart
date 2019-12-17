import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/user.dart';
import 'package:lividcode/mainScreen/AddTask.dart';
import 'package:provider/provider.dart';
import 'baseClasses/task.dart';
import 'mainScreen/profile.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  User user = User.userStart();

  @override
  Widget build(BuildContext context) {
    return Provider<User>.value(
      value: user,
      child: MaterialApp(
        theme: ThemeData(primaryColor: Color.fromRGBO(47, 44, 66, 1.0)),
        home: MainSreen(),
      ),
    );
  }
}

class MainSreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomeScreen")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddTask()));
        },
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.orange, // TODO: poned el que querais
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
          Text("ToDoList"),
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
      child: Text(actualTask.name),
    );
  }
}
