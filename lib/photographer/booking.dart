import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        title: Text('TDF'),
      ),
    );
  }
}
