import 'package:basic_form/providers/id_provider.dart';
import 'package:basic_form/src/modules/database/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  var controller = Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/create_task", arguments: Id().id);
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Here are your tasks"),
        actions: [
          IconButton(
              onPressed: () {
                Hive.box("database").clear();
                Navigator.of(context).pushNamed('/');
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
