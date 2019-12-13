import 'dart:ffi';

class Task{
  String name;
  String description;
  Float startTime, endTime, duration;

  Task(this.name, this.description);
}

class TaskList{
  List<Task> taskList = new List<Task>();

  TaskList(this.taskList);

  factory TaskList.startTaskList()
  {
    return new TaskList(new List<Task>());
  }

  factory TaskList.tryTaskList()
  {
    List<Task> auxList = new List<Task>();
    auxList.add(new Task("Hamburguesa", "La madre que me parió"));
    auxList.add(new Task("Tennis", "La madre ha sido asesinado"));
    return new TaskList(auxList);
  }

  void addTask(String name, String description)
  {
    taskList.add(new Task(name, description));
  }

  Task getTask(int i)
  {
    return taskList[i];
  }


  int length()
  {
    return taskList.length;
  }
}