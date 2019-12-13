import 'package:lividcode/baseClasses/stat.dart';
import 'package:lividcode/baseClasses/task.dart';

class User {
  String name;
  String imagePath;
  StatList stats;
  TaskList toDoList;

  User(this.name, this.imagePath, this.stats, this.toDoList);

  factory User.userStart()
  {
    return new User("Alex", "njdns", StatList.statListStart(), TaskList.tryTaskList());
  }

  Stat getStat(int type)
  {
    return stats.getStat(type);
  }

}
