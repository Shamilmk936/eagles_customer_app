import 'package:eagles_customer_app/userApp/model/onlineStudents.dart';
import 'package:flutter/material.dart';

import '../../globals/firebase_variables.dart';
import '../screens/home/home.dart';

class ModuleList extends StatefulWidget {
  final Map topic;
  const ModuleList({Key? key, required this.topic}) : super(key: key);

  @override
  State<ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  List module = [];
  getModule() {
    module = [];

    db
        .collection('module')
        .where('topic', isEqualTo: widget.topic['topicName'])
        .where('stage', isEqualTo: currentStudent?.stage)
        // .orderBy('sNo', descending: true)
        .snapshots()
        .listen((event) {
      module = event.docs;
      print(module);
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
        itemCount: module.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: 100,
              color: (currentTopic! >= widget.topic['sNo'] &&
                      currentModule! >= module[index]['sNo'])
                  ? Colors.green
                  : Colors.red,
              child: Center(child: Text(module[index]['moduleName'])),
            ),
          );
        },
      ),
    );
  }
}
