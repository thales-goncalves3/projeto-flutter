// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/custom_notification.dart';
import '../../../core/models/task_model.dart';
import '../../../services/notifications_services/notification_service.dart';
import '../convert_date_controller.dart';
import '../tasks_controller.dart';

class TaskPageAndroid extends StatefulWidget {
  TaskModel task;
  List<String> dropOptions;
  final dynamic removeTask;
  final dynamic chooseColor;

  TaskPageAndroid({
    Key? key,
    required this.task,
    required this.dropOptions,
    this.removeTask,
    this.chooseColor,
  }) : super(key: key);

  @override
  State<TaskPageAndroid> createState() => _TaskPageAndroidState();
}

class _TaskPageAndroidState extends State<TaskPageAndroid> {
  TasksController controller = TasksController();
  bool notify = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: widget.chooseColor(widget.task),
          boxShadow: [
            BoxShadow(
              color: widget.chooseColor(widget.task),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start: ${ConvertDate.toDate(widget.task.from!)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    Text(
                      "Finish: ${ConvertDate.toDate(widget.task.to!)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.3,
              //   child: DropdownButton(
              //     hint: const Text("State of task"),
              //     value: widget.task.status,
              //     items: widget.dropOptions
              //         .map((e) => DropdownMenuItem(
              //               value: e,
              //               child: Text(e),
              //             ))
              //         .toList(),
              //     onChanged: (val) {
              //       setState(() {
              //         controller.updateStatus(widget.task, val!);
              //         widget.removeTask();
              //       });
              //     },
              //   ),
              // ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      notify = !notify;
                    });

                    Provider.of<NotificationService>(context, listen: false)
                        .showNotificationScheduled(
                            CustomNotification(
                                id: widget.task.id,
                                title: widget.task.title!,
                                body: widget.task.description!,
                                payload: "tasks_page"),
                            const Duration(seconds: 5));
                  },
                  icon: notify
                      ? const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.notifications_off_outlined,
                          color: Colors.white,
                        )),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("/update_task_page", arguments: widget.task);
                },
                icon: const Icon(
                  Icons.update,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () async {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete task"),
                          content: const Text(
                              "Are you sure that you wish remove this task?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    controller.deleteTask(widget.task);
                                    widget.removeTask();
                                    Navigator.of(context).pop();
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text("Task deleted"),
                                      backgroundColor:
                                          Color.fromRGBO(6, 12, 34, 1),
                                    ),
                                  );
                                },
                                child: const Text("DELETE")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("CANCEL")),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
