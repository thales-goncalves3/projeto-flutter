import 'package:basic_form/basic_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        '/': (context) => const HomePage(),
        '/basic_form': (context) => BasicForm(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
              } ,
              child: const Text("Basic Form"),
            ),
          ),
        ),
      );
  }
}