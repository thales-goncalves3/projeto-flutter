import 'package:basic_form/custom_input.dart';
import 'package:basic_form/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/user_model.dart';
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
  final formKey = GlobalKey<FormState>();
  late UserProvider user;

  final controller = LoginController();
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(width: 100, 'assets/images/logo.png'),
                        const Text("TODO APP",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(156, 39, 176, 1),
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        CustomInput(
                          controller: username,
                          label: "Username",
                          hintText: "Type your username",
                          icon: Icons.person,
                          obscureText: false,
                          validator: ((text) => text!.isEmpty
                              ? "This field can't be empty"
                              : null),
                        ),
                        const SizedBox(height: 10),
                        CustomInput(
                          controller: password,
                          label: "Password",
                          hintText: "Type your password",
                          icon: Icons.lock,
                          validator: ((text) => text!.isEmpty
                              ? "This field can't be empty"
                              : null),
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                var response =
                                    controller.checkUser(username, password);
                                switch (response) {
                                  case 1:
                                    UserModel userToProvider =
                                        controller.getUser(username.text);
                                    user.setUser(userToProvider);
                                    Navigator.of(context)
                                        .pushNamed("/splash_page");
                                    formKey.currentState?.reset();
                                    break;
                                  case 2:
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text(
                                                "Username not found",
                                                style: TextStyle(
                                                    color: Colors.purple),
                                              ),
                                              content:
                                                  const Text("Back to sign in"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pushNamed(
                                                            context, "/"),
                                                    child: const Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: Colors.purple),
                                                    ))
                                              ],
                                            ));
                                    break;
                                  case 3:
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text(
                                                  "Password incorrect",
                                                  style: TextStyle(
                                                      color: Colors.purple)),
                                              content:
                                                  const Text("Back to sign in"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pushNamed(
                                                            context, "/"),
                                                    child: const Text("OK"))
                                              ],
                                            ));
                                    break;
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Sign in"),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/register_page');
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Sign up"),
                            )),
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
