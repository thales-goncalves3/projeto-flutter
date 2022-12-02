import 'package:basic_form/src/modules/home/home_controller.dart';
import 'package:flutter/material.dart';

import '../../core/models/user_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = HomeController();
  late List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    setState(() {
      users = controller.getUsers();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/");
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: Dismissible(
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.purple),
                        ),
                        content: const Text(
                            "Are you sure you wish to delete this user?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  controller.removeUser(users[index]);
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text("DELETE")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("CANCEL")),
                        ],
                      );
                    });
              },
              onDismissed: (direction) {
                setState(() {
                  controller.removeUser(users[index]);
                });
              },
              background: Container(
                alignment: const Alignment(0.8, 0.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(197, 255, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
              ),
              key: ValueKey(users[index]),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.purple,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.purple.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 5)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nome: ${users[index].username}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Email: ${users[index].email}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/update_page",
                                  arguments: users[index]);
                            },
                            icon: const Icon(Icons.update),
                            color: const Color.fromARGB(255, 251, 251, 251),
                          ),
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                controller.removeUser(users[index]);
                              });
                            },
                            icon: const Icon(Icons.delete_outline),
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
