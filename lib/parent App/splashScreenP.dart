import 'dart:async';

import 'package:eagles_customer_app/parent%20App/Authentication/LoginPageP.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Authentication/root.dart';

var scrHeight;
var scrWidth;

class SplashScreenP extends StatefulWidget {
  const SplashScreenP({Key? key}) : super(key: key);

  @override
  State<SplashScreenP> createState() => _SplashScreenPState();
}

class _SplashScreenPState extends State<SplashScreenP> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPageP(),
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
