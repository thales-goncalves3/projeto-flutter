import 'package:basic_form/src/core/models/user_model.dart';

import '../database/database.dart';

class UpdateController {
  var database = Database();

  bool checkEmail(String email) {
    var users = database.getAllUsers();

    for (var element in users) {
      if (element.email == email) {
        return true;
      }
    }

    return false;
  }

  bool updateUser(int id, String? email, String? password) {
    database.updateUser(id, email, password);
    return true;
  }
}
