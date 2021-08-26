
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(0, 0, 128, 1.0),
        title: Text(
            "Registration",
          style: TextStyle(

          ),
        ),
      ),
    );
  }
}
