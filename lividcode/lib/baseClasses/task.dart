import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String name;
  String description;
  Float startTime, endTime, duration;
  bool done = false;
  Task(this.name, this.description);
  Task.fromFirestore(DocumentSnapshot doc)
      : name = doc.data['name'],
        description = doc.data['description'];
}

List<Task> ToTaskList(QuerySnapshot query) {
  return query.documents.map((doc) => Task.fromFirestore(doc)).toList();
}

class TaskList {
  List<Task> taskList = List<Task>();

  TaskList();
  TaskList.fromList(this.taskList);

  factory TaskList.startTaskList() {
    return TaskList.fromList(List<Task>());
  }

  factory TaskList.tryTaskList() {
    List<Task> auxList = List<Task>();
    auxList.add(Task("Hamburguesa", "La madre que me parió"));
    auxList.add(Task("Tennis", "La madre ha sido asesinado"));
    return TaskList.fromList(auxList);
  }

  bool isInTaskList(Task t) {
    for (var i in taskList) {
      if (i.name == t.name && i.description == t.description) return true;
    }
    return false;
  }

  void CreateAddTask(String name, String description) {
    taskList.add(Task(name, description));
  }

  void addTask(Task newTask) {
    taskList.add(newTask);
  }

  void addTaskFromTask(Task t) {
    taskList.add(t);
  }

  Task getTask(int i) {
    return taskList[i];
  }

  int length() {
    return taskList.length;
  }
}
