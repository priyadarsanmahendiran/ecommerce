import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:math';
import 'package:ecommerce/photographer/event_details.dart';

class BookingPhotographer extends StatefulWidget {
  static const String id = "Booking";
  @override
  _BookingPhotographerState createState() => _BookingPhotographerState();
}

class _BookingPhotographerState extends State<BookingPhotographer> {

  List<Appointment> querySnapshot;
  List<Color> _colorCollection;
  DateTime today = new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final Random rand = Random();
  @override
  void initState(){
    _initializeEventColor();
    _getDataFromFirestore().then((results) {
      if(results!=null) {
        setState(() {
          querySnapshot = results;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Photographer's View"),
        ),
        body: Container(
          child:
                RefreshIndicator(
                  child: ListView(
                    itemExtent: 600,
                    children: [
                      SfCalendar(
                          onTap: _EventPressed,
                          initialSelectedDate: DateTime.now(),
                          view: CalendarView.month,
                          todayHighlightColor: Colors.red,
                          showNavigationArrow: true,
                          dataSource: _getCalendarDataSource(),
                          showDatePickerButton: true,
                          monthViewSettings: MonthViewSettings(
                            showAgenda: true,
                            agendaViewHeight: 200,
                            dayFormat: 'EEE',
                          ),
                        ),
                     ]
                  ),
                  onRefresh: _getDataRefresh,
                ),
            ),
    );
  }
  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = [];
    appointments = querySnapshot;
    return _AppointmentDataSource(appointments);
    // print(querySnapshot.first.subject);
  }

  Future <void> _getDataRefresh() async {
    setState(() {
      _getDataFromFirestore().then((results) {
        if(results!=null) {
          setState(() {
            querySnapshot = results;
          });
        }
      });
    });
  }

  _getDataFromFirestore () async{
    final _firestore = FirebaseFirestore.instance;
    final _events = await _firestore.collection('coimbatore').get();
    List <Appointment> appoints = [];
    for(var event in _events.docs){
      appoints.add(Appointment(
          startTime: DateTime.fromMicrosecondsSinceEpoch(event.data()['StartTime'].microsecondsSinceEpoch),
          endTime: DateTime.fromMicrosecondsSinceEpoch(event.data()['EndTime'].microsecondsSinceEpoch),
          subject: event.data()['EventName'],
          color: _colorCollection[rand.nextInt(8)],
          location: event.data()['Location'],
          isAllDay: false,
      ));
    }
    return appoints;
  }

  void _EventPressed(CalendarTapDetails details){
    if(details != null && details.appointments.length == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetail(eventSel: details.appointments.first)));
    }
  }

  void _initializeEventColor() {
    this._colorCollection = new List<Color>();
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}


class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
