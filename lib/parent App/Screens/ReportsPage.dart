import 'package:flutter/material.dart';
import '../../main.dart';
import '../../splashScreen.dart';
import '../MainPageP.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
     h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios_sharp),
          color: Colors.black87,
          iconSize: h * 0.03,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainPageP()));
          },
        ),
        title: Text(
          'Reports',
          style: TextStyle(
            fontSize: h * 0.03,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: new Icon(Icons.edit),
            color: Colors.black87,
            iconSize: h * 0.03,
          ),
        ],
      ),
      body: Container(),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController mailInput = TextEditingController();
//   TextEditingController passwordInput = TextEditingController();
//
//   var loginKey = GlobalKey<FormState>();
//   bool _obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;
//     var h = MediaQuery.of(context).size.height;
//
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Container(
//         constraints: const BoxConstraints.expand(),
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("asset/images/wall.jpg"), fit: BoxFit.cover)),
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.black.withOpacity(0.2),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 190.0,
//                   width: 190.0,
//                   padding: const EdgeInsets.only(top: 40),
//                   child: Center(
//                     child: Image.asset('asset/images/Logo.png'),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 0),
//                   child: Form(
//                     key: loginKey,
//                     child: Container(
//                       alignment: Alignment.center,
//                       height: h * 0.6,
//                       width: w * 0.85,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.black.withOpacity(0.45),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Text(
//                                   'Sign In',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'Poppins',
//                                     fontSize: 30,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 40, left: 10),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     'E-Mail:',
//                                     style: TextStyle(
//                                         color: Colors.white.withOpacity(0.65),
//                                         fontFamily: 'Poppins',
//                                         fontSize: 16),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 12.0),
//                               child: TextFormField(
//                                 autofocus: false,
//                                 controller: mailInput,
//                                 decoration: InputDecoration(
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide(
//                                             width: 0, color: Colors.white)),
//                                     prefixIcon: const Icon(
//                                       Icons.person,
//                                       color: Colors.redAccent,
//                                     ),
//                                     fillColor: Colors.white,
//                                     filled: true,
//                                     hintText: 'E-Mail',
//                                     contentPadding: const EdgeInsets.all(15),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                         BorderRadius.circular(30)),
//                                     errorText: mailInput.text.isEmpty
//                                         ? null
//                                         : mailInput.text.contains('@')
//                                         ? null
//                                         : 'Enter a valid E-Mail'),
//                                 validator: (value) {
//                                   return 'Account not Found';
//                                 },
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 20, left: 10),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     'Password:',
//                                     style: TextStyle(
//                                         color: Colors.white.withOpacity(0.65),
//                                         fontFamily: 'Poppins',
//                                         fontSize: 16),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 12.0),
//                               child: TextFormField(
//                                 autofocus: false,
//                                 obscureText: _obscureText,
//                                 controller: passwordInput,
//                                 decoration: InputDecoration(
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide(
//                                             width: 0, color: Colors.white)),
//                                     prefixIcon: const Icon(
//                                       Icons.lock_open_outlined,
//                                       color: Colors.redAccent,
//                                     ),
//                                     suffixIcon: IconButton(
//                                       focusColor: Colors.grey,
//                                       onPressed: () {
//                                         setState(() {
//                                           _obscureText = !_obscureText;
//                                         });
//                                       },
//                                       icon: Icon(_obscureText
//                                           ? Icons.visibility
//                                           : Icons.visibility_off),
//                                     ),
//                                     fillColor: Colors.white,
//                                     filled: true,
//                                     hintText: 'Password',
//                                     contentPadding: const EdgeInsets.all(15),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                         BorderRadius.circular(30)),
//                                     errorText: passwordInput.text.isEmpty
//                                         ? null
//                                         : passwordInput.text.length < 8
//                                         ? 'Password should be min of 8 character'
//                                         : null),
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: const [
//                                 TextButton(
//                                     onPressed: null,
//                                     child: Text(
//                                       'forgot password?',
//                                       style: TextStyle(color: Colors.white),
//                                     ))
//                               ],
//                             ),
//                             Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   if (loginKey.currentState!.validate()) {}
//                                   if (mailInput.text == 'sidhi@gmail.com' &&
//                                       passwordInput.text == 'sidhi123') {
//                                     Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                             const BottomNav()));
//                                   }
//                                 },
//                                 child: Container(
//                                   width: w * 0.4,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(50),
//                                     color: Colors.redAccent,
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       'Sign In',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
