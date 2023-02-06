import 'package:carousel_slider/carousel_slider.dart';
import 'package:eagles_customer_app/userApp/authentication/otp.dart';
import 'package:eagles_customer_app/userApp/model/onlineStudents.dart';
import 'package:eagles_customer_app/userApp/premium/moduleList.dart';
import 'package:eagles_customer_app/userApp/screens/home/homeList.dart';
import 'package:eagles_customer_app/userApp/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../globals/firebase_variables.dart';
import '../../../parent App/Authentication/authP.dart';
import '../../../parent App/MainPageP.dart';
import '../../authentication/auth.dart';
import '../../authentication/loginpage.dart';
import '../../homepage.dart';

int? currentTopic;
int? currentModule;
int? currentLesson;

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List module = [];
  List topic = [];

  getTopics() async {
    topic = [];
    print(currentStudent?.stage);
    while (currentStudent?.stage == null ||
        currentStudent?.stage == '' ||
        currentStudent?.stage == 'null') {
      await Future.delayed(Duration(seconds: 1));
    }
    db
        .collection('topic')
        .where('stage', isEqualTo: currentStudent?.stage)
        // .orderBy('sNo', descending: true)
        .snapshots()
        .listen((event) {
      topic = event.docs;
      print(topic);
      setState(() {});
    });
  }

  @override
  void initState() {
    getTopics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(currentUserId);
    return Scaffold(
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
                  Icons.home,
                  color: Colors.black54,
                ),
                title: const Text('Home'),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const HomePageP()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.leaderboard,
                  color: Colors.black54,
                ),
                title: const Text('Score Board'),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const ReportsPage()));
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
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => AttendancePage()));
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
                      signsOut(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()));
                    });
                  }),
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                actions: [
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xffF3F3F3),
                      child: SvgPicture.asset('assets/profile.svg'),
                    ),
                  ),
                  SizedBox(width: 20)
                ],
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      child: SvgPicture.asset('assets/stage1.svg'),
                    ),
                    SizedBox(width: 7),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Day',
                            style: TextStyle(
                                fontSize: 15, color: Color(0xff121212))),
                        Text('${currentStudent?.sName}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                backgroundColor: Colors.white,
                elevation: 10.0,
                automaticallyImplyLeading: false,
                expandedHeight: h * 0.16,
                toolbarHeight: h * 0.12,
                floating: true,
                snap: true,
              )
            ];
          },
          body: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            // color: Colors.green,
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: h * 0.14,
                  width: w * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      gradient: LinearGradient(
                          colors: [Color(0xffE5097F), Color(0xff3D2F84)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                ),
                SizedBox(height: h * 0.02),
                Row(
                  children: [
                    SizedBox(width: w * 0.023),
                    Text(
                      'Student Area',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: h * 0.15,
                  width: w * 0.85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: Color(0xffE1E1E1))),
                  child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      crossAxisCount: 4,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xffF3F3F3),
                              child: SvgPicture.asset(
                                'assets/analytics.svg',
                                width: 22,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Text('Analytics', style: TextStyle(fontSize: 12))
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xffF3F3F3),
                              child: SvgPicture.asset(
                                'assets/leader.svg',
                                width: 25,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Text('Leaderboard', style: TextStyle(fontSize: 12))
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xffF3F3F3),
                              child: SvgPicture.asset(
                                'assets/discussion.svg',
                                width: 24,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Text('Discussion', style: TextStyle(fontSize: 12))
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xffF3F3F3),
                              child: SvgPicture.asset(
                                'assets/exams.svg',
                                width: 23,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Text('Exams', style: TextStyle(fontSize: 12))
                          ],
                        ),
                      ]),
                ),
                SizedBox(height: h * 0.02),
                CarouselSlider(
                  options: CarouselOptions(
                      animateToClosest: true,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 150.0),
                  items: [5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/kennan2.jpg'),
                                fit: BoxFit.contain),
                            // color: Colors.amber
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: h * 0.02),
                Row(
                  children: [
                    SizedBox(width: w * 0.023),
                    Text(
                      'Topics',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  // height: h * 0.22,
                  // width: w * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: Color(0xffE1E1E1))),
                  child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 90,
                          childAspectRatio: 3 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: topic.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Column(
                          children: [
                            currentTopic! >= topic[index]['sNo']
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ModuleList(
                                                  topic: topic[index].data())));
                                    },
                                    child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Color(0xffF3F3F3),
                                      child: SvgPicture.asset(
                                        'assets/exams.svg',
                                        width: 23,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Color(0xffF3F3F3),
                                    child: Icon(Icons.error),
                                  ),
                            SizedBox(height: 5),
                            Text(topic[index]['topicName'],
                                style: TextStyle(fontSize: 12))
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
