import 'package:eagles_customer_app/parent%20App/Authentication/loginPageP.dart';
import 'package:eagles_customer_app/parent%20App/splashScreenP.dart';
import 'package:eagles_customer_app/userApp/authentication/routing.dart';
import 'package:eagles_customer_app/userApp/authentication/signup.dart';
import 'package:eagles_customer_app/userApp/homepage.dart';
import 'package:eagles_customer_app/userApp/splashScreenS.dart';
import 'package:flutter/material.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

//hhhhh
class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        side: const BorderSide(color: Color(0XffE5097F)),
                        minimumSize: const Size(143, 40),
                        backgroundColor: const Color(0XffE5097F)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SplashScreenS();
                        },
                      ));
                    },
                    child: const Text(
                      'Student',
                    )),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        side: const BorderSide(color: Color(0XffE5097F)),
                        minimumSize: const Size(143, 40),
                        backgroundColor: const Color(0XffE5097F)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SplashScreenP();
                        },
                      ));
                    },
                    child: const Text(
                      'Parent',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
