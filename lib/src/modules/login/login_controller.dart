import 'package:flutter/material.dart';
import '../database/database.dart';
import '../../core/models/user_model.dart';

class LoginController {
  var database = Database();

  int checkUser(
      TextEditingController username, TextEditingController password) {
    List<UserModel> users = database.getAllUsers();

    if (users.isNotEmpty) {
      if (containsUser(username.text, users)) {
        return checkPassword(database.getUser(username.text), password.text);
      } else {
        return 2;
      }
    }
    return 2;
  }

  containsUser(String username, List<UserModel> users) {
    for (var user in users) {
      if (username == user.username) {
        return true;
      }
    }
    return false;
  }

  int checkPassword(UserModel? user, String password) {
    return user?.password == password ? 1 : 3;
  }
}
