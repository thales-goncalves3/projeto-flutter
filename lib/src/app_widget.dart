import 'package:basic_form/src/modules/tasks/create_task.dart';
import 'package:basic_form/src/modules/tasks/task_update.dart';
import 'package:basic_form/src/modules/tasks/tasks_page.dart';
import 'package:flutter/material.dart';

import 'modules/registration/registration_page.dart';
import 'modules/home/home_page.dart';
import 'modules/login/login_page.dart';
import 'modules/splash/splash_page.dart';
import 'modules/update/update_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Form',
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/tasks_page': (context) => const TasksPage(),
        '/register_page': (context) => const BasicForm(),
        '/home_page': (context) => const HomePage(),
        '/update_page': (context) => UpdatePage(),
        '/create_task': (context) => const CreateTask(),
        '/splash_page': (context) => const SplashPage(),
        '/update_task_page': (context) => const TaskUpdate(),
      },
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Roboto'),
    );
  }
}
