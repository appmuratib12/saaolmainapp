class CenterDetailsResponse {
  String? message;
  Data? data;

  CenterDetailsResponse({this.message, this.data});

  CenterDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? cityAddr;
  String? phoneNo;
  String? centerEmail;
  String? iframeUrl;

  Data({this.cityAddr, this.phoneNo, this.centerEmail, this.iframeUrl});

  Data.fromJson(Map<String, dynamic> json) {
    cityAddr = json['city_addr'];
    phoneNo = json['phone_no'];
    centerEmail = json['center_email'];
    iframeUrl = json['iframe_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_addr'] = cityAddr;
    data['phone_no'] = phoneNo;
    data['center_email'] = centerEmail;
    data['iframe_url'] = iframeUrl;
    return data;
  }
}
