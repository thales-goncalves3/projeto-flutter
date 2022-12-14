import 'dart:convert';

import 'package:basic_form/src/modules/tasks/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/task_model.dart';
import '../../core/models/user_model.dart';
import '../../services/notifications_services/notification_service.dart';
import '../../services/providers/user_provider.dart';
import 'android_tasks/task_page_android.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  UserModel user = UserProvider.user;
  late List<TaskModel> tasks;

  TasksController controller = TasksController();
  bool notify = false;
  late final NotificationService service;
  List<bool> isExpandedList = <bool>[];
  List<bool> isCheckedList = <bool>[];

  late Colors color;
  final dropOptions = ["Finished", "Not finished", "In progress"];
  @override
  void initState() {
    checkNotifications();
    tasks = controller.getAllTasks();
    for (var i = 0; i < tasks.length; i++) {
      isExpandedList.add(false);
      isCheckedList.add(false);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      tasks = controller.getAllTasks();
    });

    return Scaffold(
        backgroundColor: const Color.fromRGBO(81, 16, 62, 1),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/create_task");
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Here are your tasks, ${user.username}!"),
          actions: [
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  controller.showAppointment(context, tasks);
                },
                icon: const Icon(Icons.calendar_month_outlined)),
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
                icon: const Icon(Icons.exit_to_app)),
          ],
        ),
        body: tasks.isEmpty
            ? Center(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/no-tasks.png",
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ))
            : SingleChildScrollView(
                child: ExpansionPanelList(
                  animationDuration: const Duration(milliseconds: 800),
                  dividerColor: Colors.white,
                  expansionCallback: (int panelIndex, bool isExpanded) async {
                    setState(() {
                      isExpandedList[panelIndex] = !isExpanded;
                    });
                  },
                  children: tasks.asMap().entries.map((
                    task,
                  ) {
                    return ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: chooseColor(task.value),
                        isExpanded: isExpandedList[task.key],
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListTile(
                              trailing: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.white,
                                ),
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor:
                                      const Color.fromRGBO(81, 16, 62, 1),
                                  value: task.value.checked,
                                  onChanged: (value) {
                                    setState(() {
                                      isCheckedList[task.key] = value!;

                                      controller.updateCheckBox(
                                          task.value, value);
                                    });
                                  },
                                ),
                              ),
                              title: Text(
                                task.value.title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                task.value.description!,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                        body: TaskPageAndroid(
                          task: task.value,
                          dropOptions: dropOptions,
                          removeTask: removeTask,
                          chooseColor: chooseColor,
                        ));
                  }).toList(),
                ),
              ));
  }

  void removeTask() {
    setState(() {
      tasks = controller.getAllTasks();
    });
  }

  void checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotifications();
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
}
