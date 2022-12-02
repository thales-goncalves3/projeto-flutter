import 'package:basic_form/src/modules/database/database.dart';
import 'package:flutter/cupertino.dart';

import '../../core/models/user_model.dart';

class HomeController {
  var database = Database();

  List<UserModel> getUsers() {
    return database.getAllUsers();
  }

  removeUser(UserModel user) {
    return database.removeUser(user);
  }

  updateUser(BuildContext context, UserModel? user) {
    Navigator.of(context).pushNamed("update_page");
  }
}
