import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String? hintText;
  final IconData? icon;
  final Widget? suffix;
  final TextEditingController? controller;
  bool obscureText;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;

  CustomInput({
    Key? key,
    required this.label,
    this.hintText,
    this.icon,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.suffix,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hintText,
        prefixIcon: icon == null ? null : Icon(icon),
        suffixIcon: suffix,
      ),
    );
  }
}
