import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/leaveModel.dart';
import '../MainPageP.dart';
import '../splashScreenP.dart';
import 'LoginPageP.dart';

class RootingPageP extends StatefulWidget {
  const RootingPageP({Key? key}) : super(key: key);

  @override
  State<RootingPageP> createState() => _RootingPagePState();
}

class _RootingPagePState extends State<RootingPageP> {
  bool signedIn = false;

  // getLoginStatus() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) async {
  //     if (user == null) {
  //       signedIn = false;
  //     } else {
  //       print("root pageee");
  //       print(user.phoneNumber);
  //       try {
  //         QuerySnapshot usrs = await FirebaseFirestore.instance
  //             .collection('parent')
  //             .where('phone', whereIn: [
  //           user.phoneNumber,
  //           "+91${user.phoneNumber}",
  //           "+91 ${user.phoneNumber}",
  //           user.phoneNumber?.substring(3),
  //           user.phoneNumber?.substring(4),
  //         ]).get();
  //
  //         if (usrs.docs.length > 0) {
  //           while (usrs.docs[0].get('userEmail') == "") {
  //             await Future.delayed(Duration(seconds: 1));
  //           }
  //           // getcurrentuser();
  //           signedIn = true;
  //         } else {
  //           getcurrentuser();
  //           signedIn = true;
  //         }
  //       } catch (e) {
  //         getcurrentuser();
  //         signedIn = true;
  //       }
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    scrHeight = MediaQuery.of(context).size.height;
    scrWidth = MediaQuery.of(context).size.width;

    return signedIn == true ? const MainPageP() : const LoginPageP();
  }
}
