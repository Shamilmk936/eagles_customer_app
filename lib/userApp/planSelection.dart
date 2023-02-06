import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/userApp/screens/home/mainPageC.dart';
import 'package:eagles_customer_app/userApp/stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../globals/firebase_variables.dart';

class PlanSelectionPage extends StatefulWidget {
  String stage;
  final String id;
  int price;
  PlanSelectionPage(
      {Key? key, required this.stage, required this.price, required this.id})
      : super(key: key);

  @override
  State<PlanSelectionPage> createState() => _PlanSelectionPageState();
}

class _PlanSelectionPageState extends State<PlanSelectionPage> {
  bool bColor = false;
  int sPlan = 0;

  bool isVisible = false;
  bool istVisible = false;
  DateTime dayss = DateTime.now().add(const Duration(days: 365));
  DateFormat formatter = DateFormat('dd-mm-yyyy');
  // String? dt = formatter.y;
  List plan = [];
  List stage = [];
  // String? feeOne;
  // String? feeThree;
  // String? feeSix;
  // String? feeYear;
  // String? feeYears;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPageC()));
                  },
                  child: Text('Skip'))
            ],
          ),
          const SizedBox(height: 20),
          SvgPicture.asset('assets/plan.svg'),
          const Text('Eagles Packages',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('Unlock all Videos, Classes, Tests &',
              style: TextStyle(color: Colors.grey)),
          const Text('Notes.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  sPlan = 1;
                  bColor = true;
                  setState(() {});
                },
                child: Container(
                  height: h * 0.15,
                  width: w * 0.27,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0XFFF3F3F3),
                      border: Border.all(
                          color: sPlan == 1
                              ? const Color(0XffE5097F)
                              : const Color(0xffDADADA)),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Yearly',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text(' Valid till',
                          style: TextStyle(color: Colors.grey)),
                      Text(
                        (DateTime.now()
                            .add(const Duration(days: 365))
                            .toString()
                            .substring(0, 10)),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text('₹ ${widget.price}',
                          style: const TextStyle(
                              color: Color(0xffE5097F),
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(left: 11, right: 11),
            height: h * 0.07,
            width: w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0XFFF3F3F3),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 16,
                  child: SvgPicture.asset(
                    'assets/offer.svg',
                    width: 29,
                  ),
                ),
                const Text('Check any coupons available'),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_right,
                      color: Color(0xffE5097F),
                    ))
              ],
            ),
          ),
          //hhhhh
          const SizedBox(height: 10),
          if (sPlan == 0 ? istVisible : !istVisible)
            InkWell(
              onTap: () async {
                await db.collection('onlineStudents').doc(widget.id).update({
                  'plan': widget.price,
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPageC(),
                    ));
              },
              child: Container(
                padding: const EdgeInsets.only(left: 11, right: 11),
                height: h * 0.07,
                width: w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: sPlan == 0
                        ? const Color(0XffE5097F).withOpacity(0.3)
                        : const Color(0XffE5097F),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Text(
                      'GET 12 MONTHS OF PREMIUM @ ₹${widget.price} ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ),
        ],
      ),
    )));
  }
}
