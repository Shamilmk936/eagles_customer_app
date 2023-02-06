import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/userApp/premium/module_pdf.dart';
import 'package:eagles_customer_app/userApp/screens/home/MyProfile.dart';
import 'package:eagles_customer_app/userApp/screens/mcq/mcqList.dart';
import 'package:eagles_customer_app/userApp/screens/home/home.dart';

import 'package:flutter/material.dart';
import '../../authentication/auth.dart';
import '../../authentication/loginpage.dart';
import '../../authentication/otp.dart';
import '../../model/onlineStudents.dart';

String studentName = "";
String parentName = "";
String studentNo = "";
String parentNo = "";
String studentEmail = "";
String urlDp = "";

class MainPageC extends StatefulWidget {
  const MainPageC({Key? key}) : super(key: key);

  @override
  State<MainPageC> createState() => _MainPageCState();
}

//hhhhh
class _MainPageCState extends State<MainPageC> {
  @override
  getOnlineStudent() async {
    print('inside   get help');
    print(currentUserId);
    print('currentUserId');
    FirebaseFirestore.instance
        .collection("onlineStudents")
        .doc(currentUserId)
        .snapshots()
        .listen((event) async {
      print('event');
      print(event.data());

      currentStudent = await OSModel.fromJson(event.data()!);
      currentTopic = currentStudent?.currentTopic;
      currentModule = currentStudent?.currentModule;
      currentLesson = currentStudent?.currentLesson;
      print(currentStudent?.currentModule);
      print(currentModule);
      print(currentStudent?.OSId);
      print('1234567890');

      setState(() {});
    });
  }
  // getStudent() async {
  //   FirebaseFirestore.instance
  //       .collection('students')
  //       .doc(studentId)
  //       .snapshots()
  //       .listen((event) {
  //     if (event.exists) {
  //       studentName = event['name'];
  //       parentName = event['pName'];
  //       parentNo = event['pMobno'];
  //       studentNo = event['sMobno'];
  //       studentEmail = event['sEmail'];
  //       urlDp = event['profileImageUrl'];
  //     }
  //     setState(() {});
  //   });
  // }

  int _selectedIndex = 0;
  var visiblecheck = true;

  dynamic _widgetOptions = <Widget>[
    MyHome(),
    MyQuestionnaire(),
    Module_pdf(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getOnlineStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (_selectedIndex == 3 || _selectedIndex == 1) {
    //   setState(() {
    //     visiblecheck = false;
    //   });
    // }
    print(currentUserId);
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Visibility(
          visible: visiblecheck,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black54,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.wechat_sharp,
                  color: Colors.black54,
                ),
                label: 'MCQ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_pin,
                  color: Colors.black54,
                ),
                label: 'Premium',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black54,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
// YoutubePlayerBuilder(
// builder: (context, player) {
// return Column(
// children: [player],
// );
// },
// player: YoutubePlayer(
// controller: _controller,
// showVideoProgressIndicator: true,
// progressIndicatorColor: Colors.red,
// ),
// )
