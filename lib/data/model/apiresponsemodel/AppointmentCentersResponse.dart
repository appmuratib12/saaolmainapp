class AppointmentCentersResponse {
  bool? status;
  String? message;
  List<Data>? data;

  AppointmentCentersResponse({this.status, this.message, this.data});

  AppointmentCentersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? hmId;
  String? hmName;
  String? hmState;

  Data({this.hmId, this.hmName, this.hmState});

  Data.fromJson(Map<String, dynamic> json) {
    hmId = json['hm_id'];
    hmName = json['hm_name'];
    hmState = json['hm_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hm_id'] = this.hmId;
    data['hm_name'] = this.hmName;
    data['hm_state'] = this.hmState;
    return data;
  }
}
