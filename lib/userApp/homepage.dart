import 'package:eagles_customer_app/userApp/authentication/loginpage.dart';
import 'package:eagles_customer_app/userApp/screens/home/mainPageC.dart';
import 'package:eagles_customer_app/userApp/screens/mcq/mcq.dart';
import 'package:eagles_customer_app/userApp/authentication/signup.dart';
import 'package:eagles_customer_app/userApp/stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

var h;
var w;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Stage(),
                      ));
                },
                icon: Icon(Icons.account_tree_sharp))
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        // backgroundColor: Colors.red,
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/Banner  01 vector.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(height: 10),
              const Text('Grow Fast With',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const Text('Eagles',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(height: 10),
              const Text('An App for students to study for CA '),
              const Text('exams and to find relevant information'),
              const Text('in one place'),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XffE5097F)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ));
                  },
                  child: const Text('Sign Up')),
              const SizedBox(height: 10),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
