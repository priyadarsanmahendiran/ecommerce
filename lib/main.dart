import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/photographer/booking.dart';
import 'package:ecommerce/photographer/login_screen.dart';
import 'package:ecommerce/enduser/login_user.dart';
import 'package:ecommerce/photographer/register_photographer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginUser.id,
      routes: {
        LoginUser.id : (context) => LoginUser(),
        LoginScreenPhotographer.id: (context) => LoginScreenPhotographer(),
        BookingPhotographer.id: (context) => BookingPhotographer(),
        RegisterPhotographer.id: (context) => RegisterPhotographer()
      },
    );
  }
}
