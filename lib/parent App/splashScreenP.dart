import 'dart:async';
import 'package:eagles_customer_app/parent%20App/Screens/ManageProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../splashScreen.dart';
import '../userApp/homepage.dart';
import 'Authentication/LoginPageP.dart';


var scrHeight;
var scrWidth;

class SplashScreenP extends StatefulWidget {
  const SplashScreenP({Key? key}) : super(key: key);

  @override
  State<SplashScreenP> createState() => _SplashScreenPState();
}

class _SplashScreenPState extends State<SplashScreenP> {

  Future loginEvent() async {

    final preferences = await SharedPreferences.getInstance();
    if(currentParentId!=null){
      preferences.setString('parentId', currentParentId!);
    }else{
      currentParentId = preferences.getString('parentId') ?? "";
    }

    print('UserId : ' + currentParentId!);
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
                currentParentId == null || currentParentId == ""
                    ? const LoginPageP()
                    : const ManageProfile()
            ),
                (route) => false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
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
