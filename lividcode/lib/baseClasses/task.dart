import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lividcode/baseClasses/stat.dart';

class Task {
  String name;
  String description;
  Float endTime;
  bool done = false;
  DateTime dateTime;
  statType type;
  int difficult = 1;
  String id;
  DateTime finishedTime, startTime;
  Duration duration;
  bool startTimer = false;

  Task(this.name, this.description, this.type);

  Task.fromFirestore(DocumentSnapshot doc)
      : name = doc.data['name'],
        description = doc.data['description'],
        id = doc.documentID,
        type = statFromString(doc.data['type']),
        startTimer =
            (doc.data['startTimer'] != null) ? doc.data['startTimer'] : false {
    if (doc.data['finishedTime'] != null) {
      finishedTime = (doc.data['finishedTime'] as Timestamp).toDate();
    }
    if (doc.data['startTime'] != null) {
      startTime = (doc.data['startTime'] as Timestamp).toDate();
    }
    if (doc.data['durationH'] != null &&
        doc.data['durationM'] != null &&
        doc.data['durationS'] != null) {
      duration = new Duration(
        hours: doc.data['durationH'],
        minutes: doc.data['durationM'],
        seconds: doc.data['durationS'],
      );
    }
  }

  Map<String, dynamic> toFirebase() => {
        'name': name,
        'description': description,
        'type': type.toString(),
        'finishedTime': finishedTime,
        'startTimer': startTimer,
        'startTime': startTime,
        'durationH': duration.inHours,
        'durationM': duration.inMinutes,
        'durationS': duration.inSeconds,
      };

  String get finishedDate =>
      '${finishedTime.day}/${finishedTime.month}/${finishedTime.year} - ${finishedTime.hour}:${finishedTime.minute}';
}

List<Task> toTaskList(QuerySnapshot query) {
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
    auxList.add(Task("Hamburguesa", "La madre que me parió", statType.ST_FUN));
    auxList.add(Task("Tennis", "La madre ha sido asesinado", statType.ST_FUN));
    return TaskList.fromList(auxList);
  }

  bool isInTaskList(Task t) {
    for (var i in taskList) {
      if (i.name == t.name && i.description == t.description) return true;
    }
    return false;
  }

  void createAddTask(String name, String description, statType type) {
    taskList.add(Task(name, description, type));
  }

  void addTask(Task newTask) {
    taskList.add(newTask);
  }

  void removeTask(int index) {
    taskList.removeAt(index);
  }

  Task getTask(int i) {
    return taskList[i];
  }

  int length() {
    return taskList.length;
  }
}
