import 'package:basic_form/custom_input.dart';
import 'package:basic_form/src/modules/tasks/tasks_controller.dart';
import 'package:basic_form/src/providers/id_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/task_model.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  List<String> importance = <String>[
    "I need it yesterday",
    "For tomorrow",
    "No urgency",
  ];

  late IdProvider id;

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    id = Provider.of<IdProvider>(context);
    var task = TaskModel(id: id.id, title: "", description: "", importance: "");
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    final formKey = GlobalKey<FormState>();
    TasksController controller = TasksController();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                    hint: const Text("Importance of task"),
                    value: dropdownValue,
                    items: importance.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value.toString();
                      });
                    }),
              ),
              CustomInput(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "This field is required";
                  }

                  return null;
                },
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
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "This field is required";
                  }

                  return null;
                },
                onSaved: ((text) => task = task.copyWith(description: text)),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: (() {
                          if (formKey.currentState!.validate()) {
                            task = task.copyWith(importance: dropdownValue);
                            formKey.currentState!.save();
                            controller.addTask(task);
                            id.increment();
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
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                    context, "/tasks_page"),
                                            child: const Text("OK"))
                                      ],
                                    ));
                          }
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
