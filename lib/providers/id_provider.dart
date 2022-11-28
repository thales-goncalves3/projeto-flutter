import 'package:flutter/material.dart';

class Id extends ChangeNotifier {
  int _id = 0;

  int get id => _id;

  void increment() {
    _id++;
    notifyListeners();
  }
}
