import 'package:basic_form/custom_input.dart';
import 'package:basic_form/src/modules/tasks/tasks_controller.dart';
import 'package:flutter/material.dart';

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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomInput(
                      icon: Icons.title,
                      controller: newTitle,
                      label: "Title: ${task.title}",
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInput(
                      icon: Icons.description_sharp,
                      controller: newDescription,
                      label: "Description: ${task.description}",
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              controller.updateTask(
                                  task, newTitle.text, newDescription.text);
                              Navigator.of(context).pushNamed("/tasks_page");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Update"),
                                Icon(Icons.update)
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
