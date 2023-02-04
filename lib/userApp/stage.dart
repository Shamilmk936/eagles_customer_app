import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/userApp/authentication/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../globals/firebase_variables.dart';
import '../main.dart';
import 'planSelection.dart';

Map<String, dynamic> stageIdbyName = {};
var selected;

class Stage extends StatefulWidget {
  const Stage({
    Key? key,
  }) : super(key: key);

  @override
  State<Stage> createState() => _StageState();
}

class _StageState extends State<Stage> {
  bool bColor = false;
  int stages = 0;
  String selected = '';
  int price = 0;
  bool _fromTop = true;
  var stageData;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(29),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.arrow_back),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  const Text(
                    'Pick Your Stage',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: h * 0.07,
                  ),
                  Container(
                    height: h * 0.6,
                    padding: EdgeInsets.only(bottom: 30),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: db.collection('stage').snapshots(),
                        builder: (context, snapshot) {
                          var data = snapshot.data!.docs;
                          return ListView.builder(
                            // itemExtent: 100,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                                child: SizedBox(
                                  height: h * 0.1,
                                  width: w * 0.85,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: Color(0xffF3F3F3),
                                        ),
                                        height: h * 017,
                                        width: w * 0.85,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 68),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showGeneralDialog(
                                                    barrierLabel: "Label",
                                                    barrierDismissible: true,
                                                    barrierColor: Colors.black
                                                        .withOpacity(0.5),
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 700),
                                                    context: context,
                                                    pageBuilder: (context,
                                                        anim1, anim2) {
                                                      return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          height: h / 3,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 50,
                                                                  left: 12,
                                                                  right: 12),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          child: AlertDialog(
                                                            elevation: 0,
                                                            content:
                                                                SizedBox.expand(
                                                                    child: Text(
                                                              data[index][
                                                                  'description'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14),
                                                            )),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    transitionBuilder: (context,
                                                        anim1, anim2, child) {
                                                      return SlideTransition(
                                                        position: Tween(
                                                                begin: Offset(
                                                                    0, 1),
                                                                end: Offset(
                                                                    0, 0))
                                                            .animate(anim1),
                                                        child: child,
                                                      );
                                                    },
                                                  );
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  // color: Colors.green,
                                                  width: w * 0.5,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data[index]['name'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '${data[index]['name']} description is here',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  selected = data[index]['id'];
                                                  price = data[index]['price'];
                                                  print(stageData);
                                                  setState(() {});
                                                },
                                                child: SizedBox(
                                                  height: h * 0.1,
                                                  width: w * 0.13,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                          radius: h * 0.017,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: CircleAvatar(
                                                              radius: 7,
                                                              backgroundColor: data[
                                                                              index]
                                                                          [
                                                                          'id'] ==
                                                                      selected
                                                                  ? const Color(
                                                                      0XffE5097F)
                                                                  : const Color(
                                                                      0xffDADADA))),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: index == 0
                                              ? -8
                                              : index == 1
                                                  ? -16
                                                  : -22,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          bottom: 5,
                                          child: SvgPicture.network(
                                              data[index]['image'])),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          side: const BorderSide(color: Color(0XffE5097F)),
                          minimumSize: Size(w * 0.9, h * 0.05),
                          backgroundColor: selected == ''
                              ? const Color(0XffE5097F).withOpacity(0.3)
                              : const Color(0XffE5097F)),
                      onPressed: () {
                        print(selected);
                        if (selected == '') {
                          showSnackbar(context, 'Please pick a stage');
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlanSelectionPage(
                                    id: selected, price: price),
                              ));
                          // db.collection('onlineStudents').doc(selected).update({
                          //   'stage': selected,
                          // }).then((value) => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => PlanSelectionPage(
                          //           id: selected, price: price),
                          //     )));
                        }
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(fontSize: 18),
                      )),
                ]),
          ),
        ),
      ),
    );
  }
}

List personList = [
  {"person": 'assets/stage1.svg', "name": "Stage 01", "selected": false},
  {"person": 'assets/stage2.svg', "name": "Stage 02", "selected": false},
  {"person": 'assets/stage3.svg', "name": "Stage 03", "selected": false},
];
