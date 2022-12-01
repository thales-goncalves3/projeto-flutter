import 'package:basic_form/custom_input.dart';
import 'package:basic_form/src/modules/database/tasks_database.dart';
import 'package:flutter/material.dart';

import '../../core/models/task_model.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  late int id;
  @override
  Widget build(BuildContext context) {
    setState(() {
      id = ModalRoute.of(context)!.settings.arguments as int;
    });
    var task = TaskModel();

    var controller = TaskDatabase();
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInput(
                label: "Title",
                controller: title,
                onSaved: (text) => task = task.copyWith(title: text),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomInput(
                label: "Description",
                controller: description,
                onSaved: ((text) => task = task.copyWith(description: text)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: (() {
                          formKey.currentState!.save();
                          controller.createTask(id, task);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text(
                                      "Task created successfully",
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                    content: const Text("Back to Tasks"),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pushNamed(
                                              context, "/tasks_page"),
                                          child: const Text("OK"))
                                    ],
                                  ));
                        }),
                        child: const Text("Create"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
