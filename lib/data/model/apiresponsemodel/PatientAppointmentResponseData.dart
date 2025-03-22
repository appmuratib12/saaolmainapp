class PatientAppointmentResponseData {
  bool? status;
  String? message;
  List<Data>? data;

  PatientAppointmentResponseData({this.status, this.message, this.data});

  PatientAppointmentResponseData.fromJson(Map<String, dynamic> json) {
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
  int? pamId;
  Null? parentPamId;
  String? pamPid;
  int? seqNo;
  String? patientUniqueId;
  String? pamType;
  int? umId;
  int? pmId;
  int? hmId;
  String? pamAppointmentType;
  String? pamAppointmentCategory;
  Null? pamPreviousDate;
  String? pamAppDate;
  String? pamAppTime;
  String? pamAppEndTime;
  int? pamAppointmentDuration;
  Null? pamCaseType;
  int? toctId;
  String? pamStatus;
  Null? pamCancelReason;
  int? pamStatusTypeAppointment;
  Null? pamAppointmentRemark;
  int? pamCall;
  int? pamCallNotification;
  int? ringFlag;
  int? callFlag;
  String? pamTxnId;
  Null? tccId;
  String? pamTxnDate;
  Null? razorpayPaymentId;
  Null? razorpayOrderId;
  Null? razorpaySignature;
  int? pamDel;
  int? pamCreatedBy;
  Null? pamModifiedBy;
  Null? pamDeleteBy;
  String? pamCreatedDate;
  String? pamModifyDate;

  Data(
      {this.pamId,
        this.parentPamId,
        this.pamPid,
        this.seqNo,
        this.patientUniqueId,
        this.pamType,
        this.umId,
        this.pmId,
        this.hmId,
        this.pamAppointmentType,
        this.pamAppointmentCategory,
        this.pamPreviousDate,
        this.pamAppDate,
        this.pamAppTime,
        this.pamAppEndTime,
        this.pamAppointmentDuration,
        this.pamCaseType,
        this.toctId,
        this.pamStatus,
        this.pamCancelReason,
        this.pamStatusTypeAppointment,
        this.pamAppointmentRemark,
        this.pamCall,
        this.pamCallNotification,
        this.ringFlag,
        this.callFlag,
        this.pamTxnId,
        this.tccId,
        this.pamTxnDate,
        this.razorpayPaymentId,
        this.razorpayOrderId,
        this.razorpaySignature,
        this.pamDel,
        this.pamCreatedBy,
        this.pamModifiedBy,
        this.pamDeleteBy,
        this.pamCreatedDate,
        this.pamModifyDate});

  Data.fromJson(Map<String, dynamic> json) {
    pamId = json['pam_id'];
    parentPamId = json['parent_pam_id'];
    pamPid = json['pam_pid'];
    seqNo = json['seq_no'];
    patientUniqueId = json['patient_unique_id'];
    pamType = json['pam_type'];
    umId = json['um_id'];
    pmId = json['pm_id'];
    hmId = json['hm_id'];
    pamAppointmentType = json['pam_appointment_type'];
    pamAppointmentCategory = json['pam_appointment_category'];
    pamPreviousDate = json['pam_previous_date'];
    pamAppDate = json['pam_app_date'];
    pamAppTime = json['pam_app_time'];
    pamAppEndTime = json['pam_app_end_time'];
    pamAppointmentDuration = json['pam_appointment_duration'];
    pamCaseType = json['pam_case_type'];
    toctId = json['toct_id'];
    pamStatus = json['pam_status'];
    pamCancelReason = json['pam_cancel_reason'];
    pamStatusTypeAppointment = json['pam_status_type_appointment'];
    pamAppointmentRemark = json['pam_appointment_remark'];
    pamCall = json['pam_call'];
    pamCallNotification = json['pam_call_notification'];
    ringFlag = json['ring_flag'];
    callFlag = json['call_flag'];
    pamTxnId = json['pam_txn_id'];
    tccId = json['tcc_id'];
    pamTxnDate = json['pam_txn_date'];
    razorpayPaymentId = json['razorpay_payment_id'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpaySignature = json['razorpay_signature'];
    pamDel = json['pam_del'];
    pamCreatedBy = json['pam_created_by'];
    pamModifiedBy = json['pam_modified_by'];
    pamDeleteBy = json['pam_delete_by'];
    pamCreatedDate = json['pam_created_date'];
    pamModifyDate = json['pam_modify_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pam_id'] = this.pamId;
    data['parent_pam_id'] = this.parentPamId;
    data['pam_pid'] = this.pamPid;
    data['seq_no'] = this.seqNo;
    data['patient_unique_id'] = this.patientUniqueId;
    data['pam_type'] = this.pamType;
    data['um_id'] = this.umId;
    data['pm_id'] = this.pmId;
    data['hm_id'] = this.hmId;
    data['pam_appointment_type'] = this.pamAppointmentType;
    data['pam_appointment_category'] = this.pamAppointmentCategory;
    data['pam_previous_date'] = this.pamPreviousDate;
    data['pam_app_date'] = this.pamAppDate;
    data['pam_app_time'] = this.pamAppTime;
    data['pam_app_end_time'] = this.pamAppEndTime;
    data['pam_appointment_duration'] = this.pamAppointmentDuration;
    data['pam_case_type'] = this.pamCaseType;
    data['toct_id'] = this.toctId;
    data['pam_status'] = this.pamStatus;
    data['pam_cancel_reason'] = this.pamCancelReason;
    data['pam_status_type_appointment'] = this.pamStatusTypeAppointment;
    data['pam_appointment_remark'] = this.pamAppointmentRemark;
    data['pam_call'] = this.pamCall;
    data['pam_call_notification'] = this.pamCallNotification;
    data['ring_flag'] = this.ringFlag;
    data['call_flag'] = this.callFlag;
    data['pam_txn_id'] = this.pamTxnId;
    data['tcc_id'] = this.tccId;
    data['pam_txn_date'] = this.pamTxnDate;
    data['razorpay_payment_id'] = this.razorpayPaymentId;
    data['razorpay_order_id'] = this.razorpayOrderId;
    data['razorpay_signature'] = this.razorpaySignature;
    data['pam_del'] = this.pamDel;
    data['pam_created_by'] = this.pamCreatedBy;
    data['pam_modified_by'] = this.pamModifiedBy;
    data['pam_delete_by'] = this.pamDeleteBy;
    data['pam_created_date'] = this.pamCreatedDate;
    data['pam_modify_date'] = this.pamModifyDate;
    return data;
  }
}
