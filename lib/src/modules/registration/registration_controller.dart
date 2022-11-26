import 'package:basic_form/controllers/database.dart';
import '../../core/models/user_model.dart';

class RegistrationController {
  var database = Database();

  Future<int> createUser(UserModel user, id) {
    user = user.copyWith(id: id);
    return database.addUser(user.toMap());
  }
}
