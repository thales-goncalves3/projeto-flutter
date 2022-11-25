import 'package:basic_form/login.dart';
import 'package:basic_form/providers/id_provider.dart';
import 'package:basic_form/show_users.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'register.dart';

void main() async {
  await Hive.initFlutter();

  var database = await Hive.openBox('database');

  Hive.box('database').clear();

  runApp(ChangeNotifierProvider(
    create: (context) => Id(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Form',
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/basic_form': (context) => const BasicForm(),
        '/show_users': (context) => const ShowUsers(),
      },
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Form"),
      ),
      body: Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: () => {
              Navigator.of(context).pushNamed('/basic_form'),
            },
            child: const Text("Basic Form"),
          ),
        ),
      ),
    );
  }
}
