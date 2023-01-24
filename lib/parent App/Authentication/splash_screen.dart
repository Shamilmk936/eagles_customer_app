import 'dart:async';
import 'package:eagles_customer_app/parent%20App/Authentication/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

var scrHeight;
var scrWidth;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final _localNotificationService= FlutterLocalNotificationsPlugin();
  // late final LocalNotificationService service;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Rootingpage(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: scrHeight * 0.062),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/eagleslogo.svg',
                    fit: BoxFit.scaleDown,
                  ),
                  CircularProgressIndicator(color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
