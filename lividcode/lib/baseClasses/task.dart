import 'dart:ffi';

class Task {
  String name;
  String description;
  Float startTime, endTime, duration;

  Task(this.name, this.description);
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

  void addTask(String name, String description) {
    taskList.add(Task(name, description));
  }

  Task getTask(int i) {
    return taskList[i];
  }

  int length() {
    return taskList.length;
  }
}
