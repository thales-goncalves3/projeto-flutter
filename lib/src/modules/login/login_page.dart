import 'package:basic_form/controllers/database.dart';
import 'package:basic_form/custom_input.dart';
import 'package:basic_form/dialog_error.dart';
import 'package:basic_form/src/core/models/user_model.dart';
import 'package:flutter/material.dart';

import 'login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureTextPassword = true;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final controller = LoginController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInput(
                  controller: username,
                  label: "Username",
                  hintText: "Type your username",
                  icon: Icons.person,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                CustomInput(
                  controller: password,
                  label: "Password",
                  hintText: "Type your password",
                  icon: Icons.lock,
                  obscureText: obscureTextPassword,
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureTextPassword = !obscureTextPassword;
                      });
                    },
                    icon: Icon(obscureTextPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.height * 0.15,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () async {
                                var response =
                                    controller.checkUser(username, password);
                                switch (response) {
                                  case 1:
                                    Navigator.of(context)
                                        .pushNamed("/home_page");

                                    break;
                                  case 2:
                                    const DialogError(
                                        message: "Username not found");
                                    break;
                                  case 3:
                                    const DialogError(
                                        message: "Incorrect Password");
                                    break;
                                  default:
                                }
                              },
                              child: const Text("Sign in")),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.height * 0.15,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/register_page');
                            },
                            child: const Text("Sign up"))),
                  ],
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
