import 'package:hive/hive.dart';

import '../../core/models/task_model.dart';

class TaskDatabase {
  void createTask(int id, TaskModel task) async {
    var database = Hive.box("user$id".toString());
    database.add(task.toMap());
  }

  List<TaskModel> getAllTasks(int id) {
    var database = Hive.box("user$id");

    List<dynamic> allTasksInDatabase = database.values.toList();

    List<TaskModel> tasks = <TaskModel>[];

    return tasks;
  }
}
