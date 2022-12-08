import 'package:basic_form/src/core/models/meeting_model.dart';
import 'package:basic_form/src/modules/tasks/convert_date_controller.dart';
import 'package:basic_form/src/modules/tasks/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/models/task_model.dart';
import '../../core/models/user_model.dart';
import '../../providers/user_provider.dart';
import 'meeting_data_source.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  UserModel user = UserProvider.user;
  late List<TaskModel> tasks;
  TasksController controller = TasksController();

  final dropOptions = ["Finished", "Not finished", "In progress"];
  @override
  void initState() {
    tasks = controller.getAllTasks();
    super.initState();
  }

  void showAppointment() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("Your Appointments"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfCalendar(
                      headerHeight: 60,
                      view: CalendarView.month,
                      dataSource: MeetingDataSource(getMeetings(tasks)),
                      monthViewSettings: const MonthViewSettings(
                        showAgenda: true,
                        agendaItemHeight: 50,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  List<MeetingModel> getMeetings(List<TaskModel> tasks) {
    List<MeetingModel> meetings = <MeetingModel>[];
    Color? color;

    for (var task in tasks) {
      task.importance == "No urgency"
          ? color = Colors.green
          : task.importance == "For tomorrow"
              ? color = Colors.yellow
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

  @override
  Widget build(BuildContext context) {
    setState(() {
      tasks = controller.getAllTasks();
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/create_task");
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Here are your tasks, ${user.username}!"),
        actions: [
          IconButton(
              onPressed: () {
                showAppointment();
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
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Color? color;

                tasks[index].importance == "No urgency"
                    ? color = Colors.green
                    : tasks[index].importance == "For tomorrow"
                        ? color = Colors.yellow
                        : color = Colors.red;
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Dismissible(
                    key: ValueKey<TaskModel>(tasks[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        boxShadow: [
                          BoxShadow(
                            color: color,
                            spreadRadius: 1,
                            blurRadius: 1,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tasks[index].title!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    tasks[index].description!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    tasks[index].importance,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Start: ${ConvertDate.toDate(tasks[index].from!)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Finish: ${ConvertDate.toDate(tasks[index].to!)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: DropdownButtonFormField(
                                hint: const Text("State of task"),
                                value: tasks[index].status,
                                items: dropOptions
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    // tasks[index].status = val!;
                                    controller.updateStatus(tasks[index], val!);
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/update_task_page",
                                          arguments: tasks[index]);
                                    },
                                    icon: const Icon(Icons.update),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.deleteTask(tasks[index]);
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Task deleted"),
                                          backgroundColor: Colors.purple,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
