import 'package:basic_form/controllers/database.dart';
import 'package:basic_form/custom_input.dart';
import 'package:basic_form/model/user_model.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureTextPassword = true;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var database = Database();

  bool checkUser() {
    List<UserModel> users = database.getAllUsers();

    if (users.isNotEmpty) {
      if (containsUser(username.text, users)) {
        return checkPassword(database.getUser(username.text), password.text);
      }
    }

    users.clear();
    return false;
  }

  containsUser(String username, List<UserModel> users) {
    for (var user in users) {
      if (username == user.name) {
        return true;
      }
    }
    return false;
  }

  checkPassword(UserModel? user, String password) {
    return user?.password == password ? true : false;
  }

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
                                if (checkUser()) {
                                  Navigator.of(context)
                                      .pushNamed('/show_users');
                                } else {}
                              },
                              child: const Text("Sign in")),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.height * 0.15,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/basic_form');
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
