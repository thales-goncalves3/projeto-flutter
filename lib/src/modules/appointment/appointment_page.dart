import 'package:basic_form/src/modules/tasks/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../tasks/meeting_data_source.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  TasksController controller = TasksController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your appointments"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SfCalendar(
            view: CalendarView.month,
            dataSource: MeetingDataSource(
                controller.getMeetings(controller.getAllTasks())),
            monthViewSettings: const MonthViewSettings(
              showAgenda: true,
              agendaViewHeight: 400,
              agendaItemHeight: 50,
            ),
          ),
        ),
      ),
    );
  }
}
