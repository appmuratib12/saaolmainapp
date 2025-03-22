class VerifyOTPResponse {
  bool? success;
  String? message;
  int? id;
  String? mobile;

  VerifyOTPResponse({this.success, this.message, this.id, this.mobile});

  VerifyOTPResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    id = json['id'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    return data;
  }
}
