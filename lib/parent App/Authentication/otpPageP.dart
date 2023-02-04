import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../main.dart';
import '../Screens/ManageProfile.dart';
import '../splashScreenP.dart';

class OtpPageP extends StatefulWidget {
  final String verId;
  final String number;

  const OtpPageP({
    Key? key,
    required this.verId,
    required this.number,
  }) : super(key: key);

  @override
  State<OtpPageP> createState() => _OtpPagePState();
}

class _OtpPagePState extends State<OtpPageP> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController otp = TextEditingController();
  List phList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: scrWidth * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: scrHeight * 0.008,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We have send a 6 digit OTP on \n +91 ${widget.number}",
                    style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                        fontSize: scrWidth * 0.05),
                  ),
                  SizedBox(
                    height: scrHeight * 0.008,
                  ),
                  Text(
                    "Enter the OTP below to verify your number",
                    style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w400,
                        fontSize: scrWidth * 0.035,
                        color: const Color(0xff000000).withOpacity(0.5)),
                  ),
                ],
              ),
              SizedBox(
                height: scrHeight * 0.048,
              ),
              Padding(
                padding: EdgeInsets.only(left: scrWidth * 0.018),
                child: Pinput(
                  controller: otp,
                  defaultPinTheme: PinTheme(
                      height: scrHeight * 0.06,
                      width: scrWidth * 0.12,
                      decoration: BoxDecoration(
                          color: const Color(0xffEEEEEE),
                          borderRadius: BorderRadius.circular(8))),
                  length: 6,
                ),
              ),
              SizedBox(
                height: scrHeight * 0.07,
              ),
              GestureDetector(
                onTap: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verId, smsCode: otp.text);
                  await auth
                      .signInWithCredential(credential)
                      .then((value) async {
                    print(value.user!.uid);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ManageProfile()));
                  }).catchError((e) {
                    print(e);
                    showSnackbar(context, 'Wrong OTP!!');
                  });
                },
                child: Container(
                  height: scrHeight * 0.055,
                  width: scrWidth * 0.87,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child:
                        Text("CONTINUE", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: scrHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> confirmQuitDialog(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
          title: const Text('Do You want to Quit?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No')),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.purpleAccent),
                )),
          ],
        ));
