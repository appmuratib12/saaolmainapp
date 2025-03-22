class AppointmentLocationResponse {
  bool? status;
  String? message;
  List<Data>? data;

  AppointmentLocationResponse({this.status, this.message, this.data});

  AppointmentLocationResponse.fromJson(Map<String, dynamic> json) {
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
  String? hmState;

  Data({this.hmState});

  Data.fromJson(Map<String, dynamic> json) {
    hmState = json['hm_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hm_state'] = this.hmState;
    return data;
  }
}
