import 'package:basic_form/src/modules/tasks/convert_date_controller.dart';
import 'package:basic_form/src/modules/tasks/tasks_controller.dart';
import 'package:basic_form/src/providers/id_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/custom_input.dart';
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
  late DateTime fromDate;
  late DateTime toDate;
  String? dropdownValue;
  late TextEditingController? title;
  late TextEditingController? description;

  @override
  void initState() {
    fromDate = DateTime.now();
    toDate = DateTime.now().add(const Duration(hours: 1));
    dropdownValue = importance.first;
    title = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    id = Provider.of<IdProvider>(context);
    var task = TaskModel(id: id.id, title: "", description: "", importance: "");
    final formKey = GlobalKey<FormState>();
    TasksController controller = TasksController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a task"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    children: [
                      LayoutBuilder(builder: (BuildContext context, _) {
                        if (MediaQuery.of(context).size.width > 400) {
                          return Row(
                            children: [
                              const Text(
                                "Importance of task",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton(
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                hint: const Text("Importance of task"),
                                value: dropdownValue,
                                items: importance.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              const Text(
                                "Importance of task",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownButton(
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                hint: const Text("Importance of task"),
                                value: dropdownValue,
                                items: importance.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        }
                      }),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      icon: Icons.title,
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
                      hintText: "Description",
                      icon: Icons.description,
                      label: "Description",
                      controller: description,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                      onSaved: ((text) =>
                          task = task.copyWith(description: text)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Start date end finish date",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ListTile(
                          leading: const Icon(Icons.calendar_month),
                          title: Text(ConvertDate.toDate(fromDate)),
                          trailing: const Icon(Icons.arrow_drop_down),
                          onTap: () async {
                            final date = await controller.pickDateTime(
                                context, fromDate, true, null);
                            if (date == null) return;

                            if (date.isAfter(fromDate)) {
                              fromDate = DateTime(date.year, date.month,
                                  date.day, date.hour, date.minute);
                            }

                            setState(() {
                              fromDate = date;
                              toDate = date;
                            });
                          },
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ListTile(
                          leading: const Icon(Icons.calendar_month),
                          title: Text(ConvertDate.toDate(toDate)),
                          trailing: const Icon(Icons.arrow_drop_down),
                          onTap: () async {
                            final date = await controller.pickDateTime(
                                context, toDate, true, null);
                            if (date == null) return;

                            if (date.isBefore(fromDate)) {
                              fromDate = DateTime(date.year, date.month,
                                  date.day, date.hour, date.minute);
                            }

                            setState(() {
                              toDate = date;
                            });
                          },
                        )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        hoverColor: Colors.purple,
                        icon: const Icon(Icons.task_alt),
                        onPressed: (() {
                          if (formKey.currentState!.validate()) {
                            task = task.copyWith(importance: dropdownValue);
                            task = task.copyWith(from: fromDate);
                            task = task.copyWith(to: toDate);

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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
