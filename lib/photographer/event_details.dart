import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class EventDetail extends StatelessWidget {
  EventDetail({this.eventSel, this.loc});
  final Appointment eventSel;
  final String loc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TDF APP'),
      ),
      body: EventDetails(event: eventSel, location: loc),
    );
  }
}


class EventDetails extends StatefulWidget {
  final Appointment event;
  final String location;
  EventDetails({this.event, this.location});

  @override
  _EventDetailsState createState() => _EventDetailsState(eventSelected: event, location: location);
}

class _EventDetailsState extends State<EventDetails> {
  _EventDetailsState({this.eventSelected, this.location});
  final String location;
  final Appointment eventSelected;
  bool finishButtonDisabled = true;
  bool acceptButtonDisabled = false;
  bool extendedButtonDisabled = true;
  final _firestore = FirebaseFirestore.instance;
  var userID;
  static const kInActiveButtonstyle = Colors.grey;
  static const kExtendedButtonstyle = Colors.red;
  static const kActiveButtonStyle = Colors.green;
  String _hours;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                    "Event Name: " + getSubject(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      fontStyle: FontStyle.italic
                    ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  getDate() + ' \n\n' + getStartTime() + '\n\n' + getEndTime() + '\n\n' + getLocation(),
                  style: TextStyle(
                      fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: MaterialButton(
                  onPressed: acceptButtonDisabled ? null: () {
                    setState(() {
                      finishButtonDisabled = false;
                      extendedButtonDisabled = false;
                      acceptButtonDisabled = true;
                      _firestore.collection(location).doc(eventSelected.notes).update({"Status": "Accepted"})
                      .then((value) => print('success'));
                    });
                  },
                  child: Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.white
                      )
                  ),
                  height: 10.0,
                ),
                color: acceptButtonDisabled ? kInActiveButtonstyle : kActiveButtonStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: MaterialButton(
                  enableFeedback: false,
                  onPressed: finishButtonDisabled ? null : (){
                    _firestore.collection(location).doc(eventSelected.notes).update({"Status" : "Completed"});
                  },
                  child: Text(
                      'Finished',
                      style: TextStyle(
                        color: Colors.white
                      )
                  ),
                  height: 10.0,
                ),
                color: finishButtonDisabled ? kInActiveButtonstyle : kActiveButtonStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: MaterialButton(
                  onPressed: extendedButtonDisabled ? null : (){
                    showDialogBox();
                  },
                  child: Text(
                      'Extended',
                      style: TextStyle(
                        color: Colors.white
                      )
                  ),
                  height: 10.0,
                ),
                color: extendedButtonDisabled ? kInActiveButtonstyle : kExtendedButtonstyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getSubject(){
    return eventSelected.subject;
  }

  String getDate(){
    String date = "Date: " + eventSelected.startTime.day.toString();
    date += "-" + eventSelected.startTime.month.toString();
    date += "-" + eventSelected.startTime.year.toString();
    return date;
  }

  String getStartTime(){
    if(eventSelected.startTime.hour<=12){
      if(eventSelected.startTime.minute>0){
        return "Starts at: " + eventSelected.startTime.hour.toString() + ":" + eventSelected.startTime.minute.toString() + " AM";
      }
      else {
        return "Starts at: " + eventSelected.startTime.hour.toString() + " AM";
      }
    }
    else {
      if(eventSelected.startTime.minute>0){
        return "Starts at: " + (eventSelected.startTime.hour-12).toString() + ":" + eventSelected.startTime.minute.toString() + " PM";
      }
      else {
        return "Starts at: " + (eventSelected.startTime.hour-12).toString() + " PM";
      }
    }
  }

  String getEndTime(){
    getLocation();
      if(eventSelected.endTime.hour<=12){
        if(eventSelected.endTime.minute>0){
          return "Ends at: " + eventSelected.endTime.hour.toString() + ":" + eventSelected.endTime.minute.toString() + " AM";
        }
        else {
          return "Ends at: " + eventSelected.endTime.hour.toString() + " AM";
        }
      }
      else {
        if(eventSelected.endTime.minute>0){
          return "Ends at: " + (eventSelected.endTime.hour-12).toString() + ":" + eventSelected.endTime.minute.toString() + " PM";
        }
        else {
          return "Ends at: " + (eventSelected.endTime.hour-12).toString() + " PM";
        }
      }
  }

  String getLocation(){
    return "Location: " + eventSelected.location.toString();
  }

  eventExtended() async{
    print(eventSelected.endTime.hour);
      final _extended = await _firestore.collection(location).doc(eventSelected.notes).update({"Status" : "Extended"})
          .then((value) {
            print('EVENT EXTEND');
      });
  }

  void showDialogBox(){
    showDialog(
      context: context,
      builder: (context) {
        return new Dialog(
          child: Form(
            key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      value: _hours,
                      onSaved: (value) {
                        setState(() {
                          _hours = value;
                          print(_hours);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          print(_hours);
                          _hours = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "One Hour",
                          "value" : "1"
                        },
                        {
                          "display": "Two Hours",
                          "value" : "2"
                        },
                        {
                          "display": "Three Hours",
                          "value" : "3"
                        },
                        {
                          "display": "Four Hours",
                          "value" : "4"
                        },
                        {
                          "display": "Five Hours",
                          "value" : "5"
                        },
                      ],
                      textField: "display",
                      valueField: "value",
                    )
                  ),
                  RaisedButton(
                      onPressed: eventExtended,
                      child: Text(
                          'Extend',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      color: Colors.red,
                  )
                ],
              ),

          )
        );
      }
    );
  }

}
