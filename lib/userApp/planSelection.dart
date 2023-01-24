import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PlanSelectionPage extends StatefulWidget {
  const PlanSelectionPage({Key? key}) : super(key: key);

  @override
  State<PlanSelectionPage> createState() => _PlanSelectionPageState();
}

class _PlanSelectionPageState extends State<PlanSelectionPage> {
  DateTime dayss = DateTime.now().add(const Duration(days: 365));
  DateFormat formatter = DateFormat('dd-mm-yyyy');
  // String? dt = formatter.y;
  List plan = [];
  String? feeOne;
  String? feeThree;
  String? feeSix;
  String? feeYear;
  String? feeYears;
  getFee() {
    // DocumentSnapshot<Map<String, dynamic>> event =
    FirebaseFirestore.instance
        .collection('settings')
        .doc('packages')
        .snapshots()
        .listen((event) {
      if (event.exists) {
        plan = event.data()!['types'];
        print(plan);
        // feeOne = event.data()!['oneMonth'].toString();
        // feeYear = event.data()!['year'].toString();
        // feeYears = event.data()!['years'].toString();
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    getFee();
    super.initState();

    // if (mounted) {
    //   setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CircleAvatar(
                child: Center(
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Text('Skip')
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
              Container(
                height: h * 0.15,
                width: w * 0.27,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0XFFF3F3F3),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Monthly',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(' Valid till',
                        style: TextStyle(color: Colors.grey)),
                    Text(
                      (DateTime.now()
                          .add(const Duration(days: 30))
                          .toString()
                          .substring(0, 10)),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text('₹ ${plan[0]['offer']}',
                        style: const TextStyle(
                            color: Color(0xffE5097F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text('₹ ${plan[0]['price']}',
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough)),
                  ],
                ),
              ),
              Container(
                height: h * 0.15,
                width: w * 0.27,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0XFFF3F3F3),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Yearly',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    Text('₹ ${plan[4]['offer']}',
                        style: const TextStyle(
                            color: Color(0xffE5097F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text('₹ ${plan[4]['price']}',
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough)),
                  ],
                ),
              ),
              Container(
                height: h * 0.15,
                width: w * 0.27,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0XFFF3F3F3),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      '2 Years',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(' Valid till',
                        style: TextStyle(color: Colors.grey)),
                    Text(
                      (DateTime.now()
                          .add(const Duration(days: 730))
                          .toString()
                          .substring(0, 10)),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text('₹ ${plan[5]['offer']}',
                        style: const TextStyle(
                            color: Color(0xffE5097F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text('₹ ${plan[5]['price']}',
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough)),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Show more packages'),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_drop_down))
            ],
          ),
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
          const SizedBox(height: 10),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(left: 11, right: 11),
            height: h * 0.07,
            width: w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0XffE5097F),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Column(
                  children: [
                    const Text('₹599.00 '),
                    const Text('You selected monthly plan'),
                    Column(
                      children: const [
                        Text('Pay'),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
