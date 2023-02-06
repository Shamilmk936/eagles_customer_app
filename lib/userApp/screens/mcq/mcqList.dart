import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/globals/firebase_variables.dart';
import 'package:eagles_customer_app/userApp/screens/mcq/Exam.dart';
import 'package:flutter/material.dart';

import '../../homepage.dart';
import 'mcq.dart';

class MyQuestionnaire extends StatefulWidget {
  const MyQuestionnaire({Key? key}) : super(key: key);

  @override
  State<MyQuestionnaire> createState() => _MyQuestionnaireState();
}



class _MyQuestionnaireState extends State<MyQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: db.collection('exams').snapshots(),
                builder: (context, snapshot) {
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    // data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Exam(examId: data[index]['id']),
                              ));
                        },
                        child: Card(
                          child: Container(
                            height: 100,
                            child: ListTile(
                              title: Text(data[index]['studentName']),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
