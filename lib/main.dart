import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/photographer/booking.dart';
import 'package:ecommerce/photographer/login_screen.dart';

void main() {
  runApp(EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      initialRoute: LoginScreenPhotographer.id,
      routes: {
        LoginScreenPhotographer.id: (context) => LoginScreenPhotographer(),
        BookingPhotographer.id: (context) => BookingPhotographer()
      },
    );
  }
}
