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

  @override
  Widget build(BuildContext context) {
    var box = Hive.box(user.username!);
    var values = box.values;
    List<TaskModel> tasks = <TaskModel>[];

    for (var element in values) {
      tasks.add(TaskModel.fromMap(Map<String, dynamic>.from(element)));
    }

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
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tasks[index].title!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(tasks[index].description!),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
