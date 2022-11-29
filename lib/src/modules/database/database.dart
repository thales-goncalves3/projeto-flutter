import 'dart:math';

import 'package:basic_form/src/core/models/user_model.dart';
import 'package:hive/hive.dart';

var database = Hive.box("database");

class Database {
  List<UserModel> getAllUsers() {
    List<dynamic> listUsers = database.values.toList();
    List<UserModel> usersModels = <UserModel>[];

    for (var element in listUsers) {
      usersModels.add(UserModel.fromMap(element));
    }

    return usersModels;
  }

  UserModel? getUser(String username) {
    List<UserModel> listUsers = getAllUsers();

    for (var user in listUsers) {
      if (user.username == username) {
        return user;
      }
    }

    return null;
  }

  UserModel? getUserWithId(int id) {
    List<UserModel> listUsers = getAllUsers();

    for (var user in listUsers) {
      if (user.id == id) {
        return user;
      }
    }

    return null;
  }

  Future<int> addUser(Map<String, dynamic> user) {
    return database.add(user);
  }

  void removeUser(int? id) async {
    await database.delete(id);
  }

  void updateUser(int id, String? email, String? password) async {
    UserModel? user = getUserWithId(id);

    if (user != null) {
      if (email != null && email.isNotEmpty) {
        user = user.copyWith(email: email);
      }

      if (password != null && password.isNotEmpty) {
        user = user.copyWith(password: password);
      }

      await database.put(id, user.toMap());
    }
  }
}
