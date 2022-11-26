import 'package:basic_form/controllers/database.dart';

import '../../core/models/user_model.dart';

class HomeController {
  var database = Database();

  List<UserModel> getUsers() {
    return database.getAllUsers();
  }
}
