import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:eagles_customer_app/parent%20App/Authentication/otpPageP.dart';
import 'package:eagles_customer_app/userApp/authentication/loginpage.dart';
import 'package:eagles_customer_app/userApp/authentication/otp.dart';
import 'package:eagles_customer_app/userApp/authentication/auth.dart';
import 'package:eagles_customer_app/userApp/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';
import '../homepage.dart';

TextEditingController contactNumber = TextEditingController();

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? verificationId;
  String? otp, authStatus = "";

  Future<void> verifyPhoneNumber(BuildContext context) async {
    if (kDebugMode) {
      print(contactNumber.text);
    }
    await phoneAuth.verifyPhoneNumber(
      phoneNumber: '+91${contactNumber.text}',
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
          verificationId = verficationID;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OtpPage(
                      verId: verificationId!,
                      number: contactNumber.text,
                      name: fullName.text,
                    ))).then((value) {
          fullName.clear();
          contactNumber.clear();
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        if (mounted) {
          setState(() {
            verificationId = verificationID;
          });
        }
      },
      timeout: const Duration(seconds: 120),
    );
  }

  final FirebaseAuth phoneAuth = FirebaseAuth.instance;

  final Authentication _auth = Authentication();

  String countryCode = 'IN';
  String phoneCode = '+91';

  final fullName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.red,
        body: Container(
          padding: const EdgeInsets.all(13),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: h * 0.1,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/signup.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Enter Your Details',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE6E6E6)),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: fullName,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Fulll Name'),
                  ),
                ),
                // const Text('We will send you a 6 digit OTP on your'),
                // const Text('mobile number for verification'),
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
                                    bottomSheetHeight: 500,

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
                                controller: contactNumber,
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
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        side: const BorderSide(color: Color(0XffE5097F)),
                        minimumSize: const Size(100, 35),
                        backgroundColor: const Color(0XffE5097F)),
                    onPressed: () async {
                      if (fullName.text.isNotEmpty &&
                          contactNumber.text.length == 10) {
                        verifyPhoneNumber(context);
                        setState(() {});
                      } else {
                        showSnackbar(context, 'Enter your details please');
                      }
                    },
                    child: const Text('Sign Up')),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 10,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                          fontSize: w * 0.03,
                          color: Color(0xff000000),
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            side: const BorderSide(color: Color(0XffE5097F)),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          _auth.signInWithGoogle(context);
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
                            backgroundColor: Colors.white),
                        onPressed: () {
                          _auth.signInWithGoogle(context);
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
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already Have An Account?'),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// signInWithGoogle() async {
//   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//   AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//   UserCredential userCredential =
//       await FirebaseAuth.instance.signInWithCredential(credential);
//   var userid = userCredential.user?.uid;
//   var username = userCredential.user?.displayName;
//   var userimage = userCredential.user?.photoURL;
//   var useremail = userCredential.user?.email;
//
//   FirebaseFirestore.instance.collection('users').doc(userid).set({
//     "userid": userid,
//     "username": username,
//     "useremail": useremail,
//     "userimage": userimage,
//   });
// }
