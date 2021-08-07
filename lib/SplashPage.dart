import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_app/SignInPage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ChartsPage.dart';

class SplashPage extends StatefulWidget {
  static const String route='/';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 2),
        () {
          if(FirebaseAuth.instance.currentUser!=null){
            Navigator.pushReplacementNamed(context, ChartsPage.route);
          }
          else{
            Navigator.pushReplacementNamed(context, SignInPage.route);
          }

        }
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 100,
                width: 100,
                child: CircleAvatar(backgroundImage: AssetImage('images/logo.jpg'),),
              ),
            ),
            SizedBox(
              height: 25,
            ),

            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
