import 'package:basic_form/src/modules/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  var controller = HomeController();

  @override
  Widget build(BuildContext context) {
    var users = controller.getUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 1))),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID: ${users[index].id}"),
                  Text("Nome: ${users[index].username}"),
                  Text("Email: ${users[index].email}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
