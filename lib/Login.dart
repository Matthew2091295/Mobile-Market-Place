import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_place/HomePage.dart';
import 'package:market_place/pallete.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:market_place/Registration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  getMethod() async {
    String theUrl =
        "https://lamp.ms.wits.ac.za/home/s1854457/getData.php"; //connecting to Wits database
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
    var responseBody = json.decode(res.body);

    print(responseBody);

    return responseBody;
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
                            hint:
                                // Text("username: ${snap[0]['first_name']}").data,
                                Text("username: ").data,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PasswordInput(
                            icon: FontAwesomeIcons.lock,
                            hint: 'Password',
                            inputAction: TextInputAction.done,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Registration())),
                            child: Text(
                              'Forgot Password',
                              style: kBodyText.copyWith(
                                  color: kBlue, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          RoundedButton(
                            buttonName: 'Login',
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
                        onTap: () => Navigator.pushNamed(context, '/'),
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
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage()));
                            },
                            color: Color.fromRGBO(206, 166, 97, 1.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Text("Login"),
                          ),
                        ),
                      ),
                    ],
                  );
                }))
      ],
    );
  }
}
