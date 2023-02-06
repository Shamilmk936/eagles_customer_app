import 'dart:async';

LeaveModel? currentStudent;
StreamSubscription? listenUserSub;
String? pMob;
String? pId;

class LeaveModel {

  String? sId;
  String? sName;
  String? pName;
  String? sMobNo;
  String? pMobNo;
  String? sEmail;
  String? leaveId;
  DateTime? leaveSubmission;
  String? leaveType;
  int? status;
  String? cause;
  bool? delete;
  int? noDays;
  DateTime? fromD;
  DateTime? toD;


  LeaveModel({
    this.sId,
    this.sName,
    this.pName,
    this.sMobNo,
    this.pMobNo,
    this.sEmail,
    this.leaveId,
    this.leaveSubmission,
    this.leaveType,
    this.status,
    this.delete,
    this.cause,
    this.noDays,
    this.fromD,
    this.toD,
  });

  LeaveModel.fromJson(Map<String, dynamic> json) {
    sId = json['sId'] ?? "" ;
    sName = json['sName'] ?? "" ;
    pName = json['pName'] ?? "" ;
    sMobNo = json['sMobNo'] ?? "" ;
    pMobNo = json['pMobNo'] ?? "" ;
    sEmail = json['sEmail'] ?? "" ;
    leaveId = json['leaveId'] ?? "" ;
    leaveSubmission = json['leaveSubmission'] == null ? DateTime.now() : json['leaveSubmission'].toDate();
    leaveType = json['leaveType'] ?? "" ;
    status = json['status'] ?? 0 ;
    delete = json['delete'] ?? false;
    cause = json['cause'] ?? "" ;
    noDays = json['noDays'] ?? 0 ;
    fromD = json['fromD'] == null ? DateTime.now() : json['fromD'].toDate();
    toD = json['toD'] == null ? DateTime.now() : json['toD'].toDate();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['sId'] = sId ?? "" ;
    data['sName'] = sName ?? "" ;
    data['pName'] = pName ?? "" ;
    data['sMobNo'] = sMobNo ?? "" ;
    data['pMobNo'] = pMobNo ?? "" ;
    data['sEmail'] = sEmail ?? "" ;
    data['leaveId'] = leaveId ?? "" ;
    data['leaveSubmission'] = leaveSubmission ?? DateTime.now();
    data['leaveType'] = leaveType ?? "" ;
    data['status'] = status ?? 0 ;
    data['delete'] = delete ?? false;
    data['cause'] = cause ?? "" ;
    data['noDays'] = noDays ?? 0 ;
    data['fromD'] = fromD ?? DateTime.now();
    data['toD'] = toD ?? DateTime.now();

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
//       currentuser = UserModel.fromJson(event.data()!);
//     }
//   });
// }
