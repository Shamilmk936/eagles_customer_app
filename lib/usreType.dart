import 'package:eagles_customer_app/main.dart';
import 'package:eagles_customer_app/parent%20App/main.dart';
import 'package:eagles_customer_app/parent%20App/onBoarding/homepage.dart';
import 'package:flutter/material.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

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
                          return HomePage();
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
                          return ParentApp();
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
