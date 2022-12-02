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

  bool updateUser(String? email, String? password) {
    database.updateUser(email, password);
    return true;
  }
}
