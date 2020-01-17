import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lividcode/baseClasses/stat.dart';
import 'package:lividcode/baseClasses/task.dart';

class User {
  String idUser;
  String name;
  String imagePath;
  StatList stats;
  TaskList toDoList;
  List<Task> costumTasks;

  User(this.idUser, this.name, this.imagePath, this.stats, this.toDoList);

  User.defaultStats()
      : name = 'name',
        imagePath = 'null',
        stats = StatList(List<Stat>()),
        toDoList = TaskList.startTaskList();

  Future<void> fromFirestore(DocumentSnapshot doc) async {
    idUser = doc.documentID;
    name = doc.data['name'];
    imagePath = doc.data['imagePath'];
    await stats.fromFirebase(doc.reference.collection('Stats')).then((onValue) {
      doc.reference
          .collection('CustomTasks')
          .getDocuments()
          .then((QuerySnapshot val) {
        if (val != null) costumTasks = toTaskList(val);
      });
    });
    print('ya he acabado eh');
  }

  factory User.userStart() {
    return new User("alex2521999@gmail.com", "Alex", "njdns",
        StatList.statListStart(), TaskList.tryTaskList());
  }

  Stat getStat(int type) {
    return stats.getStat(type);
  }
}
