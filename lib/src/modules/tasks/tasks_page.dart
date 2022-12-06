import 'package:basic_form/src/modules/tasks/convert_date_controller.dart';
import 'package:basic_form/src/modules/tasks/tasks_controller.dart';
import 'package:flutter/material.dart';

import '../../core/models/task_model.dart';
import '../../core/models/user_model.dart';
import '../../providers/user_provider.dart';

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

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).pushNamed('/');
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            Color? color;

            tasks[index].importance == "No urgency"
                ? color = const Color.fromARGB(181, 9, 104, 12)
                : tasks[index].importance == "For tomorrow"
                    ? color = const Color.fromARGB(197, 239, 216, 6)
                    : color = const Color.fromARGB(181, 218, 24, 10);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Dismissible(
                key: ValueKey<TaskModel>(tasks[index]),
                child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      boxShadow: [
                        BoxShadow(
                          color: color,
                          spreadRadius: 5,
                          blurRadius: 5,
                        )
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey.shade100.withOpacity(0.8),
                          Colors.grey.shade200.withOpacity(0.4),
                          Colors.grey.shade300.withOpacity(0.6),
                          Colors.grey.shade400.withOpacity(0.4),
                        ],
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          width: 300,
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
                                  controller.deleteTask(tasks[index]);
                                  Navigator.of(context)
                                      .pushNamed('/tasks_page');
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
