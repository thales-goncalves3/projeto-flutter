import 'package:basic_form/custom_input.dart';
import 'package:basic_form/src/modules/tasks/tasks_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../core/models/task_model.dart';

class TaskUpdate extends StatefulWidget {
  const TaskUpdate({super.key});

  @override
  State<TaskUpdate> createState() => _TaskUpdateState();
}

class _TaskUpdateState extends State<TaskUpdate> {
  TextEditingController newTitle = TextEditingController();
  TextEditingController newDescription = TextEditingController();
  late TaskModel task;
  TasksController controller = TasksController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Update your task"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomInput(
                      controller: newTitle,
                      label: "Title: ${task.title}",
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomInput(
                      controller: newDescription,
                      label: "Description: ${task.description}",
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          controller.updateTask(
                              task, newTitle.text, newDescription.text);
                          Navigator.of(context).pushNamed("/tasks_page");
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Update"),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
