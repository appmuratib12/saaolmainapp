class RegisterRequestData {
  String? name;
  String? email;
  String? mobile;
  String? password;
  String? country_code;

  RegisterRequestData({
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.country_code,
  });

  RegisterRequestData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    country_code = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['password'] = password;
    data['country_code'] = country_code;
    return data;
  }
}
