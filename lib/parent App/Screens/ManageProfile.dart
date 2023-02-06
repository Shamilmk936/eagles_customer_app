import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../splashScreen.dart';
import '../Authentication/authP.dart';
import '../Model/leaveModel.dart';
import '../MainPageP.dart';

String studentId = "";

class ManageProfile extends StatefulWidget {
  const ManageProfile({Key? key}) : super(key: key);

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? studentStream = FirebaseFirestore
      .instance
      .collection('candidates')
      .where('parentId', isEqualTo: currentParentId)
      .snapshots();

//   Future<List?> geStudent(String id) async {
//     try {
//       QuerySnapshot event = await FirebaseFirestore.instance
//           .collection('students')
//           .where('pMobno',isEqualTo:pMob )
//           .where('sId',isEqualTo: id)
//           .get();
//
//       if(event.docs.isNotEmpty) {
//       for (var doc in event.docs) {
//         print(doc["sId"]);
//         studentId = doc["sId"];
//         result?.add(doc.data());
//       }
// }
//       return result;
//     } catch (error) {
//       print('----------a-------------');
//       print(error.toString());
//       print('----------b-------------');
//     }
//   }

  // getSponsor() async {
  //   if (studentId != "") {
  //     QuerySnapshot<Map<String, dynamic>> refUser = await FirebaseFirestore.instance
  //         .collection('Users').where('pMobno',isEqualTo:pMob)
  //         .get();
  //     allUsers =refUser.docs;
  //     print(allUsers.);
  //     // sponsorName = refUser.get('name');
  //     // sponsorNo = refUser.get('mobno');
  //   }
  //   setState(() {});
  // }

  void initState() {
    print('Manage Profile');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     h = MediaQuery.of(context).size.height;
     w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My students',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: new Icon(Icons.logout),
            color: Colors.black87,
            iconSize: h * 0.03,
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: studentStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text("No Students found"),
                    );
                  }
                  var data = snapshot.data!.docs;

                  return SizedBox(
                    height: h / 4,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            studentId = data[index]['studentId'];
                            print('Student Id = $studentId ');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainPageP(),
                                ));
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                data[index]['photo'] != ''
                                    ? CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            data[index]['photo']),
                                      )
                                    : CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.red,
                                        child: SvgPicture.asset(
                                          'assets/eagleslogo.svg',
                                          width: 60,
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(data[index]['name'])
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );

                  // return DataTable(columns: const [
                  //   DataColumn(label:Text('sId')),
                  //   DataColumn(label:Text('Name')),
                  //   DataColumn(label:Text('Batch')),
                  //
                  // ], rows: List.generate(data.length, (index) {
                  //   var user = data[index];
                  //   return DataRow(cells: [
                  //     DataCell(Text(user['sId'])),
                  //     DataCell(Text(user['name'])),
                  //     DataCell(Text(user['batch'])),
                  //
                  //   ]);
                  // })
                  // );
                }),
            // Container(
            //   height: 300,
            //   width: 300,
            //   // decoration: BoxDecoration(              //     image: DecorationImage(
            //   //         image: AssetImage('assets/eagles logo.jpg'),
            //   //         fit: BoxFit.fill)),
            //   child: SvgPicture.asset(
            //     'assets/eagleslogo.svg',
            //     fit: BoxFit.scaleDown,
            //   ),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XffE5097F)),
                onPressed: () {
                  signOut(context);
                },
                child: const Text('Welcome OnBoard')),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
