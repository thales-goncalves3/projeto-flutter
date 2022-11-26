import 'package:basic_form/src/core/models/user_model.dart';
import 'package:hive/hive.dart';

var database = Hive.box("database");

class Database {
  List<UserModel> usersModels = <UserModel>[];
  List<dynamic> listUsers = database.values.toList();

  List<UserModel> getAllUsers() {
    usersModels.clear();

    for (var element in listUsers) {
      usersModels.add(UserModel.fromMap(element));
    }

    return usersModels;
  }

  UserModel? getUser(String username) {
    List<UserModel> listUsers = getAllUsers();

    for (var user in listUsers) {
      if (user.name == username) {
        return user;
      }
    }

    return null;
  }

  Future<int> addUser(Map<String, dynamic> user) {
    return database.add(user);
  }
}
