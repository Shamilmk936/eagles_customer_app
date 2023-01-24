import 'package:eagles_customer_app/userApp/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';
import 'planSelection.dart';

class Stage extends StatefulWidget {
  const Stage({
    Key? key,
  }) : super(key: key);

  @override
  State<Stage> createState() => _StageState();
}

class _StageState extends State<Stage> {
  bool bColor = false;
  int stage = 0;

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
                  SizedBox(
                    height: h * 0.1,
                    width: w * 0.85,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              print('start');
                            }
                            bColor = true;
                            stage = 1;
                            setState(() {});
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Color(0xffF3F3F3),
                            ),
                            height: h * 017,
                            width: w * 0.85,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 68),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Stage 01',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Stage 01 description is here',
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: stage == 1
                                                ? const Color(0XffE5097F)
                                                : const Color(0xffDADADA))),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: -13,
                            right: 240,
                            bottom: 5,
                            child: SvgPicture.asset('assets/stage1.svg')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.07,
                  ),
                  SizedBox(
                    height: h * 0.1,
                    width: w * 0.85,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            bColor = true;
                            stage = 2;
                            setState(() {});
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Color(0xffF3F3F3),
                            ),
                            height: h * 017,
                            width: w * 0.85,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 68),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Stage 02',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Stage 02 description is here',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xffDADADA)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 7,
                                        backgroundColor: stage == 2
                                            ? const Color(0XffE5097F)
                                            : const Color(0xffDADADA),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: -23,
                            right: 240,
                            bottom: 5,
                            child: SvgPicture.asset('assets/stage2.svg')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.07,
                  ),
                  SizedBox(
                    height: h * 0.1,
                    width: w * 0.85,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            bColor = true;
                            stage = 3;
                            setState(() {});
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Color(0xffF3F3F3),
                            ),
                            height: h * 017,
                            width: w * 0.85,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 68),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Stage 03',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Stage 03 description is here',
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: stage == 3
                                                ? const Color(0XffE5097F)
                                                : const Color(0xffDADADA))),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: -30,
                            right: 240,
                            bottom: 5,
                            child: SvgPicture.asset('assets/stage3.svg')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.16,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          side: const BorderSide(color: Color(0XffE5097F)),
                          minimumSize: const Size(290, 39),
                          backgroundColor: stage == 0
                              ? const Color(0XffE5097F).withOpacity(0.3)
                              : const Color(0XffE5097F)),
                      onPressed: () {
                        if (stage == 0) {
                          showSnackbar(context, 'Please pick a stage');
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PlanSelectionPage(),
                              ));
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
