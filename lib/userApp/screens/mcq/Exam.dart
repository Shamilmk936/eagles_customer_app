import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../main.dart';
import '../../homepage.dart';

var myColor = const Color(0xFF164679);
var dash = const Color(0xffebebf5);

class Exam extends StatefulWidget {
  final String examId;
  const Exam({
    Key? key,
    required this.examId,
  }) : super(key: key);

  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  ScrollController _scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    startExam();
    //
    // html.window.onBeforeUnload.listen((event) async {
    //   // do something
    //   print("html");
    //   // FirebaseFirestore.instance.collection('exams').doc(widget.examId).update(
    //   //     {
    //   //       'answerSheet':completed,
    //   //
    //   //       'status':-1,
    //   //
    //   //     });
    //   updateExam(widget.examId, completed);
    //   print("html end");
    // });

    super.initState();
  }

  @override
  void dispose() {
    print("dispoooose");
    FirebaseFirestore.instance.collection('exams').doc(widget.examId).update({
      'answerSheet': completed,
      'status': -1,
    });
    print("dispose end");
    super.dispose();
  }

  void showUploadMessage(BuildContext context, String message,
      {bool showLoading = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          backgroundColor: Colors.red,
          // shape: ShapeBorder,
          duration: showLoading
              ? const Duration(minutes: 30)
              : const Duration(seconds: 4),
          content: Row(
            children: [
              if (showLoading)
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: CircularProgressIndicator(),
                ),
              Text(message),
            ],
          ),
        ),
      );
  }

//hhhhh
  Map<String, dynamic>? exam;
  List questionPaper = [];
  List completed = [];
  List<int> skipped = [];
  int currentIndex = 0;
  int completedCount = 0;
  startExam() {
    FirebaseFirestore.instance
        .collection('exams')
        .doc(widget.examId)
        .snapshots()
        .listen((event) async {
      exam = event.data();

      for (var topic in exam!['topics'].keys.toList() ?? []) {
        List originalList = [];
        DocumentSnapshot<Map<String, dynamic>> topics = await FirebaseFirestore
            .instance
            .collection("topics")
            .doc(topic)
            .get();
        originalList = topics['questions'];
        Random random = new Random();
        int noOfQuestions = exam!['topics'][topic];
        for (var i = 0; i < noOfQuestions; i++) {
          int randomIndex = random.nextInt(originalList.length);
          questionPaper.add(originalList[randomIndex]);
          originalList.removeAt(randomIndex);
        }
      }
      try {
        if (exam!['answerSheet'] != null) {
          completed = exam!['answerSheet'];
        }
      } catch (e) {
        print(e.toString());
      }
      print(questionPaper);
      setState(() {});
    });
  }

  String answer = "";
  var question = {};
  @override
  Widget build(BuildContext context) {
    completedCount = 0;
    for (var a in completed) {
      if (a['submitted'] != "") {
        completedCount = completedCount + 1;
      }
    }
    print("build");
    print(exam);
    if (exam != null && questionPaper.isNotEmpty) {
      print("here");
      question = questionPaper[currentIndex];
      print("here2");
      if (question['submitted'] != null) {
        print("here3");
        // question = completed[currentIndex];
        print(completed);
        print("here4");
        answer = question['submitted'];
      } else {
        answer = "";
      }
    }
    print("cccccccc");
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: dash,
      body: SafeArea(
        child: exam == null
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE0E3E7),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(2, 2, 2, 2),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: exam!['studentProfileUrl'] ==
                                                  ""
                                              ? const SizedBox(
                                                  width: 80,
                                                  height: 80,
                                                )
                                              : Image.network(
                                                  exam!['studentProfileUrl'],
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 0, 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            exam!['studentName'],
                                            style: const TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF0F1113),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            exam?['certificationName'] ?? "",
                                            style: const TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF4B39EF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 15, 0, 0),
                                      child: Text(
                                        'Time Left : ',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 15, 0, 0),
                                      child: Text(
                                        '01:38:31',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFFDC0000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.02),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24, 54, 24, 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Question -  ${currentIndex + 1}/100',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Answered -  ${completedCount}',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Skipped -  ${skipped.length}',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Pending -  ${100 - completedCount}',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 5, 0),
                                          child: Text(
                                            'Q:',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 8, 0),
                                          child: Text(
                                            question['question'],
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.deepPurple,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Text(
                                      'Select Answer',
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 25),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            answer = "A";
                                            var qstn = question;
                                            qstn['submitted'] = answer;
                                            if (completed.length >
                                                currentIndex) {
                                              completed.removeAt(currentIndex);
                                              completed.insert(
                                                  currentIndex, qstn);
                                            }
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 15, 0, 0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                width: 500,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: answer == "A"
                                                      ? Colors.teal
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          15, 0, 15, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'A',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        question['A'],
                                                        style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Icon(
                                                        answer == "A"
                                                            ? Icons
                                                                .radio_button_checked
                                                            : Icons
                                                                .radio_button_off_rounded,
                                                        color: Colors.red,
                                                        size: 24,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            answer = "B";
                                            var qstn = question;
                                            qstn['submitted'] = answer;
                                            if (completed.length >
                                                currentIndex) {
                                              completed.removeAt(currentIndex);
                                              completed.insert(
                                                  currentIndex, qstn);
                                            }
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 15, 0, 0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                width: 500,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: answer == "B"
                                                      ? Colors.teal
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          15, 0, 15, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'B',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        question['B'],
                                                        style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Icon(
                                                        answer == "B"
                                                            ? Icons
                                                                .radio_button_checked
                                                            : Icons
                                                                .radio_button_off_rounded,
                                                        color: Colors.red,
                                                        size: 24,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            answer = "C";
                                            var qstn = question;
                                            qstn['submitted'] = answer;
                                            if (completed.length >
                                                currentIndex) {
                                              completed.removeAt(currentIndex);
                                              completed.insert(
                                                  currentIndex, qstn);
                                            }
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 15, 0, 0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                width: 500,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: answer == "C"
                                                      ? Colors.teal
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          15, 0, 15, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'C',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        question['C'],
                                                        style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Icon(
                                                        answer == "C"
                                                            ? Icons
                                                                .radio_button_checked
                                                            : Icons
                                                                .radio_button_off_rounded,
                                                        color: Colors.red,
                                                        size: 24,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            answer = "D";
                                            var qstn = question;
                                            qstn['submitted'] = answer;
                                            if (completed.length >
                                                currentIndex) {
                                              completed.removeAt(currentIndex);
                                              completed.insert(
                                                  currentIndex, qstn);
                                            }
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 15, 0, 0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                width: 500,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: answer == "D"
                                                      ? Colors.teal
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          15, 0, 15, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'D',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        question['D'],
                                                        style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Icon(
                                                        answer == "D"
                                                            ? Icons
                                                                .radio_button_checked
                                                            : Icons
                                                                .radio_button_off_rounded,
                                                        color: Colors.red,
                                                        size: 24,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (currentIndex == 0) {
                                            currentIndex = 99;
                                            // showUploadMessage(context,
                                            //     "Starting of the index!");
                                          } else {
                                            currentIndex--;
                                          }
                                          answer = "";
                                          setState(() {});
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Previous',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: myColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (currentIndex == 99) {
                                            currentIndex = 0;
                                          } else {
                                            currentIndex++;
                                          }
                                          var qstn = question;
                                          qstn['submitted'] = "";
                                          if (completed.length > currentIndex) {
                                            completed.removeAt(currentIndex);
                                            completed.insert(
                                                currentIndex, qstn);
                                          } else {
                                            completed.add(qstn);
                                          }
                                          answer = "";
                                          if (!skipped.contains(currentIndex)) {
                                            skipped.add(currentIndex);
                                          }

                                          setState(() {});
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: myColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Skip',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (answer != "") {
                                            if (currentIndex == 99) {
                                              currentIndex = 0;
                                            } else {
                                              currentIndex++;
                                            }

                                            var qstn = question;
                                            qstn['submitted'] = answer;
                                            if (completed.length >
                                                currentIndex) {
                                              completed.removeAt(currentIndex);
                                              completed.insert(
                                                  currentIndex, qstn);
                                            } else {
                                              completed.add(qstn);
                                            }

                                            answer = "";
                                            skipped.remove(currentIndex);
                                            setState(() {});
                                          } else {
                                            showUploadMessage(
                                                context, 'Select a option');
                                          }
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: myColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Next',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (completed.length != 100) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Do you want to submit your exam?"),
                                                  content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            "Total Answered Questions: ${completed.length}"),
                                                        Text(
                                                            "Total Skipped Questions: ${skipped.length}"),
                                                        Text(
                                                            "Total Pending Questions: ${100 - completed.length}"),
                                                      ]),
                                                );
                                              },
                                            );
                                            // showUploadMessage(context,
                                            //     'Answer all questions');
                                          } else {
                                            int marks = 0;
                                            for (var a in completed) {
                                              if (a['submitted'] == a['ans']) {
                                                marks++;
                                              }
                                            }
                                            FirebaseFirestore.instance
                                                .collection('exams')
                                                .doc(widget.examId)
                                                .update({
                                              'answerSheet': completed,
                                              'marks': marks,
                                              'status': 1,
                                              'pass': marks > 49 ? true : false,
                                            });
                                          }
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: myColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Submit',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.02),
                                  const Text(
                                    'Skipped Questions ',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: h * 0.02),
                                  SizedBox(
                                    height: h * 0.4,
                                    child: GridView.builder(
                                        primary: false,
                                        controller: _scrollController,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 60),
                                        scrollDirection: Axis.vertical,
                                        itemCount: skipped.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              currentIndex = skipped[index] - 1;
                                              setState(() {});
                                            },
                                            child: Wrap(children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red,
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  (skipped[index]).toString(),
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18,
                                                  ),
                                                )),
                                              ),
                                            ]),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.02),
                          // SizedBox(
                          //   height: 500,
                          //   width: 300,
                          //   child: Column(
                          //     children: [
                          //       Expanded(child: Text(completed.toString()))
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
