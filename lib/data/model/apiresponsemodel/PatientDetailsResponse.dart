class PatientDetailsResponse {
  bool? status;
  String? message;
  List<Data>? data;

  PatientDetailsResponse({this.status, this.message, this.data});

  PatientDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  int? pmId;
  String? patientUniqueId;
  int? seqNo;
  String? pmRefId;
  int? hmId;
  int? umId;
  int? rmId;
  String? pmRmName;
  int? otherRef;
  int? pcId;
  String? pmSalutation;
  String? pmFirstName;
  String? pmMiddleName;
  String? pmLastName;
  String? pmGender;
  String? pmDob;
  String? pmContactNo;
  String? pmContactNoCountryCode;
  String? pmWhatsappNo;
  String? pmEmail;
  String? pmImages;
  Null? pmTxnId;
  String? pmOccupation;
  Null? pmPreLang;
  String? pmAddress;
  String? pmPincode;
  Null? pmArea;
  Null? pmCity;
  String? pmDistrict;
  String? pmState;
  String? pmCountry;
  Null? pmBloodGroup;
  Null? pmOtherAddress;
  Null? pmNationality;
  Null? pmMediclaim;
  Null? pmRemarks;
  Null? pmReceptionRemark;
  Null? pmDoctorRemark;
  Null? pmSecondName;
  String? pmContactNo2;
  Null? pmRelation;
  Null? pmSecondGender;
  Null? pmSecondDob;
  Null? pmSecondOccupation;
  Null? pmAppointmentDate;
  Null? pmAppointmentTime;
  Null? pmAppointmentType;
  Null? pmCaseType;
  int? toctId;
  Null? pmBarcodeImage;
  String? pmPassword;
  Null? pmImage;
  String? pmAppointmentCategory;
  String? leadUniqueId;
  int? lmId;
  Null? pmTransferredFrom;
  Null? transferReason;
  Null? transferredBy;
  int? pmDel;
  int? pmCreatedBy;
  int? pmModifyBy;
  Null? pmDeleteBy;
  int? pmDnd;
  String? pmCreatedDate;
  String? pmModifyDate;

  Data(
      {this.pmId,
        this.patientUniqueId,
        this.seqNo,
        this.pmRefId,
        this.hmId,
        this.umId,
        this.rmId,
        this.pmRmName,
        this.otherRef,
        this.pcId,
        this.pmSalutation,
        this.pmFirstName,
        this.pmMiddleName,
        this.pmLastName,
        this.pmGender,
        this.pmDob,
        this.pmContactNo,
        this.pmContactNoCountryCode,
        this.pmWhatsappNo,
        this.pmEmail,
        this.pmImages,
        this.pmTxnId,
        this.pmOccupation,
        this.pmPreLang,
        this.pmAddress,
        this.pmPincode,
        this.pmArea,
        this.pmCity,
        this.pmDistrict,
        this.pmState,
        this.pmCountry,
        this.pmBloodGroup,
        this.pmOtherAddress,
        this.pmNationality,
        this.pmMediclaim,
        this.pmRemarks,
        this.pmReceptionRemark,
        this.pmDoctorRemark,
        this.pmSecondName,
        this.pmContactNo2,
        this.pmRelation,
        this.pmSecondGender,
        this.pmSecondDob,
        this.pmSecondOccupation,
        this.pmAppointmentDate,
        this.pmAppointmentTime,
        this.pmAppointmentType,
        this.pmCaseType,
        this.toctId,
        this.pmBarcodeImage,
        this.pmPassword,
        this.pmImage,
        this.pmAppointmentCategory,
        this.leadUniqueId,
        this.lmId,
        this.pmTransferredFrom,
        this.transferReason,
        this.transferredBy,
        this.pmDel,
        this.pmCreatedBy,
        this.pmModifyBy,
        this.pmDeleteBy,
        this.pmDnd,
        this.pmCreatedDate,
        this.pmModifyDate});

  Data.fromJson(Map<String, dynamic> json) {
    pmId = json['pm_id'];
    patientUniqueId = json['patient_unique_id'];
    seqNo = json['seq_no'];
    pmRefId = json['pm_ref_id'];
    hmId = json['hm_id'];
    umId = json['um_id'];
    rmId = json['rm_id'];
    pmRmName = json['pm_rm_name'];
    otherRef = json['other_ref'];
    pcId = json['pc_id'];
    pmSalutation = json['pm_salutation'];
    pmFirstName = json['pm_first_name'];
    pmMiddleName = json['pm_middle_name'];
    pmLastName = json['pm_last_name'];
    pmGender = json['pm_gender'];
    pmDob = json['pm_dob'];
    pmContactNo = json['pm_contact_no'];
    pmContactNoCountryCode = json['pm_contact_no_country_code'];
    pmWhatsappNo = json['pm_whatsapp_no'];
    pmEmail = json['pm_email'];
    pmImages = json['pm_images'];
    pmTxnId = json['pm_txn_id'];
    pmOccupation = json['pm_occupation'];
    pmPreLang = json['pm_pre_lang'];
    pmAddress = json['pm_address'];
    pmPincode = json['pm_pincode'];
    pmArea = json['pm_area'];
    pmCity = json['pm_city'];
    pmDistrict = json['pm_district'];
    pmState = json['pm_state'];
    pmCountry = json['pm_country'];
    pmBloodGroup = json['pm_blood_group'];
    pmOtherAddress = json['pm_other_address'];
    pmNationality = json['pm_nationality'];
    pmMediclaim = json['pm_mediclaim'];
    pmRemarks = json['pm_remarks'];
    pmReceptionRemark = json['pm_reception_remark'];
    pmDoctorRemark = json['pm_doctor_remark'];
    pmSecondName = json['pm_second_name'];
    pmContactNo2 = json['pm_contact_no2'];
    pmRelation = json['pm_relation'];
    pmSecondGender = json['pm_second_gender'];
    pmSecondDob = json['pm_second_dob'];
    pmSecondOccupation = json['pm_second_occupation'];
    pmAppointmentDate = json['pm_appointment_date'];
    pmAppointmentTime = json['pm_appointment_time'];
    pmAppointmentType = json['pm_appointment_type'];
    pmCaseType = json['pm_case_type'];
    toctId = json['toct_id'];
    pmBarcodeImage = json['pm_barcode_image'];
    pmPassword = json['pm_password'];
    pmImage = json['pm_image'];
    pmAppointmentCategory = json['pm_appointment_category'];
    leadUniqueId = json['lead_unique_id'];
    lmId = json['lm_id'];
    pmTransferredFrom = json['pm_transferred_from'];
    transferReason = json['transfer_reason'];
    transferredBy = json['transferred_by'];
    pmDel = json['pm_del'];
    pmCreatedBy = json['pm_created_by'];
    pmModifyBy = json['pm_modify_by'];
    pmDeleteBy = json['pm_delete_by'];
    pmDnd = json['pm_dnd'];
    pmCreatedDate = json['pm_created_date'];
    pmModifyDate = json['pm_modify_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pm_id'] = this.pmId;
    data['patient_unique_id'] = this.patientUniqueId;
    data['seq_no'] = this.seqNo;
    data['pm_ref_id'] = this.pmRefId;
    data['hm_id'] = this.hmId;
    data['um_id'] = this.umId;
    data['rm_id'] = this.rmId;
    data['pm_rm_name'] = this.pmRmName;
    data['other_ref'] = this.otherRef;
    data['pc_id'] = this.pcId;
    data['pm_salutation'] = this.pmSalutation;
    data['pm_first_name'] = this.pmFirstName;
    data['pm_middle_name'] = this.pmMiddleName;
    data['pm_last_name'] = this.pmLastName;
    data['pm_gender'] = this.pmGender;
    data['pm_dob'] = this.pmDob;
    data['pm_contact_no'] = this.pmContactNo;
    data['pm_contact_no_country_code'] = this.pmContactNoCountryCode;
    data['pm_whatsapp_no'] = this.pmWhatsappNo;
    data['pm_email'] = this.pmEmail;
    data['pm_images'] = this.pmImages;
    data['pm_txn_id'] = this.pmTxnId;
    data['pm_occupation'] = this.pmOccupation;
    data['pm_pre_lang'] = this.pmPreLang;
    data['pm_address'] = this.pmAddress;
    data['pm_pincode'] = this.pmPincode;
    data['pm_area'] = this.pmArea;
    data['pm_city'] = this.pmCity;
    data['pm_district'] = this.pmDistrict;
    data['pm_state'] = this.pmState;
    data['pm_country'] = this.pmCountry;
    data['pm_blood_group'] = this.pmBloodGroup;
    data['pm_other_address'] = this.pmOtherAddress;
    data['pm_nationality'] = this.pmNationality;
    data['pm_mediclaim'] = this.pmMediclaim;
    data['pm_remarks'] = this.pmRemarks;
    data['pm_reception_remark'] = this.pmReceptionRemark;
    data['pm_doctor_remark'] = this.pmDoctorRemark;
    data['pm_second_name'] = this.pmSecondName;
    data['pm_contact_no2'] = this.pmContactNo2;
    data['pm_relation'] = this.pmRelation;
    data['pm_second_gender'] = this.pmSecondGender;
    data['pm_second_dob'] = this.pmSecondDob;
    data['pm_second_occupation'] = this.pmSecondOccupation;
    data['pm_appointment_date'] = this.pmAppointmentDate;
    data['pm_appointment_time'] = this.pmAppointmentTime;
    data['pm_appointment_type'] = this.pmAppointmentType;
    data['pm_case_type'] = this.pmCaseType;
    data['toct_id'] = this.toctId;
    data['pm_barcode_image'] = this.pmBarcodeImage;
    data['pm_password'] = this.pmPassword;
    data['pm_image'] = this.pmImage;
    data['pm_appointment_category'] = this.pmAppointmentCategory;
    data['lead_unique_id'] = this.leadUniqueId;
    data['lm_id'] = this.lmId;
    data['pm_transferred_from'] = this.pmTransferredFrom;
    data['transfer_reason'] = this.transferReason;
    data['transferred_by'] = this.transferredBy;
    data['pm_del'] = this.pmDel;
    data['pm_created_by'] = this.pmCreatedBy;
    data['pm_modify_by'] = this.pmModifyBy;
    data['pm_delete_by'] = this.pmDeleteBy;
    data['pm_dnd'] = this.pmDnd;
    data['pm_created_date'] = this.pmCreatedDate;
    data['pm_modify_date'] = this.pmModifyDate;
    return data;
  }
}
