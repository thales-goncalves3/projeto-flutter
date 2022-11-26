import 'package:flutter/material.dart';

import 'modules/registration/registration_page.dart';
import 'modules/home/home_page.dart';
import 'modules/login/login_page.dart';

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
        '/register_page': (context) => const BasicForm(),
        '/home_page': (context) => HomePage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}
