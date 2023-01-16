import 'package:eagles_customer_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
        color: Color(0xffE8EBF1),
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
          color: Color(0xff474647).withOpacity(
            .5,
          ),
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
      ),
    );
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/Verify anime.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(height: 10),
              Text('Get Verified With',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              Text('OTP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              SizedBox(height: 10),
              Text('Enter the OTP below to verify your'),
              Text('number'),
              SizedBox(height: 10),
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
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(w * 0.7, h * 0.05),
                        backgroundColor: const Color(0XffE5097F)),
                    onPressed: () {},
                    child: const Text('Verify')),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Have An Account?'),
                  InkWell(
                      onTap: () {},
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
    );
  }
}
