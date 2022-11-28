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
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 4),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID: ${users[index].id}"),
                          Text("Nome: ${users[index].username}"),
                          Text("Email: ${users[index].email}"),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.update),
                          color: Colors.purple,
                        ),
                        IconButton(
                          onPressed: () async {
                            int? id = users[index].id;
                            setState(() {
                              controller.removeUser(id);
                            });
                          },
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
