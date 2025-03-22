class AddMemberRequest {
  String? name;
  String? member_relation;
  String? dob;
  String? mobile_number;
  String? email;
  String? age;
  String? gender;

  AddMemberRequest({
    this.name,
    this.member_relation,
    this.dob,
    this.mobile_number,
    this.email,
    this.age,
    this.gender,
  });

  AddMemberRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    member_relation = json['member_relation'];
    dob = json['dob'];
    mobile_number = json['mobile_number'];
    email = json['email'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['member_relation'] = member_relation;
    data['dob'] = dob;
    data['mobile_number'] = mobile_number;
    data['email'] = email;
    data['age'] = age;
    data['gender'] = gender;
    return data;
  }
}
