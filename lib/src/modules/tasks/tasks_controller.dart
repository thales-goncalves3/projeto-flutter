import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/models/task_model.dart';
import '../../core/models/user_model.dart';
import '../../providers/user_provider.dart';

class TasksController {
  UserModel user = UserProvider.user;

  void addTask(TaskModel task) async {
    var box = Hive.box(user.username!);
    await box.put(task.id, task.toMap());
  }

  void deleteTask(TaskModel task) async {
    var box = Hive.box(user.username!);
    await box.delete(task.id);
  }

  void updateTask(TaskModel task, String title, String description) async {
    var box = Hive.box(user.username!);
    task = task.copyWith(title: title, description: description);
    await box.put(task.id, task.toMap());
  }

  void updateStatus(TaskModel task, String value) async {
    var box = Hive.box(user.username!);
    task = task.copyWith(status: value);
    await box.put(task.id, task.toMap());
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

  Future<DateTime?> pickDateTime(BuildContext context, DateTime initialDate,
      bool pickDate, DateTime? firstDate) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));

      if (date == null) {
        return null;
      }

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    }
    return null;
  }
}
