import 'package:basic_form/custom_input.dart';
import 'package:basic_form/src/modules/update/update_controller.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as validator;

import '../../core/models/user_model.dart';

class UpdatePage extends StatefulWidget {
  UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController newEmail = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  var controller = UpdateController();
  late UserModel data;

  @override
  Widget build(BuildContext context) {
    setState(() {
      data = ModalRoute.of(context)!.settings.arguments as UserModel;
    });

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
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInput(
                  label: "Email",
                  hintText: "Update your email",
                  controller: newEmail,
                  validator: (text) {
                    if (!validator.isEmail(text!)) {
                      return "This field must be email type";
                    }

                    if (text == data.email) {
                      return "The email can't be equal";
                    }

                    if (controller.checkEmail(text)) {
                      return "The email is already registered";
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInput(
                  label: "Password",
                  hintText: "Update your password",
                  controller: newPassword,
                  validator: ((text) {
                    if (text!.length < 8) {
                      return "The password must have 8 or more digits";
                    }

                    if (text == data.password) {
                      return "The password can't be equal";
                    }
                    return null;
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        if (controller.updateUser(
                            data.id!, newEmail.text, newPassword.text)) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text(
                                      "User updated successfully",
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                    content: const Text("Back to homepage"),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .pushNamed("/home_page"),
                                          child: const Text("OK"))
                                    ],
                                  ));
                        }
                      },
                      child: const Text("Update"))
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
