import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/models/user_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => Navigator.of(context).pushNamed('/tasks_page'));
  }

  // var database = Hive.box('database');

  @override
  Widget build(BuildContext context) {
    // var values = database.values;
    // List<UserModel> users = <UserModel>[];

    // for (var element in values) {
    //   users.add(UserModel.fromMap(Map<String, dynamic>.from(element)));
    // }

    // for (var element in users) {
    //   Hive.box(element.username!).clear();
    // }
    return Container(
      decoration: const BoxDecoration(color: Colors.purple),
    );
  }
}
