import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lividcode/baseClasses/stat.dart';
import 'package:lividcode/baseClasses/task.dart';

class User {
  String name;
  String imagePath;
  StatList stats;
  TaskList toDoList;

  User(this.name, this.imagePath, this.stats, this.toDoList);

  User.fromFirestore(DocumentSnapshot doc)
      : name = doc.data['name'],
        imagePath = doc.data['imagePath'],
        stats = StatList.statListStart(),
        toDoList = TaskList.tryTaskList();

  factory User.userStart() {
    return new User(
        "Alex", "njdns", StatList.statListStart(), TaskList.tryTaskList());
  }

  Stat getStat(int type) {
    return stats.getStat(type);
  }
}
