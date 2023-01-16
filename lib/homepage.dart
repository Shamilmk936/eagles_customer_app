import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/Banner  01 vector.svg',
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 10),
            const Text('Grow Fast With',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const Text('Eagles',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            SizedBox(height: 10),
            const Text('An App for students to study for CA '),
            const Text('exams and to find relevant information'),
            const Text('in one place'),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XffE5097F)),
                onPressed: () {},
                child: const Text('Sign Up')),
            SizedBox(height: 10),
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
    );
  }
}
