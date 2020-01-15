import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/baseClasses/user.dart';
import 'package:provider/provider.dart';

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