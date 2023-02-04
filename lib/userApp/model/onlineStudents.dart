import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

OnlineUserModel? currentuser;
StreamSubscription? listenUserSub;
String? pMob;

class OnlineUserModel {
  String? name;
  String? email;
  String? userId;
  String? mobile;

  OnlineUserModel({
    this.name,
    this.email,
    this.userId,
    this.mobile,
  });

  OnlineUserModel.fromJson(Map<String, dynamic> json) {
    name = json['userName'];
    email = json['userEmail'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.name;
    data['userEmail'] = this.email;
    data['userId'] = this.userId;
    data['phone'] = this.mobile;

    return data;
  }
}

// getcurrentuser() {
//   print('Here');
//   print(studentId);
//   listenUserSub = FirebaseFirestore.instance
//       .collection('students')
//       .doc(studentId)
//       .snapshots()
//       .listen((event) {
//     if (event.exists) {
//       currentuser = OnlineUserModel.fromJson(event.data()!);
//     }
//   });
// }
