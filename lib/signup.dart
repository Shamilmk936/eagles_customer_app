import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String countryCode = 'IN';
  String phoneCode = '+91';
  TextEditingController contactNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/signup.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(height: 10),
              const Text('Enter Your Mobile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const Text('Number',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              SizedBox(height: 10),
              const Text('We will send you a 4 digit OTP on your'),
              const Text('mobile number for verification'),
              SizedBox(height: 20),
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
                          color: Color(0xFFE6E6E6),
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          side: BorderSide(color: const Color(0XffE5097F)),
                          backgroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: SvgPicture.asset('assets/google.svg'),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Google',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          side: BorderSide(color: const Color(0XffE5097F)),
                          minimumSize: Size(100, 35),
                          backgroundColor: const Color(0XffE5097F)),
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                      )),
                ],
              ),
              SizedBox(height: 40),
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
