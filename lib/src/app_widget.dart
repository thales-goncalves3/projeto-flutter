import 'package:flutter/material.dart';

import 'modules/routes/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Form',
      initialRoute: Routes.inicial,
      routes: Routes.list,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(6, 12, 34, 1),
            secondary: const Color.fromRGBO(6, 12, 34, 1)),
        fontFamily: 'Roboto',
      ),
    );
  }
}
