import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:eagles_customer_app/userApp/authentication/auth.dart';
import 'package:eagles_customer_app/userApp/authentication/auth2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals/firebase_variables.dart';
import '../../main.dart';
import 'loginOtp.dart';
import 'otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? logverificationId;
  String? oTp, authenStatus = "";

  Future<void> verifyxPhoneNumber(BuildContext context) async {
    if (kDebugMode) {

      print(loginNumber.text);
    }
    await phoneAuth.verifyPhoneNumber(
      phoneNumber: '+91${loginNumber.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        if (mounted) {
          showSnackbar(context, 'OTP sent successfully.');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (kDebugMode) {
          print('-------');
        }
        if (kDebugMode) {
          print(e.message);
        }
        if (kDebugMode) {
          print('-------');
        }
      },
      codeSent: (String? verficationID, int? resendToken) {
        setState(() {
          logverificationId = verficationID;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => loginOtp(
                      verId: logverificationId!,
                      number: loginNumber.text,
                    )));
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        if (mounted) {
          setState(() {
            logverificationId = verificationID;
          });
        }
      },
      timeout: const Duration(seconds: 120),
    );
  }

  final FirebaseAuth phoneAuth = FirebaseAuth.instance;

  final Authentications _auths = Authentications();

  String countryCode = 'IN';
  String phoneCode = '+91';
  TextEditingController loginNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.red,
        body: Container(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: h * 0.18,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/login.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Welcome',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                const Text('Back!',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                const SizedBox(height: 15),
                const Text('We are happy to see you again. To use'),
                const Text('your account you should login first.'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: Text(countryCode),
                            ),
                            IconButton(
                              onPressed: () {
                                showCountryPicker(
                                  context: context,
                                  //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                  exclude: <String>['KN', 'MF'],
                                  favorite: <String>['SE'],
                                  //Optional. Shows phone code before the country name.
                                  showPhoneCode: true,
                                  onSelect: (country) {
                                    if (kDebugMode) {
                                      print(
                                          'Select country: ${country.displayName}');
                                    }
                                    if (kDebugMode) {
                                      print(country.flagEmoji);
                                    }
                                    countryCode =
                                        '${country.flagEmoji} ${country.phoneCode}';
                                    setState(() {});
                                  },
                                  // Optional. Sets the theme for the country list picker.
                                  countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: 5,

                                    // Optional. Sets the border radius for the bottomsheet.
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                    // Optional. Styles the search field.
                                    inputDecoration: InputDecoration(
                                      labelText: 'Search',
                                      hintText: 'Start typing to search',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color(0xFF8C98A8)
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                            ),
                            Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                maxLength: 10,
                                controller: loginNumber,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  String patttern = r'(^[0-9]*$)';
                                  RegExp regExp = RegExp(patttern);
                                  if (value!.isEmpty) {
                                    return "Mobile Number is Required";
                                  } else if (value.length != 10) {
                                    return "Mobile number must 10 digits";
                                  } else if (!regExp.hasMatch(value)) {
                                    return "Mobile Number must be digits";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(143, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            side: const BorderSide(color: Color(0XffE5097F)),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          _auths.signInxWithGoogle(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: SvgPicture.asset('assets/google.svg'),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Google',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            side: const BorderSide(color: Color(0XffE5097F)),
                            minimumSize: const Size(143, 40),
                            backgroundColor: const Color(0XffE5097F)),
                        onPressed: () async {
                          QuerySnapshot users = await db
                              .collection('onlineStudents')
                              .where('mobNo', isEqualTo: loginNumber.text)
                              .get();

                          if (users.docs.isNotEmpty) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("isLoggedIn", true);
                            verifyxPhoneNumber(context);
                          } else {
                            showSnackbar(context, "You have'nt registered yet");
                          }

                          setState(() {});
                        },
                        child: const Text(
                          'Get otp',
                        )),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
