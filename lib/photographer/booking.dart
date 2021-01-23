import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Meeting {
  Meeting({this.eventName, this.from, this.to, this.background, this.isAllDay});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class BookingPhotographer extends StatefulWidget {
  static const String id = "Booking";
  @override
  _BookingPhotographerState createState() => _BookingPhotographerState();
}

class _BookingPhotographerState extends State<BookingPhotographer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Photographer's View"),
        ),
        body: Container(
          child: SfCalendar(
            view: CalendarView.week,
            todayHighlightColor: Colors.red,
            showNavigationArrow: true,
            dataSource: _getCalendarDataSource(),
          ),
        ));
  }
}

_AppointmentDataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(minutes: 10)),
    subject: 'Event !',
    color: Colors.red,
    isAllDay: true,
  ));

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
