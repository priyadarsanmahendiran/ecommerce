import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class EventDetail extends StatelessWidget {
  EventDetail({this.eventSel});
  final Appointment eventSel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TDF APP'),
      ),
      body: EventDetails(event: eventSel),
    );
  }
}


class EventDetails extends StatefulWidget {
  final Appointment event;
  EventDetails({this.event});

  @override
  _EventDetailsState createState() => _EventDetailsState(eventSelected: event);
}

class _EventDetailsState extends State<EventDetails> {
  _EventDetailsState({this.eventSelected});
  final Appointment eventSelected;
  bool finishButtonDisabled = true;
  bool acceptButtonDisabled = false;
  bool extendedButtonDisabled = true;
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
                    finishButtonDisabled = false;
                    extendedButtonDisabled = false;
                    acceptButtonDisabled = true;
                  },
                  child: Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  height: 10.0,
                ),
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: MaterialButton(
                  enableFeedback: false,
                  onPressed: finishButtonDisabled ? null : (){
                    print('AAAA');
                  },
                  child: Text(
                      'Finished',
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  height: 10.0,
                ),
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: MaterialButton(
                  onPressed: extendedButtonDisabled ? null : (){

                  },
                  child: Text(
                      'Extended',
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  height: 10.0,
                ),
                color: Colors.red,
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

}
