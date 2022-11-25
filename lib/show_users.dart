import 'package:basic_form/controllers/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'model/user_model.dart';

class ShowUsers extends StatelessWidget {
  ShowUsers({super.key});

  var db = Hive.box("database");

  @override
  Widget build(BuildContext context) {
    List<UserModel> users = Database().getAllUsers();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
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
                  Text("Nome: ${users[index].name}"),
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
