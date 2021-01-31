import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/photographer/login_screen.dart';

class LoginUser extends StatefulWidget {
  static const String id ="LoginUser";
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
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
                  image: AssetImage('images/person.png'),
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
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                            decoration: InputDecoration(
                              labelText: 'email / phone number',
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
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'password',
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
                            onPressed: () {},
                            child: Text(
                              'LOGIN',
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
                            onPressed: () {},
                            child: Text(
                              'Don\'t have an Account ?',
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginScreenPhotographer.id);
                            },
                            child: Text(
                              'Are you a Photographer ?',
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
