import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../main.dart';
import '../../../splashScreen.dart';
import '../../Authentication/authP.dart';
import '../../mainPageP.dart';
import '../manageProfile.dart';

class HomePageP extends StatefulWidget {
  const HomePageP({Key? key}) : super(key: key);

  @override
  State<HomePageP> createState() => _HomePagePState();
}

class _HomePagePState extends State<HomePageP> {
  // getStudent() async {
  //   DocumentSnapshot sUser = await FirebaseFirestore.instance
  //       .collection('students')
  //       .doc(studentId)
  //       .get();
  //   studentName = sUser['name'];
  //   parentName = sUser['pName'];
  //   parentNo = sUser['pMobno'];
  //   studentNo = sUser['sMobno'];
  //   studentEmail = sUser['sEmail'];
  //   urlDp = sUser['profileImageUrl'];
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    // getStudent();
    if (kDebugMode) {
      print('HomePage');
      print(studentId);
      print(studentName);
    }
  }

  @override
  Widget build(BuildContext context) {
     h = MediaQuery.of(context).size.height;
     w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: new Icon(Icons.supervised_user_circle),
          color: Colors.black87,
          iconSize: h * 0.03,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ManageProfile()));
            setState(() {});
          },
        ),
        // title: Text('My students',
        //   style: TextStyle(
        //     fontSize: 17,
        //     fontWeight: FontWeight.w500,
        //     color: Colors.black,
        //   ),
        // ),

        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: new Icon(Icons.logout),
            color: Colors.black87,
            iconSize: h * 0.03,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // Text('Current Student : $studentName'),
            SizedBox(
              height: 300,
              width: 300,
              // decoration: BoxDecoration(              //     image: DecorationImage(
              //         image: AssetImage('assets/eagles logo.jpg'),
              //         fit: BoxFit.fill)),
              child: SvgPicture.asset(
                'assets/eagleslogo.svg',
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XffE5097F)),
                onPressed: () {
                  signOut(context);
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
