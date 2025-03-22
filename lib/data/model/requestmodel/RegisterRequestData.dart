class RegisterRequestData {
  String? name;
  String? email;
  String? mobile;
  String? password;

  RegisterRequestData({
    this.name,
    this.email,
    this.mobile,
    this.password,
  });

  RegisterRequestData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['password'] = password;
    return data;
  }
}
