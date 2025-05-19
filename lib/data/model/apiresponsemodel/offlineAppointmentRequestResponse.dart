class OfflineAppointmentRequestResponse {
  bool? status;
  String? message;
  List<Data>? data;

  OfflineAppointmentRequestResponse({this.status, this.message, this.data});

  OfflineAppointmentRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['data'] != null && json['data'] is List) {
      data = List<Data>.from(json['data'].map((e) => Data.fromJson(e)));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class Data {
  int? pamId;
  dynamic parentPamId;
  String? pamPid;
  int? seqNo;
  String? patientUniqueId;
  String? pamType;
  int? umId;
  int? pmId;
  int? hmId;
  String? pamAppointmentType;
  String? pamAppointmentCategory;
  dynamic pamPreviousDate;
  String? pamAppDate;
  String? pamAppTime;
  dynamic pamAppEndTime;
  int? pamAppointmentDuration;
  dynamic pamCaseType;
  int? toctId;
  String? pamStatus;
  dynamic pamCancelReason;
  int? pamStatusTypeAppointment;
  dynamic pamAppointmentRemark;
  int? pamCall;
  int? pamCallNotification;
  int? ringFlag;
  int? callFlag;
  String? pamTxnId;
  dynamic billingPaymentOption;
  int? tccId;
  String? pamTxnDate;
  dynamic razorpayPaymentId;
  dynamic razorpayOrderId;
  dynamic razorpaySignature;
  int? pamDel;
  int? pamCreatedBy;
  dynamic pamModifiedBy;
  dynamic pamDeleteBy;
  String? pamCreatedDate;
  dynamic pamModifyDate;
  Patients? patients;

  Data({
    this.pamId,
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
    this.billingPaymentOption,
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
    this.pamModifyDate,
    this.patients,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      pamId: json['pam_id'],
      parentPamId: json['parent_pam_id'],
      pamPid: json['pam_pid'],
      seqNo: json['seq_no'],
      patientUniqueId: json['patient_unique_id'],
      pamType: json['pam_type'],
      umId: json['um_id'],
      pmId: json['pm_id'],
      hmId: json['hm_id'],
      pamAppointmentType: json['pam_appointment_type'],
      pamAppointmentCategory: json['pam_appointment_category'],
      pamPreviousDate: json['pam_previous_date'],
      pamAppDate: json['pam_app_date'],
      pamAppTime: json['pam_app_time'],
      pamAppEndTime: json['pam_app_end_time'],
      pamAppointmentDuration: json['pam_appointment_duration'],
      pamCaseType: json['pam_case_type'],
      toctId: json['toct_id'],
      pamStatus: json['pam_status'],
      pamCancelReason: json['pam_cancel_reason'],
      pamStatusTypeAppointment: json['pam_status_type_appointment'],
      pamAppointmentRemark: json['pam_appointment_remark'],
      pamCall: json['pam_call'],
      pamCallNotification: json['pam_call_notification'],
      ringFlag: json['ring_flag'],
      callFlag: json['call_flag'],
      pamTxnId: json['pam_txn_id'],
      billingPaymentOption: json['billing_payment_option'],
      tccId: json['tcc_id'],
      pamTxnDate: json['pam_txn_date'],
      razorpayPaymentId: json['razorpay_payment_id'],
      razorpayOrderId: json['razorpay_order_id'],
      razorpaySignature: json['razorpay_signature'],
      pamDel: json['pam_del'],
      pamCreatedBy: json['pam_created_by'],
      pamModifiedBy: json['pam_modified_by'],
      pamDeleteBy: json['pam_delete_by'],
      pamCreatedDate: json['pam_created_date'],
      pamModifyDate: json['pam_modify_date'],
      patients: json['patients'] != null
          ? Patients.fromJson(json['patients'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pam_id': pamId,
      'parent_pam_id': parentPamId,
      'pam_pid': pamPid,
      'seq_no': seqNo,
      'patient_unique_id': patientUniqueId,
      'pam_type': pamType,
      'um_id': umId,
      'pm_id': pmId,
      'hm_id': hmId,
      'pam_appointment_type': pamAppointmentType,
      'pam_appointment_category': pamAppointmentCategory,
      'pam_previous_date': pamPreviousDate,
      'pam_app_date': pamAppDate,
      'pam_app_time': pamAppTime,
      'pam_app_end_time': pamAppEndTime,
      'pam_appointment_duration': pamAppointmentDuration,
      'pam_case_type': pamCaseType,
      'toct_id': toctId,
      'pam_status': pamStatus,
      'pam_cancel_reason': pamCancelReason,
      'pam_status_type_appointment': pamStatusTypeAppointment,
      'pam_appointment_remark': pamAppointmentRemark,
      'pam_call': pamCall,
      'pam_call_notification': pamCallNotification,
      'ring_flag': ringFlag,
      'call_flag': callFlag,
      'pam_txn_id': pamTxnId,
      'billing_payment_option': billingPaymentOption,
      'tcc_id': tccId,
      'pam_txn_date': pamTxnDate,
      'razorpay_payment_id': razorpayPaymentId,
      'razorpay_order_id': razorpayOrderId,
      'razorpay_signature': razorpaySignature,
      'pam_del': pamDel,
      'pam_created_by': pamCreatedBy,
      'pam_modified_by': pamModifiedBy,
      'pam_delete_by': pamDeleteBy,
      'pam_created_date': pamCreatedDate,
      'pam_modify_date': pamModifyDate,
      'patients': patients?.toJson(),
    };
  }
}

class Patients {
  int? pmId;
  String? pmFirstName;
  String? pmMiddleName;
  String? pmLastName;

  Patients({this.pmId, this.pmFirstName, this.pmMiddleName, this.pmLastName});

  factory Patients.fromJson(Map<String, dynamic> json) {
    return Patients(
      pmId: json['pm_id'],
      pmFirstName: json['pm_first_name'],
      pmMiddleName: json['pm_middle_name'],
      pmLastName: json['pm_last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pm_id': pmId,
      'pm_first_name': pmFirstName,
      'pm_middle_name': pmMiddleName,
      'pm_last_name': pmLastName,
    };
  }
}
