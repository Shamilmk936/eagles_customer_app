import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/userModel.dart';
import '../MainPageP.dart';
import 'ManageProfile.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({Key? key}) : super(key: key);

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _reasons = <String>[
    '',
    'Casual Leave',
    'Special Leave',
    'Study Leave',
    'Sick Leave',
    'Others'
  ];
  String leaveType = '';
  var typeId;
  DateTime? fromDate;
  DateTime? returnDate;
  DateTime? onDate;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  final TextEditingController onController = TextEditingController();
  final TextEditingController nodaysController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  clearField() {
    fromController.clear();
    returnDateController.clear();
    nodaysController.clear();
    reasonController.clear();
    leaveType = '';
    setState(() {});
  }

  Future neverSatisfied(String name, String leaveType, String cause,
      String days, String status) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Request Details', textAlign: TextAlign.center),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    const Text('Student Name : ',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                    Text(name),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    const Text('Type of Leave : ',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                    Text(leaveType),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    const Text('Cause : ',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                    Text(cause),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    const Text('Number of Days : ',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                    Text(days),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    const Text('Status : ',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                    Text(status),
                  ],
                ),
                // Wrap(
                //   children: <Widget>[
                //     const Text('    To:      ', style: TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                //     ),
                //     Text(to),
                //   ],
                // ),
                // Wrap(
                //   children: <Widget>[
                //     const Text('    Reason Details:    ', style: TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                //     Text(reason),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          color: Colors.black87,
          iconSize: h * 0.03,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MainPageP()));
          },
        ),
        title: Text(
          'Leave',
          style: TextStyle(
            fontSize: h * 0.03,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            color: Colors.black87,
            iconSize: h * 0.03,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: h * 0.05,
            child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.blueGrey,
                labelColor: Colors.black,
                controller: _tabController,
                indicatorColor: Colors.amber,
                indicatorWeight: 2,
                tabs: const [
                  Tab(text: "Apply Leave"),
                  Tab(text: "Status"),
                ]),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              Form(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: <Widget>[
                      Container(
                        width: w * 0.9,
                        padding: const EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0XFFC7F3F0),
                            borderRadius: BorderRadius.circular(25)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'Student Name:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                studentName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: w * 0.9,
                        padding: const EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0XFFC7F3F0),
                            borderRadius: BorderRadius.circular(25)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'Student No:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                studentNo,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: w * 0.9,
                        padding: const EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0XFFC7F3F0),
                            borderRadius: BorderRadius.circular(25)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'Parent Name:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                parentName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      InputDecorator(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.assignment_late),
                          labelText: 'Leave Type',
                        ),
                        isEmpty: leaveType == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: leaveType,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                // newContact.leaveType = newValue!;
                                leaveType = newValue!;
                              });
                            },
                            items: _reasons.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      TextFormField(
                        maxLines: 2,
                        controller: reasonController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.announcement),
                          hintText: 'Enter Leave request reason',
                          labelText: 'Reason',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Align(
                          alignment: Alignment.topLeft, child: Text('Leave')),
                      RadioListTile(
                        title: const Text("Half Day"),
                        value: "halfday",
                        groupValue: typeId,
                        onChanged: (value) {
                          onController.clear();
                          fromController.clear();
                          returnDateController.clear();
                          nodaysController.clear();
                          typeId = value.toString();
                          setState(() {});
                        },
                      ),
                      RadioListTile(
                        title: const Text("Full Day"),
                        value: "fullday",
                        groupValue: typeId,
                        onChanged: (value) {
                          nodaysController.clear();
                          onController.clear();
                          fromController.clear();
                          returnDateController.clear();
                          typeId = value.toString();
                          setState(() {});
                        },
                      ),
                      RadioListTile(
                        title: const Text("Multiple Days"),
                        value: "multipleday",
                        groupValue: typeId,
                        onChanged: (value) {
                          nodaysController.clear();
                          onController.clear();
                          fromController.clear();
                          returnDateController.clear();
                          typeId = value.toString();
                          setState(() {});
                        },
                      ),
                      typeId == "halfday"
                          ? Column(
                              children: [
                                TextFormField(
                                  onTap: () async {
                                    fromDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100));

                                    if (fromDate != null) {
                                      fromController.text =
                                          DateFormat('dd-MM-yyyy')
                                              .format(fromDate!);
                                      nodaysController.text = '0.5 day';
                                      setState(() {});
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                    hintText: 'Enter Date of Leave',
                                    labelText: 'Leave Date',
                                  ),
                                  controller: fromController,
                                  readOnly: true,
                                ),
                              ],
                            )
                          : typeId == "fullday"
                              ? Column(
                                  children: [
                                    TextFormField(
                                      onTap: () async {
                                        fromDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100));

                                        if (fromDate != null) {
                                          fromController.text =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(fromDate!);
                                          nodaysController.text = '1 day';
                                          setState(() {});
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.calendar_today),
                                        hintText: 'Enter Date of Leave',
                                        labelText: 'Leave Date',
                                      ),
                                      controller: fromController,
                                      readOnly: true,
                                    ),
                                  ],
                                )
                              : typeId == "multipleday"
                                  ? Column(
                                      children: [
                                        TextFormField(
                                          onTap: () async {
                                            fromDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2100));

                                            if (fromDate != null) {
                                              fromController.text =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(fromDate!);
                                              setState(() {});
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.calendar_today),
                                            hintText: 'Enter From Date',
                                            labelText: 'From Date',
                                          ),
                                          controller: fromController,
                                          readOnly: true,
                                        ),
                                        fromController.text != ''
                                            ? TextFormField(
                                                onTap: () async {
                                                  returnDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate: fromDate!
                                                              .add(Duration(
                                                            days: 1,
                                                          )),
                                                          firstDate: fromDate!
                                                              .add(Duration(
                                                            days: 1,
                                                          )),
                                                          lastDate:
                                                              DateTime(2100));

                                                  if (returnDate != null) {
                                                    returnDateController.text =
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(
                                                                returnDate!);
                                                    Duration diffrence =
                                                        fromDate!.difference(
                                                            returnDate!);
                                                    var diff =
                                                        diffrence.inDays.abs();
                                                    nodaysController.text =
                                                        '$diff days';
                                                    setState(() {});
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                      Icons.calendar_today),
                                                  hintText:
                                                      'Enter Date of Rejoining',
                                                  labelText: 'Return Date',
                                                ),
                                                controller:
                                                    returnDateController,
                                                readOnly: true,
                                              )
                                            : SizedBox(),
                                      ],
                                    )
                                  : SizedBox(),
                      nodaysController.text != ''
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                  'Number of Days Leave : ${nodaysController.text}',
                                  style: const TextStyle(fontSize: 15)),
                            )
                          : SizedBox(),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              print("====+========================");

                              print("====+========================");
                              final FormState? form = _formKey.currentState;
                              if (form!.validate()) {
                                if (typeId != '' &&
                                    reasonController.text != '' &&
                                    leaveType != '' &&
                                    nodaysController.text != '') {
                                  showDialog(
                                      context: context,
                                      builder: (buildContext) {
                                        return AlertDialog(
                                          title: const Text('Alert'),
                                          content: const Text(
                                              'Confirm Leave Application'),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('leaveReport')
                                                      .doc()
                                                      .set({
                                                    'fromDate': fromDate,
                                                    'returnDate': returnDate ??
                                                        fromDate!.add(
                                                            const Duration(
                                                                days: 1)),
                                                    'noDays':
                                                        nodaysController.text,
                                                    'cause':
                                                        reasonController.text,
                                                    'leaveType': leaveType,
                                                    'sId': studentId,
                                                    'sName': studentName,
                                                    'pName': parentName,
                                                    'pMobno': parentNo,
                                                    'sMobno': studentNo,
                                                    'sEmail': studentEmail,
                                                    'leaveSubmission':
                                                        FieldValue
                                                            .serverTimestamp(),
                                                    'status': false,
                                                  }).then((value) {
                                                    clearField();
                                                    showSnackbar(
                                                        "Leave Successfully Submitted");

                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text('yes')),
                                          ],
                                        );
                                      });
                                } else {
                                  leaveType == ''
                                      ? showSnackbar(
                                          "Please Choose type of Leave")
                                      : reasonController.text == ''
                                          ? showSnackbar(
                                              "Please type reason of Leave")
                                          : ((typeId == 'halfday') ||
                                                  (typeId == 'fullfday'))
                                              ? showSnackbar(
                                                  "Please Pick the Date of Leave")
                                              : ((fromController.text == '') &&
                                                      (typeId == 'multipleday'))
                                                  ? showSnackbar(
                                                      "Please Pick From Date")
                                                  : ((returnDateController
                                                                  .text ==
                                                              '') &&
                                                          (typeId ==
                                                              'multipleday'))
                                                      ? showSnackbar(
                                                          "Please Pick Return Date")
                                                      : showSnackbar(
                                                          "Please choose the Day");
                                }
                              }
                            },
                            child: const Text('Submit'),
                          ),
                          Container(
                            width: 12.0,
                          ),
                          ElevatedButton(
                              child: const Text('Clear'),
                              onPressed: () {
                                clearField();
                              })
                        ],
                      ),
                    ],
                  )),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('leaveReport')
                    .where('pMobno', isEqualTo: parentNo)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  final int messageCount = snapshot.data!.docs.length;
                  return ListView.builder(
                    itemCount: messageCount,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot doc = snapshot.data!.docs[index];

                      return GestureDetector(
                          onTap: () {
                            neverSatisfied(
                                doc['sName'],
                                doc['leaveType'],
                                doc['cause'],
                                doc['noDays'].toString(),
                                doc['status'] == true ? 'Approved' : 'Pending');
                          },
                          child: Column(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                              ),
                              Card(
                                child: ListTile(
                                  leading: Text(doc['status'] == false
                                      ? 'Pending'
                                      : 'Approved'),
                                  title: Text("Student Name:  ${doc['sName']} "
                                      "\nLeave Type: ${doc['leaveType']}"
                                      "\nFrom : ${DateFormat("dd-MM-yyyy").format(doc['fromDate'].toDate())}"
                                      "\nReturn date : ${DateFormat("dd-MM-yyyy").format(doc['returnDate'].toDate())}"),
                                  subtitle: Text(
                                      'Message ${index + 1} of $messageCount\t\t\t\t\t\t\t\t\t\t\t ${DateFormat("dd-MM-yyyy").format(doc['leaveSubmission'].toDate())}',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black38,
                                          fontStyle: FontStyle.italic)),
                                ),
                              ),
                              const Divider(
                                height: 20.5,
                                color: Colors.black,
                              ),
                            ],
                          ));
                    },
                  );
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// Container(
//   height: h,
//   width: w,
//   child: StreamBuilder(
//     stream: FirebaseFirestore.instance.collection('leaveReport').where('status',isEqualTo: false).snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         const Text('Loading data... Please Wait');
//       }
//       return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (BuildContext context, int index) {
//             var data = snapshot.data!.docs;
//         return Card(
//         child: ListTile(
//           title: Text(data[index]['leaveType']),
//           subtitle: Text(data[index]['leaveSubmission'].toDate().toString()),
//           leading: Text(data[index]['status']==false?'Pending':'Approved'),
//           // trailing: InkWell(
//           //   onTap: (){
//           //     wishList.removeAt(index);
//           //     setState( () {});
//           //   },
//           //   child: Icon(Icons.delete),
//           // ),
//
//         ),);
//         },
//
//       );
//     }),
// ),
