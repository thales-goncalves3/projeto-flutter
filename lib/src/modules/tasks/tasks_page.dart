import 'package:basic_form/src/modules/tasks/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
                // ignore: prefer_const_constructors
                ? color = Color.fromARGB(181, 9, 104, 12)
                : tasks[index].importance == "For tomorrow"
                    // ignore: prefer_const_constructors
                    ? color = Color.fromARGB(197, 239, 216, 6)
                    : color = const Color.fromARGB(181, 218, 24, 10);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: color, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 1,
                      blurRadius: 10,
                      blurStyle: BlurStyle.outer)
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tasks[index].title!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            tasks[index].description!,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            tasks[index].importance,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
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
                              },
                              icon: const Icon(Icons.delete_outline)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
