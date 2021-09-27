import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'Globals.dart' as Globals;

final double padding = 16.0;

final darkGrey = Color(0xFF535353);

final lightBlue = Color(0xFF679AF1);
final darkBlue = Color(0xFF082352);

final lightYellow = Color(0xFFDFC598);
final darkYellow = Color(0xFFCEA661);

class UserPage extends StatefulWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double profilePictureRatio = contextHeight * 0.2;

    return Container(
      padding: EdgeInsets.only(left: padding, top: padding, right: padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            lightYellow,
            darkYellow,
          ],
        ),
      ),
      child: ListView(
        children: [
          Personal(contextHeight, profilePictureRatio),
        ],
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  ProfilePicture(this.profilePictureRatio);
  final double profilePictureRatio;

  Widget build(BuildContext context) {
    return Container(
      height: profilePictureRatio,
      width: profilePictureRatio,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            'https://img.favpng.com/2/24/4/user-profile-computer-icons-png-favpng-6CB3By2TFDKyEjfXFbx3LaRR5.jpg',
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class Personal extends StatelessWidget {
  Personal(this.contextHeight, this.profilePictureRatio);
  final double contextHeight;
  final double profilePictureRatio;

  Widget build(BuildContext context) {
    final innerHeight = contextHeight * 0.325;

    String fullNames = "Full Names";
    String username = "Username";
    String birthDate = "";

    if ((Globals.firstName != null) && (Globals.lastName != null)) {
      fullNames = Globals.firstName + " " + Globals.lastName;
    }
    if (Globals.username != null) {
      username = Globals.username;
    }
    if (Globals.birthDate != null) {
      birthDate = Globals.birthDate;
    }

    return Container(
      height: innerHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: (profilePictureRatio) / 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: (profilePictureRatio / 2) + padding,
                    child: Center(
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 0.2,
                        runSpacing: 0.2,
                        children: <Widget>[
                          Column(
                            children: [
                              // USER FULL NAMES
                              RichText(
                                text: TextSpan(
                                  text: fullNames,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: darkYellow,
                                  ),
                                ),
                              ),

                              // USER EMAIL ADDRESS
                              RichText(
                                text: TextSpan(
                                  text: username,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: darkGrey,
                                  ),
                                ),
                              ),

                              // USER BIRTH DATE
                              RichText(
                                text: TextSpan(
                                  text: birthDate,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: ProfilePicture(profilePictureRatio),
          ),
        ],
      ),
    );
  }
}
