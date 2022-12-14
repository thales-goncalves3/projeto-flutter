// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:basic_form/src/core/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  static UserModel _user = UserModel();

  static UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
