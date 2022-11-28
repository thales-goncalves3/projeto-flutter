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

  Future<int> addUser(Map<String, dynamic> user) {
    return database.add(user);
  }

  void removeUser(int? id) async {
    print(getAllUsers());
    print(database.keys);
    await database.delete(id);
  }
}
