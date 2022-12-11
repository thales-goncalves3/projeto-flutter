// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? contentText;
  List<Widget>? actions;

  CustomDialog({
    Key? key,
    this.title,
    this.titleStyle,
    this.contentText,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? "",
        style: titleStyle,
      ),
      content: Text(contentText ?? ""),
      actions: actions ?? [],
    );
  }
}
