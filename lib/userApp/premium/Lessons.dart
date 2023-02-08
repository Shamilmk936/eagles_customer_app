import 'package:eagles_customer_app/userApp/model/onlineStudents.dart';
import 'package:flutter/material.dart';

import '../../globals/firebase_variables.dart';
import '../screens/home/home.dart';

class LessonList extends StatefulWidget {
  const LessonList({Key? key, }) : super(key: key);

  @override
  State<LessonList> createState() => _LessonListState();
}

class _LessonListState extends State<LessonList> {
  List moduleList = [];
  getModule() {
    moduleList = [];

    db.collection('moduleList')
        .where('topic', isEqualTo:'topicName')
    // .where('stage', isEqualTo: currentStudent?.stage)
    // .orderBy('sNo', descending: true)
        .snapshots()
        .listen((event) {
      moduleList = event.docs;
      print(moduleList);
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getModule();
    super.initState();
  }

//hhhhh
  @override
  Widget build(BuildContext context) {
    print(currentModule);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: moduleList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LessonList()));
              },
              child: Container(
                height: 100,
                color:
                //         (currentTopic! >= widget.topic['sNo'] &&
                //         currentModule! >= module[index]['sNo']) ?
                Colors.green,
                // : Colors.red,
                child: Center(child: Text(moduleList[index]['moduleName'])),
              ),
            ),
          );
        },
      ),
    );
  }
}
