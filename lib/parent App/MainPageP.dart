import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../userApp/authentication/auth.dart';
import '../userApp/authentication/loginpage.dart';
import 'Screens/LeavePage.dart';
import 'Screens/ManageProfile.dart';
import 'Screens/ReportsPage.dart';
import 'Screens/AttendancePage.dart';
import 'Screens/HomePageP.dart';

String studentName = "";
String parentName = "";
String studentNo = "";
String parentNo = "";
String studentEmail = "";
String urlDp = "";

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
        parentName = event['guardian'];
        parentNo = event['guardianNo'];
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
                  Icons.add_box_outlined,
                  color: Colors.black54,
                ),
                title: const Text('Apply Leave'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LeavePage()));
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
                              builder: (context) => const LoginPage()));
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
