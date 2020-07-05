import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser user;

  HomeScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "You are successfully logged in",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 36,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "${user.phoneNumber}",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
