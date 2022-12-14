import 'package:basic_form/src/core/models/user_model.dart';
import 'package:basic_form/src/services/notifications_services/notification_service.dart';
import 'package:basic_form/src/services/providers/id_provider.dart';
import 'package:basic_form/src/services/providers/user_provider.dart';
import 'package:basic_form/src/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  var database = await Hive.openBox('database');

  var values = database.values;
  List<UserModel> users = <UserModel>[];

  for (var element in values) {
    users.add(UserModel.fromMap(Map<String, dynamic>.from(element)));
  }

  for (var element in users) {
    Hive.openBox(element.username!);
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => IdProvider()),
      Provider<NotificationService>(
        create: (context) => NotificationService(),
      )
    ],
    child: const AppWidget(),
  ));
}
