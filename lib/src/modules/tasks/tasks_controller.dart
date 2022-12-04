import 'package:hive/hive.dart';

import '../../core/models/task_model.dart';
import '../../core/models/user_model.dart';
import '../../providers/user_provider.dart';

class TasksController {
  UserModel user = UserProvider.user;

  void addTask(TaskModel task) {
    var box = Hive.box(user.username!);
    box.put(task.id, task.toMap());
  }

  void deleteTask(TaskModel task) {
    var box = Hive.box(user.username!);
    box.delete(task.id);
  }

  void updateTask(TaskModel task, String title, String description) {
    var box = Hive.box(user.username!);
    task = task.copyWith(title: title, description: description);
    box.put(task.id, task.toMap());
  }

  List<TaskModel> getAllTasks() {
    var box = Hive.box(user.username!);
    var values = box.values;

    var tasks = <TaskModel>[];

    for (var element in values) {
      tasks.add(TaskModel.fromMap(Map<String, dynamic>.from(element)));
    }

    return tasks;
  }
}
