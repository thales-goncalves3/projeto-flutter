import 'package:basic_form/src/modules/database/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/models/user_model.dart';
import '../../providers/user_provider.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  var controller = Database();
  UserModel user = UserProvider.user;
  @override
  Widget build(BuildContext context) {
    // UserModel user = UserProvider().user;
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
    );
  }
}
