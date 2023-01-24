import 'package:eagles_customer_app/usreType.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Authentication/splash_screen.dart';

Future<void> main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBfw-AQfk7DPNJXJsrbqjydm5aekKROU2E",
            authDomain: "eagles-2505e.firebaseapp.com",
            projectId: "eagles-2505e",
            storageBucket: "eagles-2505e.appspot.com",
            messagingSenderId: "147570494207",
            appId: "1:147570494207:web:9f01c32d9ed5ea57e5daca",
            measurementId: "G-QJD8GTPLWX"));
    // setPathUrlStrategy();
    runApp(const ParentApp());
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    runApp(const ParentApp());
  }
}

class ParentApp extends StatefulWidget {
  const ParentApp({Key? key}) : super(key: key);

  @override
  State<ParentApp> createState() => _ParentAppState();
}

class _ParentAppState extends State<ParentApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
