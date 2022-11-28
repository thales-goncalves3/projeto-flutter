import 'package:basic_form/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as validator;

import '../../core/models/user_model.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({super.key});

  TextEditingController newEmail = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserModel data = ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update user ${data.username!.toUpperCase()}"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Username: ${data.username!}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Email: ${data.email}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomInput(
                      label: "Email",
                      hintText: "Update your email",
                      controller: newEmail,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomInput(
                      label: "Password",
                      hintText: "Update your password",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {}, child: const Text("Update"))
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
