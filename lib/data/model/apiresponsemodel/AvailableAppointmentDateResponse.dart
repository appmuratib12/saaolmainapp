class AvailableAppointmentDateResponse {
  bool? status;
  String? message;
  List<Data>? data;

  AvailableAppointmentDateResponse({this.status, this.message, this.data});

  AvailableAppointmentDateResponse.fromJson(Map<String, dynamic> json) {
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
  String? doctorName;
  int? doctorId;
  String? hospitalName;
  int? hospitalId;
  String? slotDate;
  String? opdType;

  Data(
      {this.doctorName,
      this.doctorId,
      this.hospitalName,
      this.hospitalId,
      this.slotDate,
      this.opdType});

  Data.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctor_name'];
    doctorId = json['doctor_id'];
    hospitalName = json['hospital_name'];
    hospitalId = json['hospital_id'];
    slotDate = json['slot_date'];
    opdType = json['opd_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_name'] = this.doctorName;
    data['doctor_id'] = this.doctorId;
    data['hospital_name'] = this.hospitalName;
    data['hospital_id'] = this.hospitalId;
    data['slot_date'] = this.slotDate;
    data['opd_type'] = this.opdType;
    return data;
  }
}
