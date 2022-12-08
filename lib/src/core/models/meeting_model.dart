// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MeetingModel {
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  MeetingModel({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
  });
}
