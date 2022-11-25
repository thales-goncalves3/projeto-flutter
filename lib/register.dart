import 'package:basic_form/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:string_validator/string_validator.dart' as validator;
import 'package:provider/provider.dart';
import './providers/id_provider.dart';

import 'custom_input.dart';

class BasicForm extends StatefulWidget {
  const BasicForm({super.key});

  @override
  State<BasicForm> createState() => _BasicFormState();
}

class _BasicFormState extends State<BasicForm> {
  final formKey = GlobalKey<FormState>();
  var password = '';
  var passwordConfirm = '';
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;
  var user = UserModel();
  final db = Hive.box("database");
  late Id id;

  void createUser(id) {
    user = user.copyWith(id: id);

    db.add(user.toMap());
  }

  @override
  Widget build(BuildContext context) {
    id = Provider.of<Id>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sing up"),
      ),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomInput(
                  label: "Username",
                  hintText: "Type your username",
                  icon: Icons.person,
                  onSaved: (text) => user = user.copyWith(name: text),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "This field is required";
                    }

                    if (text.length <= 6) {
                      return "The username must have more than six digits";
                    }

                    return null;
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomInput(
                label: "Email",
                hintText: "Type your email",
                icon: Icons.mail,
                onSaved: (text) => user = user.copyWith(email: text),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "This field is required";
                  }

                  if (!validator.isEmail(text)) {
                    return "This field must be email type";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomInput(
                label: "Password",
                hintText: "Type your password",
                icon: Icons.lock,
                obscureText: obscureTextPassword,
                onSaved: (text) => user = user.copyWith(password: text),
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
                validator: (text) => text == null || text.isEmpty
                    ? "This field is required"
                    : null,
                onChanged: (text) => password = text,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomInput(
                label: "Confirm Password",
                hintText: "Confirm your password",
                icon: Icons.lock,
                obscureText: obscureTextConfirmPassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureTextConfirmPassword = !obscureTextConfirmPassword;
                    });
                  },
                  icon: Icon(obscureTextConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
                onChanged: (text) {
                  passwordConfirm = text;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "This field is required";
                  }

                  if (password != passwordConfirm) {
                    return "The passwords must be equal";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            createUser(id.id);
                            id.increment();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text(
                                          "User created successfully"),
                                      content: const Text("Back to sign in"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                    context, "/"),
                                            child: const Text("OK"))
                                      ],
                                    ));
                          }
                        },
                        child: const Text("Sing up"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          formKey.currentState?.reset();
                        },
                        child: const Text("Reset"),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          )),
    );
  }
}
