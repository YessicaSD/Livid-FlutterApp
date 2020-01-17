import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/task.dart';
import 'package:lividcode/baseClasses/user.dart';

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
                                  setState(() {});
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
