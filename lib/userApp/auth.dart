import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/userApp/homepage.dart';
import 'package:eagles_customer_app/userApp/stage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

var userName;
var userImage;
var userEmail;
var phone;
String? userDoc;
Timestamp? dateTime;

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    userEmail = userCredential.user?.email;
    print(userEmail);

    try {
      print('---------------ew----------------------');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Stage(),
          ));

      // QuerySnapshot users = await FirebaseFirestore.instance
      //     .collection('parent')
      //     .where('userEmail', isEqualTo: userEmail.toString()).get();

      // if (users.docs.isNotEmpty) {
      //      Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => MainPage(),
      //         ),
      //             (route) => false);
      //
      // }
      // else {
      //   print('error');
      //   showSnackbar(context, 'Parent Email is Invalid');
      // }
    } catch (ee) {
      print('-------------------------------------');
      print(ee.toString());
      print('-------------------------------------');
    }
  }
}

signOut(BuildContext context) async {
  // await listenUserSub?.cancel();
  GoogleSignIn().disconnect();
  await FirebaseAuth.instance
      .signOut()
      .then((value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (route) => false));
}
