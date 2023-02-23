import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/main.dart';
import 'package:eagles_customer_app/parent%20App/Model/parentModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../userApp/authentication/loginPage.dart';
import 'Authentication/loginPageP.dart';
import 'Authentication/authP.dart';
import 'Screens/BtmNavBar/AttendancePage.dart';
import 'Screens/BtmNavBar/HomePageP.dart';
import 'Screens/BtmNavBar/LeavePage.dart';
import 'Screens/fineReportPage.dart';
import 'Screens/manageProfile.dart';
import 'Screens/BtmNavBar/ReportsPage.dart';
import 'Screens/profileUpload.dart';

String studentName = "";
String studentNo = "";
String studentEmail = "";
String urlDp = "";


setSearchParam(String caseNumber) {
  List<String> caseSearchList = <String>[];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;
}

class MainPageP extends StatefulWidget {
  const MainPageP({Key? key}) : super(key: key);

  @override
  State<MainPageP> createState() => _MainPagePState();
}

class _MainPagePState extends State<MainPageP> {
  @override
  void initState() {
    getStudent();
    print('MainPage');
    print(currentParent?.name);
    print(studentId);
    print(studentName);
    super.initState();
  }

  getStudent() async {
    FirebaseFirestore.instance
        .collection('candidates')
        .doc(studentId)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        studentName = event['name'];
        studentNo = event['mobile'];
        studentEmail = event['email'];
        urlDp = event['photo'];
      }
      setState(() {});
    });
  }

  int _selectedIndex = 0;
  var visiblecheck = true;

  dynamic _widgetOptions = <Widget>[
    HomePageP(),
    LeavePage(),
    ReportsPage(),
    AttendancePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 3 || _selectedIndex == 1) {
      setState(() {
        visiblecheck = false;
      });
    }
    return SafeArea(
      child: Scaffold(
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      topRight: Radius.circular(35)),
                  color: Colors.blueGrey,
                ),
                accountName: Text(studentName),
                accountEmail: Text(studentEmail),
                currentAccountPicture: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(urlDp),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.change_circle_outlined,
                  color: Colors.black54,
                ),
                title: const Text('Switch Student'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ManageProfile()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.black54,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePageP()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.leaderboard,
                  color: Colors.black54,
                ),
                title: const Text('Score Board'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ReportsPage()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.history_edu,
                  color: Colors.black54,
                ),
                title: const Text('Fine History'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FineReports()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.payment,
                  color: Colors.black54,
                ),
                title: Text('Payment'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
                title: Text('Settings & account'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AttendancePage()));
                },
              ),
              currentParent?.profileUrl == ''
                  ?ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
                title: Text('Upload Profile'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileUploadPage()));
                },
              )
                  :SizedBox(),
              ListTile(
                leading: Icon(
                  Icons.feedback,
                  color: Colors.black54,
                ),
                title: Text('Help & Feedback'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black54,
                  ),
                  title: Text('Log Out'),
                  onTap: () {
                    setState(() {
                      signOut(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPageP()));
                    });
                  }),
            ],
          ),
        ),
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
                  Icons.add_box_outlined,
                  color: Colors.black54,
                ),
                label: 'Leave',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.leaderboard,
                  color: Colors.black54,
                ),
                label: 'Reports',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_alt_sharp,
                  color: Colors.black54,
                ),
                label: 'Attendance',
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

// QuerySnapshot users =  FirebaseFirestore.instance
//     .collection('students')
//     .where('pMobno',isEqualTo:parentMob )
//     .get() as QuerySnapshot<Object?>;
