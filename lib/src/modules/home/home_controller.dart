import 'package:basic_form/src/modules/database/database.dart';

import '../../core/models/user_model.dart';

class HomeController {
  var database = Database();

  List<UserModel> getUsers() {
    return database.getAllUsers();
  }

  removeUser(int? user) {
    print("entrou no removeUser");
    return database.removeUser(user);
  }
}
