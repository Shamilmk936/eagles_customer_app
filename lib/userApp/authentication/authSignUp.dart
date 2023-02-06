import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/userApp/homepage.dart';
import 'package:eagles_customer_app/userApp/model/onlineStudents.dart';
import 'package:eagles_customer_app/userApp/stage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals/firebase_variables.dart';
import '../../main.dart';
import 'otp.dart';

var userName;
var userImage;
var userEmail;
var finalUserId;
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
    userImage = userCredential.user?.photoURL;
    finalUserId = userCredential.user?.uid;
    userName = userCredential.user?.displayName;
    print(userEmail);
    DocumentSnapshot id = await db.collection('settings').doc('settings').get();
    var user = id["OSId"].toString();
    var uid = 'OS$user';

    try {
      print('---------------ew----------------------');

      await FirebaseFirestore.instance
          .collection('onlineStudents')
          .where('email', isEqualTo: userEmail.toString())
          .snapshots()
          .listen((event) {

        if (event.docs.isNotEmpty) {

          print('--------------------Not Found-----------------------------');
          showSnackbar(context, 'User already exist');
          signsOut(context);

        } else {
          db.collection('onlineStudents').doc(uid).set({
            "OSId": uid,
            "Name": userName,
            "email": userEmail,
            'stage': "",
            'currentLesson': 1,
            'currentModule': 1,
            'currentTopic': 1,
            'plan': "",
            'mobNo': "",
            "profile": userImage,
            'joinDate': DateTime.now()
          }).then((value) {
            currentUserId = uid;
            id.reference.update({'OSId': FieldValue.increment(1)});
          });
          print('--------------------Found-----------------------------');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Stage(),
              ),
                  (route) => false);
        }
      });
    } catch (ee) {
      print('-------------------------------------');
      print(ee.toString());
      print('-------------------------------------');
    } //hhhhh
  }
}

signsOut(BuildContext context) async {
  // await listenUserSub?.cancel();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
  currentStudent = OSModel();
  currentUserId ='';
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
