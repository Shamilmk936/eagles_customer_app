import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/main.dart';
import 'package:eagles_customer_app/parent%20App/Model/leaveModel.dart';
import 'package:eagles_customer_app/parent%20App/Model/parentModel.dart';
import 'package:eagles_customer_app/parent%20App/Screens/ManageProfile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';


class FineReports extends StatefulWidget {
  const FineReports({Key? key}) : super(key: key);

  @override
  State<FineReports> createState() => _FineReportsState();
}

class _FineReportsState extends State<FineReports> {
  List<DocumentSnapshot<Map<String,dynamic>>> allUsers = [];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Fine History",style: TextStyle(color: Colors.tealAccent,fontStyle: FontStyle.italic)),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0.00,
          backgroundColor: Colors.pinkAccent[400],
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('fine')
                    .where('pId', isEqualTo: currentParent?.pId ?? currentParentId)
                    .snapshots(),
                builder: (context, snapshot) {
                  print('studentId    :$studentId');
                  print('currentParentId    :${currentParentId!}');
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data?.docs;
                  data?.sort((a,b) {
                    var aa = a['date'];
                    var bb = b['date'];
                    return aa.compareTo(bb);
                  });
                  if (data?.length == 0) {
                    return LottieBuilder.network(
                    'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                    height: 500,
                  );
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                            border: TableBorder.all(
                            color: Colors.black.withOpacity(0.1)),
                            dataRowColor: MaterialStateProperty.resolveWith(
                                (Set states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.grey;
                              }
                              return Colors.white; // Use the default value.
                            }),
                        columnSpacing: 15.0,
                        dividerThickness: 2,
                        horizontalMargin: 10,


                        columns: [
                          DataColumn(label: Text("Sl.No "),),
                          DataColumn(label: Text("S.Id ",),),
                          DataColumn(label: Text("Amount",),),
                          DataColumn(label: Text("Reason",),),
                          DataColumn(label: Text("Issued Date",),),
                          DataColumn(label: Text("Issued By",),),
                        ],
                        rows: List.generate(data!.length, (index) {

                            return DataRow(
                              color: index.isOdd
                                  ? MaterialStateProperty.all(Colors
                                  .blueGrey.shade50
                                  .withOpacity(0.7))
                                  : MaterialStateProperty.all(
                                  Colors.blueGrey.shade50),
                              cells: [
                                DataCell(Center(child: Text('${index + 1}',))),
                                DataCell(Center(child: Text(data[index]['sId'],))),
                                DataCell(Center(child: Text(data[index]['amount'],))),
                                DataCell(Center(child: Text(data[index]['cause'],))),
                                DataCell(Center(child: Text(DateFormat('dd-MMM-yyyy').format(data[index]['issueDate'].toDate()))),),
                                DataCell(Center(child: Text(data[index]['issuedByRole'],))),

                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}


