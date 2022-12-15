import 'package:basic_form/src/modules/tasks/tasks_page.dart';
import 'package:flutter/material.dart';

import '../appointment/appointment_page.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import '../registration/registration_page.dart';
import '../splash/splash_page.dart';
import '../tasks/create_task.dart';
import '../tasks/task_update.dart';
import '../update/update_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/': (context) => const Login(),
    '/tasks_page': (context) => const TasksPage(),
    '/register_page': (context) => const BasicForm(),
    '/home_page': (context) => const HomePage(),
    '/update_page': (context) => const UpdatePage(),
    '/create_task': (context) => const CreateTask(),
    '/splash_page': (context) => const SplashPage(),
    '/update_task_page': (context) => const TaskUpdate(),
    '/appointment_page': (context) => const AppointmentPage(),
  };

  static String inicial = '/';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
