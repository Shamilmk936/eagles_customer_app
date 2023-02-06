import 'dart:async';
import 'package:eagles_customer_app/userType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

var h;
var w;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const UserType(),
          ),
              (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: h * 0.062),
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
