// import 'package:eagles_customer_app/userApp/homepage.dart';
// import 'package:eagles_customer_app/userApp/screens/home/mainPageC.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// var userdata;
// String? userid;
//
// class Routing extends StatefulWidget {
//   Routing({Key? key}) : super(key: key);
//
//   @override
//   State<Routing> createState() => _RoutingState();
// }
//
// class _RoutingState extends State<Routing> {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//           body: StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator();
//               } else if (snapshot.hasData) {
//                 userdata = snapshot.data!;
//                 userid = userdata.uid;
//                 return MainPageC();
//               } else if (snapshot.hasError) {
//                 return const Center(child: Text('Something Went Wrong'));
//               } else {
//                 return const HomePage();
//               }
//             }),
//       );
// }
