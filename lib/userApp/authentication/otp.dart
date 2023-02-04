import 'package:eagles_customer_app/globals/firebase_variables.dart';
import 'package:eagles_customer_app/userApp/authentication/register.dart';
import 'package:eagles_customer_app/userApp/authentication/signup.dart';
import 'package:eagles_customer_app/userApp/authentication/signup.dart';
import 'package:eagles_customer_app/userApp/authentication/signup.dart';
import 'package:eagles_customer_app/userApp/stage.dart';
import 'package:eagles_customer_app/userApp/authentication/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

import '../../main.dart';
import 'signup.dart';

class OtpPage extends StatefulWidget {
  final String verId;
  final String number;
  final String name;
  const OtpPage(
      {Key? key, required this.verId, required this.number, required this.name})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController otpController = TextEditingController();
  FocusNode focusNode = FocusNode();

  var code;

  @override
  Widget build(BuildContext context) {
    var h = Utils().getScreenSize().height;
    var w = Utils().getScreenSize().width;
    //pinTheme
    final defaultPinTheme = PinTheme(
      width: w * 0.2,
      height: w * 0.14,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color(0xff464542),
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffE8EBF1),
        borderRadius: BorderRadius.circular(24),
      ),
    );

    final customCursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: w * 0.07,
        height: h * 0.002,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xff474647).withOpacity(
            .5,
          ),
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.red,
        body: Container(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.18,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/Verify anime.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Get Verified With',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                const Text('OTP',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                const SizedBox(height: 10),
                const Text('Enter the OTP below to verify your'),
                const Text('number'),
                const SizedBox(height: 10),
                Pinput(
                  length: 6,
                  controller: otpController,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  cursor: customCursor,
                  showCursor: true,
                  onCompleted: (value) async {
                    code = value;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(w * 0.7, h * 0.05),
                          backgroundColor: const Color(0XffE5097F)),
                      onPressed: () async {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verId,
                                smsCode: otpController.text);
                        await auth
                            .signInWithCredential(credential)
                            .then((value) async {
                          if (kDebugMode) {
                            print(value.user!.uid);
                          }
                          db.collection('onlineStudents').doc().set({
                            'osName': widget.name,
                            'mobNo': widget.number,
                          }).then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Stage())));
                        }).catchError((e) {
                          if (kDebugMode) {
                            print(e);
                          }
                          showSnackbar(context, 'Wrong OTP!!');
                        });
                      },
                      child: const Text('Verify')),
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
