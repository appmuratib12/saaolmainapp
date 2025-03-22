class SendOTPResponse {
  String? status;
  String? message;
  String? prpsmsResponse;

  SendOTPResponse({this.status, this.message, this.prpsmsResponse});

  SendOTPResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    prpsmsResponse = json['prpsms_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['prpsms_response'] = prpsmsResponse;
    return data;
  }
}
