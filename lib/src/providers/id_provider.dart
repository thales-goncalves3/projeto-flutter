import 'package:flutter/cupertino.dart';

class IdProvider extends ChangeNotifier {
  static int _id = 0;

  int get id => _id;

  void increment() {
    _id++;
    notifyListeners();
  }
}
