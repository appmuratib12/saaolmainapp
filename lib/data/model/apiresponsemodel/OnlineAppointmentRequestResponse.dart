class OnlineAppointmentRequestResponse {
  bool? status;
  String? message;
  Data? data;

  OnlineAppointmentRequestResponse({this.status, this.message, this.data});
  OnlineAppointmentRequestResponse.fromJson(Map<String, dynamic> json) {
    final dynamic statusValue = json['status'];
    status = statusValue == true || statusValue == 'true'; // ✅ Safe conversion
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? leadUniqueId;
  int? seqNo;
  int? hmId;
  String? lmFirstName;
  String? lmMiddleName;
  String? lmLastName;
  String? lmEmail;
  String? lmContactNo;
  String? lmContactNoCountryCode;
  String? lmAddress;
  int? lmStatus;
  int? tlpsId;
  String? lmAppointmentCategory;
  String? lmContactDate;
  String? lmContactTime;
  int? lmCategory;
  int? id;

  Data(
      {this.leadUniqueId,
        this.seqNo,
        this.hmId,
        this.lmFirstName,
        this.lmMiddleName,
        this.lmLastName,
        this.lmEmail,
        this.lmContactNo,
        this.lmContactNoCountryCode,
        this.lmAddress,
        this.lmStatus,
        this.tlpsId,
        this.lmAppointmentCategory,
        this.lmContactDate,
        this.lmContactTime,
        this.lmCategory,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    leadUniqueId = json['lead_unique_id'];
    seqNo = json['seq_no'];
    hmId = json['hm_id'];
    lmFirstName = json['lm_first_name'];
    lmMiddleName = json['lm_middle_name'];
    lmLastName = json['lm_last_name'];
    lmEmail = json['lm_email'];
    lmContactNo = json['lm_contact_no'];
    lmContactNoCountryCode = json['lm_contact_no_country_code'];
    lmAddress = json['lm_address'];
    lmStatus = json['lm_status'];
    tlpsId = json['tlps_id'];
    lmAppointmentCategory = json['lm_appointment_category'];
    lmContactDate = json['lm_contact_date'];
    lmContactTime = json['lm_contact_time'];
    lmCategory = json['lm_category'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_unique_id'] = this.leadUniqueId;
    data['seq_no'] = this.seqNo;
    data['hm_id'] = this.hmId;
    data['lm_first_name'] = this.lmFirstName;
    data['lm_middle_name'] = this.lmMiddleName;
    data['lm_last_name'] = this.lmLastName;
    data['lm_email'] = this.lmEmail;
    data['lm_contact_no'] = this.lmContactNo;
    data['lm_contact_no_country_code'] = this.lmContactNoCountryCode;
    data['lm_address'] = this.lmAddress;
    data['lm_status'] = this.lmStatus;
    data['tlps_id'] = this.tlpsId;
    data['lm_appointment_category'] = this.lmAppointmentCategory;
    data['lm_contact_date'] = this.lmContactDate;
    data['lm_contact_time'] = this.lmContactTime;
    data['lm_category'] = this.lmCategory;
    data['id'] = this.id;
    return data;
  }
}
