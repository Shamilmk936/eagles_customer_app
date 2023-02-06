import 'dart:async';

import 'package:eagles_customer_app/userApp/authentication/loginPage.dart';
import 'package:eagles_customer_app/userApp/homepage.dart';
import 'package:eagles_customer_app/userApp/screens/home/mainPageC.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SplashScreenS extends StatefulWidget {
  const SplashScreenS({Key? key}) : super(key: key);

  @override
  State<SplashScreenS> createState() => _SplashScreenSState();
}

class _SplashScreenSState extends State<SplashScreenS> {

  Future loginEvent() async {
    final preferences = await SharedPreferences.getInstance();
    if(currentUserId!=null){
      preferences.setString('userId', currentUserId!);
    }else{
      currentUserId = preferences.getString('userId') ?? "";
    }

    print('UserId : ' + currentUserId!);
    setState(() {});
  }

//hhhhh
  @override
  void initState() {
    loginEvent().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                currentUserId == null || currentUserId == ""
                    ? const HomePage()
                    : const MainPageC()
            ),
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
