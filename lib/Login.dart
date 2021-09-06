import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_place/HomePage.dart';
import 'package:market_place/pallete.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:market_place/Registration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'Globals.dart' as Globals;

/*
Adding Database integration to the application:

Currently the database is accessed via getMethod(), which should probably be put into its own .dart file, so that we are not reusing code. Currently pulls the first record in the database,
and sets the hint for the login as the first records username.
*/

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Declaring global TextEditingControllers. They are used to fetch the text from a textfield.
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  getMethod() async {
    String theUrl =
        "https://lamp.ms.wits.ac.za/home/s1854457/getData.php"; //connecting to Wits database
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
    var responseBody = json.decode(res.body);

    print(responseBody);

    return responseBody;
  }

  checkDetails(List snap, String username, String password) {
    //Loops thorugh snap (JSON String) and checks if the details are correct
    for (int i = 0; i < snap.length; i++) {
      if (snap[i]['username'] == username && snap[i]['password'] == password) {
        return true;
      }
    }
    return false;
  }

  updateUserGlobals(List snap, String username) {
    int index = 0;
    while (snap[index]['username'] != username) {
      index++;
    }
    Globals.firstName = snap[index]['first_name'];
    Globals.lastName = snap[index]['last_name'];
    Globals.birthDate = snap[index]['date_of_birth'];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: FutureBuilder(
                future: getMethod(), //retrieving data from database
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List snap = snapshot.data;
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error fetching Data"),
                    );
                  }
                  return Column(
                    children: [
                      Flexible(
                        child: Center(
                          child: Text(
                            'Marketplace',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextInputField(
                            icon: FontAwesomeIcons.envelope,
                            hint: "Username",
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            //Adding the controller to the Login TextInputField. TextInputField is defined in text-input-field.dart
                            controller: username,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PasswordInput(
                            icon: FontAwesomeIcons.lock,
                            hint: 'Password',
                            inputAction: TextInputAction.done,
                            //Adding the controller to the Password PasswordInput. PasswordInput is defined in password-input.dart
                            controller: password,
                          ),
                          // GestureDetector(
                          //   onTap: () => Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (BuildContext context) =>
                          //               Registration())),
                          //   child: Text(
                          //     'Forgot Password',
                          //     style: kBodyText.copyWith(
                          //         color: kBlue, fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: SizedBox(
                              width: 300,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () {
                                  //Cfetching and checking login details
                                  if (checkDetails(
                                      snap, username.text, password.text)) {
                                    Globals.username = username.text;
                                    updateUserGlobals(snap, username.text);
                                    username.text = "";
                                    password.text = "";
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage()));
                                  } else {
                                    username.text = "";
                                    password.text = "";
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: new Text(
                                              "Incorrect Username or Password"),
                                          content: new Text(
                                              "Username or Password is incorrect"),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text("OK"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                color: Color(0xff5663ff),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "Login",
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Registration())),
                        child: Container(
                          child: Text(
                            'Create New Account',
                            style: kBodyText.copyWith(
                                color: kBlue, fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width: 1, color: kWhite))),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }))
      ],
    );
  }
}
