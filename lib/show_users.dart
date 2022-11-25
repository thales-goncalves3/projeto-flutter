import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';

import 'model/user_model.dart';

class ShowUsers extends StatelessWidget {
  ShowUsers({super.key});

  var db = Hive.box("database");

  List<UserModel> getUsers() {
    List<UserModel> usersModels = <UserModel>[];
    List<dynamic> listUsers = db.values.toList();

    listUsers.forEach((element) {
      usersModels.add(UserModel.fromMap(element));
    });

    return usersModels;
  }

  @override
  Widget build(BuildContext context) {
    List<UserModel> users = getUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Container(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
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
