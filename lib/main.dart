import 'package:eagles_customer_app/userApp/homepage.dart';
import 'package:eagles_customer_app/userApp/otp.dart';
import 'package:eagles_customer_app/userApp/planSelection.dart';
import 'package:eagles_customer_app/userApp/signup.dart';
import 'package:eagles_customer_app/userApp/splashScreen.dart';
import 'package:eagles_customer_app/userApp/stage.dart';
import 'package:eagles_customer_app/userType.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const StudentApp());
}

class StudentApp extends StatefulWidget {
  const StudentApp({Key? key}) : super(key: key);

  @override
  State<StudentApp> createState() => _StudentAppState();
}

class _StudentAppState extends State<StudentApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserType(),
    );
  }
}

showSnackbar(BuildContext context, String content) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      content,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
    backgroundColor: Colors.white,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(25)),
// side: const BorderSide(color: Color(0XffE5097F)),
// minimumSize: const Size(290, 39),
// backgroundColor: const Color(0XffE5097F)),
// onPressed: () {
// signOut(context);
// },
// child: const Text(
// 'Sign Out',
// style: TextStyle(fontSize: 18),
// )),
