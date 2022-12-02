import 'package:basic_form/src/modules/database/database.dart';
import '../../core/models/user_model.dart';

class RegistrationController {
  var database = Database();

  Future<bool> createUser(UserModel user) async {
    return await database.addUser(user.toMap()) >= 0 ? true : false;
  }

  bool verifyUser(String user) {
    List<UserModel> users = database.getAllUsers();

    for (var element in users) {
      if (element.username == user) {
        return true;
      }
    }

    return false;
  }

  bool verifyEmail(String email) {
    List<UserModel> users = database.getAllUsers();

    for (var element in users) {
      if (element.email == email) {
        return true;
      }
    }

    return false;
  }
}
