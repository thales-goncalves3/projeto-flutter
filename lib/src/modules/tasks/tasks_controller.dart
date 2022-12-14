import 'package:basic_form/src/modules/tasks/meeting_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/models/meeting_model.dart';
import '../../core/models/task_model.dart';
import '../../core/models/user_model.dart';
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

  // void updateStatus(TaskModel task, String value) async {
  //   var box = Hive.box(user.username!);
  //   task = task.copyWith(status: value);
  //   await box.put(task.id, task.toMap());
  // }

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
      task.importance == "No urgency"
          ? color = Colors.green
          : task.importance == "For tomorrow"
              ? color = const Color.fromARGB(255, 242, 220, 27)
              : color = Colors.red;

      meetings.add(MeetingModel(
          eventName: task.title!,
          from: DateTime(task.from!.year, task.from!.month, task.from!.day),
          to: DateTime(task.to!.year, task.to!.month, task.to!.day),
          background: color,
          isAllDay: false));
    }

    return meetings;
  }

  void showAppointment(BuildContext context, List<TaskModel> tasks) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("Your Appointments"),
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width,
                  child: SfCalendar(
                    view: CalendarView.month,
                    dataSource: MeetingDataSource(getMeetings(tasks)),
                    monthViewSettings:
                        const MonthViewSettings(showAgenda: true),
                  ),
                ),
              )
            ],
          );
        });
  }
}
