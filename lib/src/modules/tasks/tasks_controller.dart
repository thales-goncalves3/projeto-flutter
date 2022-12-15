import 'package:basic_form/src/modules/tasks/meeting_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/models/meeting_model.dart';
import '../../core/models/task_model.dart';
import '../../core/models/user_model.dart';
import '../../services/notifications_services/notification_service.dart';
import '../../services/providers/user_provider.dart';

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

  void updateCheckBox(TaskModel task, bool value) async {
    var box = Hive.box(user.username!);
    task = task.copyWith(checked: value);
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

  List<MeetingModel> getMeetings(List<TaskModel> tasks) {
    List<MeetingModel> meetings = <MeetingModel>[];
    Color? color;

    for (var task in tasks) {
      color = chooseColor(task);

      meetings.add(MeetingModel(
          eventName: task.title!,
          from: DateTime(task.from!.year, task.from!.month, task.from!.day),
          to: DateTime(task.to!.year, task.to!.month, task.to!.day),
          background: color,
          isAllDay: false));
    }

    return meetings;
  }

  Color chooseColor(TaskModel task) {
    if (task.checked) {
      return const Color.fromRGBO(128, 128, 128, 1);
    } else {
      return task.importance == "No urgency"
          ? const Color.fromRGBO(16, 81, 51, 1)
          : task.importance == "For tomorrow"
              ? const Color.fromRGBO(16, 63, 81, 1)
              : const Color.fromRGBO(81, 16, 46, 1);
    }
  }

  void checkNotifications(BuildContext context) async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotifications();
  }
}
