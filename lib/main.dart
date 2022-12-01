import 'package:basic_form/src/app_widget.dart';
import 'package:basic_form/providers/id_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('database');

  runApp(ChangeNotifierProvider(
    create: (context) => Id(),
    child: const AppWidget(),
  ));
}
