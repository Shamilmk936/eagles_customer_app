import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../../main.dart';
import '../../splashScreen.dart';
import '../Model/leaveModel.dart';
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
  int noDays = 0;


  final TextEditingController fromController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  clearField() {
    fromController.clear();
    returnDateController.clear();
    noDays = 0;
    reasonController.clear();
    leaveType = '';
    typeId = '';
    setState(() {});
  }

  Future neverSatisfied(String name, String leaveType, String cause, String days, String status) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Request Details', textAlign: TextAlign.center),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text('Student Name      : ',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                      Text(name),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text('Type of Leave      : ',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                      Text(leaveType),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text('Cause                   : ',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                      Text(cause),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text('Status                  : ',
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
     h = MediaQuery.of(context).size.height;
     w = MediaQuery.of(context).size.width;

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
                      const SizedBox(height: 10),
                      Container(
                        width: w * 0.9,
                        padding: const EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: BoxDecoration(
                            color:  Colors.black12,
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
                      const SizedBox(height: 10),
                      Container(
                        width: w * 0.9,
                        padding: const EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: BoxDecoration(
                            color:  Colors.black12,
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
                      const SizedBox(height: 10),
                      Container(
                        width: w * 0.9,
                        padding: const EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: BoxDecoration(
                            color:  Colors.black12,
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
                      const SizedBox(height: 10,),
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
                      const SizedBox(height: 10,),
                      TextFormField(
                        maxLines: 2,
                        controller: reasonController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.announcement),
                          hintText: 'Enter Leave request reason',
                          labelText: 'Reason',
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Align(
                          alignment: Alignment.topLeft, child: Text('Leave')),
                      RadioListTile(
                        title: const Text("Half Day"),
                        value: "halfday",
                        groupValue: typeId,
                        onChanged: (value) {
                          fromController.clear();
                          returnDateController.clear();
                          noDays = 0;
                          typeId = value.toString();
                          setState(() {});
                        },
                      ),
                      RadioListTile(
                        title: const Text("Full Day"),
                        value: "fullday",
                        groupValue: typeId,
                        onChanged: (value) {
                          fromController.clear();
                          returnDateController.clear();
                          noDays = 0;
                          typeId = value.toString();
                          setState(() {});
                        },
                      ),
                      RadioListTile(
                        title: const Text("Multiple Days"),
                        value: "multipleday",
                        groupValue: typeId,
                        onChanged: (value) {
                          fromController.clear();
                          returnDateController.clear();
                          noDays = 0;
                          typeId = value.toString();
                          setState(() {});
                        },
                      ),
                      typeId == "halfday"
                          ? Column(
                              children: [
                                TextFormField(
                                  onTap: () async {
                                    // fromDate = await showDatePicker(
                                    //     context: context,
                                    //     initialDate: DateTime.now(),
                                    //     firstDate: DateTime.now(),
                                    //     lastDate: DateTime(2100));

                                    fromDate = await showOmniDateTimePicker(
                                      context: context,
                                      // primaryColor: Colors.cyan,
                                      // backgroundColor: Colors.grey[900],
                                      // calendarTextColor: Colors.white,
                                      // tabTextColor: Colors.white,
                                      // unselectedTabBackgroundColor: Colors.grey[700],
                                      // buttonTextColor: Colors.white,
                                      // timeSpinnerTextStyle: const TextStyle(color: Colors.white70, fontSize: 18),
                                      // timeSpinnerHighlightedTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
                                      is24HourMode: false,
                                      isShowSeconds: false,
                                      startInitialDate: DateTime.now(),
                                      startFirstDate: DateTime.now(),
                                      startLastDate: DateTime.now().add(const Duration(days: 365)),
                                      borderRadius: const Radius.circular(16),
                                    );

                                    if (fromDate != null) {
                                      fromController.text = DateFormat('dd-MM-yyyy hh:mm a').format(fromDate!);
                                      noDays = -1;
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
                                          fromController.text = DateFormat('dd-MM-yyyy').format(fromDate!);
                                          noDays = 1;
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
                                              fromController.text = DateFormat('dd-MM-yyyy').format(fromDate!);
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
                                                          initialDate: fromDate!.add(Duration(days: 1,)),
                                                          firstDate: fromDate!.add(Duration(days: 1,)),
                                                          lastDate: DateTime(2100));

                                                  if (returnDate != null) {
                                                    returnDateController.text = DateFormat('dd-MM-yyyy').format(returnDate!);
                                                    Duration change = fromDate!.difference(returnDate!).abs();
                                                    noDays = change.inDays;
                                                 
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
                     noDays != 0
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                  'Number of Days Leave : ${noDays == -1 ? 'Half Day': '${noDays.toInt()} Days'} ',
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
                                    noDays != 0) {
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
                                                  final details=LeaveModel(

                                                    sId: studentId,
                                                    sName: studentName,
                                                    sMobNo: studentNo,
                                                    sEmail: studentEmail,
                                                    pName: parentName,
                                                    pMobNo: parentNo,
                                                    delete: false,
                                                    status: 0,
                                                    leaveSubmission: DateTime.now(),
                                                    leaveType: leaveType,
                                                    cause: reasonController.text,
                                                    noDays: noDays,
                                                    fromD: fromDate,
                                                    toD: returnDate ?? fromDate!.add(const Duration(days: 1)),

                                                  );
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('leaveReport')
                                                      .add(details.toJson()).then((value) {
                                                    value.update({
                                                      'leaveId':value.id
                                                    });

                                                    clearField();
                                                    showSnackbar("Leave Successfully Submitted");
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
                                                  : ((returnDateController.text == '') && (typeId == 'multipleday'))
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
                    .where('pMobNo', isEqualTo: parentNo)
                    .where('delete', isEqualTo: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)  {
                    return  const Center(child: CircularProgressIndicator());
                  }
                  if(snapshot.data!.docs.isEmpty) {
                    return  const Center(child: Text('Leave Request is Empty...'));
                  }
                  final int messageCount = snapshot.data!.docs.length;
                  return ListView.builder(
                    itemCount: messageCount,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot doc = snapshot.data!.docs[index];

                      return Column(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                          Card(
                            child: ListTile(
                              leading: SizedBox(
                                width: 90,
                                child: Text(doc['status'] == 0 ? 'Pending': doc['status'] == 1 ?'Approved' : 'Disapproved',  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18),),
                              ),
                              title: Text(
                                  "Student Name : ${doc['sName']} "
                               "\nLeave Type       : ${doc['leaveType']}"
                               "\nFrom  : ${DateFormat("dd-MM-yyyy").format(doc['fromD'].toDate())}"
                               "\nTo       : ${DateFormat("dd-MM-yyyy").format(doc['toD'].toDate())}"),
                              // subtitle: Text(
                              //     'Message ${index + 1} of $messageCount\t\t\t\t\t\t\t\t\t\t\t ${DateFormat("dd-MM-yyyy").format(doc['leaveSubmission'].toDate())}',
                              //     style: const TextStyle(
                              //         fontSize: 15.0,
                              //         color: Colors.black38,
                              //         fontStyle: FontStyle.italic)),
                              subtitle:  GestureDetector(
                                onTap: () {
                                  neverSatisfied(
                                      doc['sName'],
                                      doc['leaveType'],
                                      doc['cause'],
                                      doc['noDays'] == -1?'Half Day': doc['noDays'] == 1 ?'Full Day' : '${doc['noDays'].toString()} Days',
                                      doc['status'] == 0 ? 'Pending': doc['status'] == 1 ?'Approved' : 'Disapproved'
                                  );
                                },
                                child: const Text(
                                    'View More',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black38,
                                        fontStyle: FontStyle.italic)),
                              ),
                            //   trailing: GestureDetector(
                            //   onTap: (){
                            //     print('delete in ');
                            //      AlertDialog(
                            //       title: const Text('Alert'),
                            //       content: const Text(
                            //           'Are you sure you want to delete this Leave Request?'),
                            //       actions: [
                            //         TextButton(
                            //             onPressed: () =>
                            //                 Navigator.pop(context),
                            //             child: const Text('Cancel')),
                            //         TextButton(
                            //             onPressed: ()  {
                            //                FirebaseFirestore.instance.collection('leaveReport').doc(doc['leaveId']).delete()
                            //              .then((value) {
                            //                 showSnackbar(
                            //                     "Leave Successfully Deleted");
                            //                 Navigator.pop(context);
                            //               });
                            //             },
                            //             child: const Text('yes')),
                            //       ],
                            //     );
                            //      setState( () {});
                            //   },
                            //   child: Icon(Icons.delete),
                            // ),
                              trailing:  doc['status'] == 0 ?GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (buildContext) {
                                        return  AlertDialog(
                                          title: const Text('Alert'),
                                          content: const Text(
                                              'Are you sure you want to delete this Leave Request?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: ()  {
                                                  FirebaseFirestore.instance.collection('leaveReport').doc(doc['leaveId']).update({
                                                    'delete':true
                                                  })
                                                      .then((value) {
                                                    showSnackbar(
                                                        "Leave Successfully Deleted");
                                                    Navigator.pop(context);
                                                  });
                                                  setState(() {

                                                  });
                                                },
                                                child: const Text('yes')),
                                          ],
                                        );
                                      });
                                },
                                child: Icon(Icons.delete),
                              ):const SizedBox(),
                            ),
                          ),
                          const Divider(
                            height: 20.5,
                            color: Colors.black,
                          ),
                        ],
                      );
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
