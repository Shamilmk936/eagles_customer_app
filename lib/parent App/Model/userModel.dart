import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Authentication/root.dart';
import '../Screens/ManageProfile.dart';

UserModel? currentuser;
StreamSubscription? listenUserSub;
String? pMob;

class UserModel {
  String? pName;
  String? pEmail;
  String? userId;
  String? pMobNo;
  List? token;

  UserModel({
    this.pName,
    this.pEmail,
    this.userId,
    this.pMobNo,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    pName = json['userName'];
    pEmail = json['userEmail'];
    userId = json['userId'];
    token = json['token'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.pName;
    data['userEmail'] = this.pEmail;
    data['userId'] = this.userId;
    data['phone'] = this.pMobNo;
    data['token'] = this.token;

    return data;
  }
}

getcurrentuser() {
  print('Here');
  print(studentId);
  listenUserSub = FirebaseFirestore.instance
      .collection('students')
      .doc(studentId)
      .snapshots()
      .listen((event) {
    if (event.exists) {
      currentuser = UserModel.fromJson(event.data()!);
    }
  });
}
