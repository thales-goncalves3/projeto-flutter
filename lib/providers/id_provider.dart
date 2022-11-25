import 'package:flutter/material.dart';

class Id extends ChangeNotifier {
  int _id = 1;

  int get id => _id;

  void increment() {
    _id++;
    notifyListeners();
  }
}
