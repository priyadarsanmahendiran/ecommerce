import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/photographer/login_screen.dart';
import 'package:ecommerce/enduser/login_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPhotographer extends StatefulWidget {
  static const String id = "RegisterPhotographer";
  @override
  _RegisterPhotographerState createState() => _RegisterPhotographerState();
}

class _RegisterPhotographerState extends State<RegisterPhotographer> {

  final _auth = FirebaseAuth.instance;
  String email, password;
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        // The containers in the background
        new Column(
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height * .50,
              child:
              Image(
                image: AssetImage('images/photo-1513031300226-c8fb12de9ade.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
            new Container(
              height: MediaQuery.of(context).size.height * .50,
              color: Colors.white,
            )
          ],
        ),
        // The card widget with top padding,
        // incase if you wanted bottom padding to work,
        // set the `alignment` of container to Alignment.bottomCenter
        new Container(
          alignment: Alignment.topCenter,
          padding: new EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .35,
              right: 20.0,
              left: 20.0),
          child: new Container(
            height: 430.0,
            width: MediaQuery.of(context).size.width,
            child: Form(
              child: new Card(
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.person_rounded,
                            color: Colors.black,
                            size: 70.0,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(6.0, 0, 6.0, 6.0),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hoverColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(6.0, 0, 6.0, 6.0),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hoverColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot password ?',
                            ),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            onPressed: () {
                              _auth.createUserWithEmailAndPassword(email: email, password: password)
                                  .then((value) => {
                                      _firestore.collection('photographers').doc(_auth.currentUser.uid).set({"Status": "NotSelected"})
                                        .then((value) => print('Registered'))
                              });
                            },
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.deepOrange,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginScreenPhotographer.id);
                            },
                            child: Text(
                              'Login as a Photographer!',
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginUser.id);
                            },
                            child: Text(
                              'Want to book a Photographer/Videographer?',
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
