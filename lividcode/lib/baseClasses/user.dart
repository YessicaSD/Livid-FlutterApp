import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lividcode/baseClasses/stat.dart';
import 'package:lividcode/baseClasses/task.dart';

class User {
  String name;
  String imagePath;
  StatList stats;
  TaskList toDoList;
  List<Task> costumTasks;

  User(this.name, this.imagePath, this.stats, this.toDoList);

  User.fromFirestore(DocumentSnapshot doc)
      : name = doc.data['name'],
        imagePath = doc.data['imagePath'],
        stats = StatList.fromFirebase(doc.reference.collection('Stats')),
        toDoList = TaskList.tryTaskList() {
    doc.reference.collection('CustomTasks').getDocuments().then((val) {
      if (val != null) costumTasks = toTaskList(val);
    });
  }

  factory User.userStart() {
    return new User(
        "Alex", "njdns", StatList.statListStart(), TaskList.tryTaskList());
  }

  Stat getStat(int type) {
    return stats.getStat(type);
  }
}
