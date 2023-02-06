import 'dart:async';

import 'package:eagles_customer_app/userApp/authentication/loginpage.dart';
import 'package:eagles_customer_app/userApp/screens/home/mainPageC.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

var status;

class _SplashScreenState extends State<SplashScreen> {
  Future loginEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status = prefs.getBool('isLoggedIn') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    loginEvent().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    status == true ? MainPageC() : LoginPage()),
            (route) => false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/eagles logo.jpg'),
            //         fit: BoxFit.fill)),
            child: SvgPicture.asset(
              'assets/eagles logo (1).svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
