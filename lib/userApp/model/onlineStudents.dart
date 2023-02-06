import 'package:cloud_firestore/cloud_firestore.dart';

import '../../globals/firebase_variables.dart';
import '../authentication/routing.dart';

OSModel? currentStudent;

class OSModel {
  String? OSId;
  String? sName;
  String? stage;
  int? plan;
  String? mobNo;
  String? email;
  String? desc;
  String? profile;
  DateTime? joinDate;
  List? search;
  int? status;
  int? sno;
  int? currentLesson;
  int? currentModule;
  int? currentTopic;
  int? level;
  String? webUrl;
  String? qualification;

  OSModel({
    this.OSId,
    this.sno,
    this.currentLesson,
    this.currentModule,
    this.currentTopic,
    this.level,
    this.sName,
    this.desc,
    this.stage,
    this.plan,
    this.mobNo,
    this.email,
    this.profile,
    this.joinDate,
    this.search,
    this.status,
    this.webUrl,
    this.qualification,
  });

  OSModel.fromJson(Map<String, dynamic> json) {
    OSId = json['OSId'] ?? "";
    sName = json['sName'] ?? "";
    stage = json['stage'] ?? "";
    plan = json['plan'] ?? "";
    mobNo = json['mobNo'] ?? "";
    email = json['email'] ?? "";
    desc = json['desc'] ?? "";
    profile = json['dp'] ?? "";
    joinDate =
        json['joinDate'] == null ? DateTime.now() : json['joinDate'].toDate();
    search = json['search'] ?? [];
    status = json['status'] ?? 0;
    level = json['level'] ?? 0;
    sno = json['sno'] ?? 0;
    currentLesson = json['currentLesson'] ?? 0;
    currentModule = json['currentModule'] ?? 0;
    currentTopic = json['currentTopic'] ?? 0;
    webUrl = json['webUrl'] ?? "";
    qualification = json['qualification'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['OSId'] = OSId ?? "";
    data['sName'] = sName ?? "";
    data['stage'] = stage ?? "";
    data['plan'] = plan ?? "";
    data['mobNo'] = mobNo ?? "";
    data['email'] = email ?? "";
    data['desc'] = desc ?? "";
    data['dp'] = profile ?? "";
    data['joinDate'] = joinDate ?? DateTime.now();
    data['search'] = search ?? [];
    data['status'] = status ?? 0;
    data['sno'] = sno ?? 0;
    data['currentTopic'] = currentTopic ?? 0;
    data['currentModule'] = currentModule ?? 0;
    data['currentLesson'] = currentLesson ?? 0;
    data['level'] = level ?? 0;
    data['webUrl'] = webUrl ?? "";
    data['qualification'] = qualification ?? "";
    return data;
  }

  // OSModel.fromdocumentsnapshot(DocumentSnapshot json)
  //     : OSId = json['OSId'],
  //       sName = json['sName'],
  //       stage = json['stage'],
  //       plan = json['plan'],
  //       mobNo = json['mobNo'],
  //       email = json['email'],
  //       desc = json['desc'],
  //       profile = json['dp'],
  //       joinDate = json['joinDate'] == null
  //           ? DateTime.now()
  //           : json['joinDate'].toDate(),
  //       search = json['search'],
  //       status = json['status'],
  //       level = json['level'],
  //       sno = json['sno'],
  //       webUrl = json['webUrl'],
  //       qualification = json['qualification'];
  //
  // fromJson(data) {}

  OSModel copyWith({
    String? OSId,
    String? sName,
    String? stage,
    int? plan,
    String? sno,
    String? level,
    String? mobNo,
    String? email,
    String? desc,
    String? dp,
    DateTime? joinDate,
    List? search,
    int? status,
    int? currentModule,
    int? currentLesson,
    int? currentTopic,
    String? webUrl,
    String? qualification,
  }) =>
      OSModel(
        OSId: OSId ?? this.OSId,
        sName: sName ?? this.sName,
        stage: stage ?? this.stage,
        plan: plan ?? this.plan,
        mobNo: mobNo ?? this.mobNo,
        email: email ?? this.email,
        desc: desc ?? this.desc,
        profile: dp ?? this.profile,
        joinDate: joinDate ?? this.joinDate,
        search: search ?? this.search,
        status: status ?? this.status,
        currentLesson: currentLesson ?? this.currentLesson,
        currentModule: currentModule ?? this.currentModule,
        currentTopic: currentTopic ?? this.currentTopic,
        sno: status ?? this.sno,
        level: status ?? this.level,
        webUrl: webUrl ?? this.webUrl,
        qualification: qualification ?? this.qualification,
      );
}

// getCurrent() {
//   db.collection('onlineStudents').doc().snapshots().listen((event) {
//     currentStudent = OSModel.fromJson(event.data()!);
//   });
// }
