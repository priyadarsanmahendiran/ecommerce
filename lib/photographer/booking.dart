import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:math';
import 'package:ecommerce/photographer/event_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingPhotographer extends StatefulWidget {
  static const String id = "Booking";
  @override
  _BookingPhotographerState createState() => _BookingPhotographerState();
}

class _BookingPhotographerState extends State<BookingPhotographer> {

  List<Appointment> querySnapshot;
  List<Color> _colorCollection;
  final Random rand = Random();
  var userID;
  final _auth = FirebaseAuth.instance;
  var _loc;

  @override
  void initState(){
    userID = _auth.currentUser.uid;
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
    final _userDetails = await _firestore.collection('photographers').doc(userID).get();
    String _location = _userDetails.data()['Location'];
    _loc =_location.toLowerCase();
    print(_loc);
    final _events = await _firestore.collection(_loc).where('EmployeeId', isEqualTo: "1").where('Status', isEqualTo: "NotAccepted").get();
    List <Appointment> appoints = [];
    for(var event in _events.docs){
      appoints.add(Appointment(
          startTime: DateTime.fromMicrosecondsSinceEpoch(event.data()['StartTime'].microsecondsSinceEpoch),
          endTime: DateTime.fromMicrosecondsSinceEpoch(event.data()['EndTime'].microsecondsSinceEpoch),
          subject: event.data()['EventName'],
          color: _colorCollection[rand.nextInt(8)],
          location: event.data()['Location'],
          isAllDay: false,
          notes: event.id,
      ));
    }
    return appoints;
  }

  void _EventPressed(CalendarTapDetails details){
    if(details != null && details.appointments.length == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetail(eventSel: details.appointments.first, loc: _loc,)));
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
