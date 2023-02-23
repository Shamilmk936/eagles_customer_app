ParentModel? currentParent;

class ParentModel {
  String? pId;
  String? name;
  String? mobNo;
  String? email;
  String? profileUrl;

  ParentModel({
    this.pId,
    this.name,
    this.mobNo,
    this.email,
    this.profileUrl,

  });

  ParentModel.fromJson(Map<String, dynamic> json) {

    pId = json['pId'] ?? "";
    name = json['name'] ?? "";
    mobNo = json['mobNo'] ?? "";
    email = json['email'] ?? "";
    profileUrl = json['profileUrl'] ?? "";

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['pId'] = pId ?? "";
    data['name'] = name ?? "";
    data['mobNo'] = mobNo ?? "";
    data['email'] = email ?? "";
    data['profileUrl'] = profileUrl ?? "";

    return data;
  }

  ParentModel copyWith({
    String? pId,
    String? name,
    String? mobNo,
    String? email,
    String? profileUrl,

  }) =>
      ParentModel(
        pId: pId ?? this.pId,
        name: name ?? this.name,
        mobNo: mobNo ?? this.mobNo,
        email: email ?? this.email,
        profileUrl: profileUrl ?? this.profileUrl,

      );

}
