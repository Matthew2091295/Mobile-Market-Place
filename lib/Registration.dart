import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_place/Login.dart';
import 'package:market_place/pallete.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:market_place/HomePage.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordconfirm = new TextEditingController();

  // ignore: non_constant_identifier_names
  Future<void> getMethod(String username, String first_name, String last_name,
      String password) async {
    String theUrl =
        "https://lamp.ms.wits.ac.za/home/s1854457/register_user.php";

    var data = {
      "username": username,
      "first_name": first_name,
      "last_name": last_name,
      "password": password
    };

    var response = await http.post(theUrl, body: json.encode(data));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      TextInputField(
                        icon: FontAwesomeIcons.user,
                        hint: 'First Name',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        controller: fname,
                      ),
                      TextInputField(
                        icon: FontAwesomeIcons.user,
                        hint: 'Last Name',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        controller: lname,
                      ),
                      TextInputField(
                        icon: FontAwesomeIcons.envelope,
                        hint: 'Email',
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        controller: email,
                      ),
                      PasswordInput(
                        icon: FontAwesomeIcons.lock,
                        hint: 'Password',
                        inputAction: TextInputAction.next,
                        controller: password,
                      ),
                      PasswordInput(
                        icon: FontAwesomeIcons.lock,
                        hint: 'Confirm Password',
                        inputAction: TextInputAction.done,
                        controller: passwordconfirm,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: RaisedButton(
                            onPressed: () {
                              if (password.text != passwordconfirm.text) {
                                password.text = "";
                                passwordconfirm.text = "";
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: new Text("Incorrect Details"),
                                      content:
                                          new Text("Passwords do not match"),
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
                              } else if (email.text == "") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: new Text("Missing Details"),
                                      content: new Text("Email Missing"),
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
                              } else if (fname.text == "" || lname.text == "") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: new Text("Incorrect Details"),
                                      content: new Text(
                                          "First or Last name missing"),
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
                              } else if (password.text == "" ||
                                  passwordconfirm.text == "") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: new Text("Incorrect Details"),
                                      content: new Text("Passwords missing"),
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
                              } else {
                                getMethod(email.text, fname.text, lname.text,
                                    password.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePage()));
                                email.text = "";
                                fname.text = "";
                                lname.text = "";
                                password.text = "";
                                passwordconfirm.text = "";
                              }
                            },
                            color: Color(0xff5663ff),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              "Register",
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: kBodyText.copyWith(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Login()));
                            },
                            child: Text(
                              'Login',
                              style: kBodyText.copyWith(
                                  color: kBlue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
