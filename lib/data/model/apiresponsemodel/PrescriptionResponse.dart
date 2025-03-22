class PrescriptionResponse {
  bool? status;
  String? message;
  List<Data>? data;

  PrescriptionResponse({this.status, this.message, this.data});

  PrescriptionResponse.fromJson(Map<String, dynamic> json) {
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
  int? tcmId;
  int? hmId;
  String? patientUniqueId;
  int? pmId;
  int? umId;
  Null? dpId;
  int? pamId;
  String? tcmDatetime;
  String? caseConsultationType;
  int? ctAngio;
  int? angiography;
  String? tcmBriefSummary;
  String? tcmNyhaAoe;
  String? tcmNyhaDoe;
  String? tcmPastHistory;
  String? tcmSystmeticExamination;
  String? tcmProvisionalDiagnosis;
  String? biochemistryId;
  String? tceId;
  String? tcmUsg;
  String? tcmUsgId;
  String? tmtId;
  String? tcxId;
  String? holterId;
  String? tcehId;
  String? ctParaId;
  Null? tcmTmmId;
  Null? tcmTmrType;
  Null? tcmTmmMedicineName;
  Null? tcmTmmGenericName;
  Null? tcmTmmTime;
  Null? tcmTmmDays;
  Null? tcmTmmDurationType;
  Null? tmmRoot;
  Null? tcmTmmFreqMorning;
  Null? tcmTmmFreqAfternoon;
  Null? tcmTmmFreqEvening;
  Null? tcmTmmFreqNight;
  Null? tmtdTmmSpecialInstructions;
  int? prescriptionId;
  String? tcmAdvice;
  String? adviceForEecp;
  String? adviceForDetox;
  String? timId;
  int? adviceDietitianStatus;
  int? adviceDietitianId;
  int? adviceDietChartId;
  String? tchbId;
  String? tpmrId;
  Null? tcmFollowupDate;
  String? tcmTaskText;
  int? tcmDel;
  int? tcmCreatedBy;
  int? tcmModifyBy;
  int? tcmDeleteBy;
  String? tcmCreatedDate;
  String? tcmModifyDate;

  Data(
      {this.tcmId,
        this.hmId,
        this.patientUniqueId,
        this.pmId,
        this.umId,
        this.dpId,
        this.pamId,
        this.tcmDatetime,
        this.caseConsultationType,
        this.ctAngio,
        this.angiography,
        this.tcmBriefSummary,
        this.tcmNyhaAoe,
        this.tcmNyhaDoe,
        this.tcmPastHistory,
        this.tcmSystmeticExamination,
        this.tcmProvisionalDiagnosis,
        this.biochemistryId,
        this.tceId,
        this.tcmUsg,
        this.tcmUsgId,
        this.tmtId,
        this.tcxId,
        this.holterId,
        this.tcehId,
        this.ctParaId,
        this.tcmTmmId,
        this.tcmTmrType,
        this.tcmTmmMedicineName,
        this.tcmTmmGenericName,
        this.tcmTmmTime,
        this.tcmTmmDays,
        this.tcmTmmDurationType,
        this.tmmRoot,
        this.tcmTmmFreqMorning,
        this.tcmTmmFreqAfternoon,
        this.tcmTmmFreqEvening,
        this.tcmTmmFreqNight,
        this.tmtdTmmSpecialInstructions,
        this.prescriptionId,
        this.tcmAdvice,
        this.adviceForEecp,
        this.adviceForDetox,
        this.timId,
        this.adviceDietitianStatus,
        this.adviceDietitianId,
        this.adviceDietChartId,
        this.tchbId,
        this.tpmrId,
        this.tcmFollowupDate,
        this.tcmTaskText,
        this.tcmDel,
        this.tcmCreatedBy,
        this.tcmModifyBy,
        this.tcmDeleteBy,
        this.tcmCreatedDate,
        this.tcmModifyDate});

  Data.fromJson(Map<String, dynamic> json) {
    tcmId = json['tcm_id'];
    hmId = json['hm_id'];
    patientUniqueId = json['patient_unique_id'];
    pmId = json['pm_id'];
    umId = json['um_id'];
    dpId = json['dp_id'];
    pamId = json['pam_id'];
    tcmDatetime = json['tcm_datetime'];
    caseConsultationType = json['case_consultation_type'];
    ctAngio = json['ct_angio'];
    angiography = json['angiography'];
    tcmBriefSummary = json['tcm_brief_summary'];
    tcmNyhaAoe = json['tcm_nyha_aoe'];
    tcmNyhaDoe = json['tcm_nyha_doe'];
    tcmPastHistory = json['tcm_past_history'];
    tcmSystmeticExamination = json['tcm_systmetic_examination'];
    tcmProvisionalDiagnosis = json['tcm_provisional_diagnosis'];
    biochemistryId = json['biochemistry_id'];
    tceId = json['tce_id'];
    tcmUsg = json['tcm_usg'];
    tcmUsgId = json['tcm_usg_id'];
    tmtId = json['tmt_id'];
    tcxId = json['tcx_id'];
    holterId = json['holter_id'];
    tcehId = json['tceh_id'];
    ctParaId = json['ct_para_id'];
    tcmTmmId = json['tcm_tmm_id'];
    tcmTmrType = json['tcm_tmr_type'];
    tcmTmmMedicineName = json['tcm_tmm_medicine_name'];
    tcmTmmGenericName = json['tcm_tmm_generic_name'];
    tcmTmmTime = json['tcm_tmm_time'];
    tcmTmmDays = json['tcm_tmm_days'];
    tcmTmmDurationType = json['tcm_tmm_duration_type'];
    tmmRoot = json['tmm_root'];
    tcmTmmFreqMorning = json['tcm_tmm_freq_morning'];
    tcmTmmFreqAfternoon = json['tcm_tmm_freq_afternoon'];
    tcmTmmFreqEvening = json['tcm_tmm_freq_evening'];
    tcmTmmFreqNight = json['tcm_tmm_freq_night'];
    tmtdTmmSpecialInstructions = json['tmtd_tmm_special_instructions'];
    prescriptionId = json['prescription_id'];
    tcmAdvice = json['tcm_advice'];
    adviceForEecp = json['advice_for_eecp'];
    adviceForDetox = json['advice_for_detox'];
    timId = json['tim_id'];
    adviceDietitianStatus = json['advice_dietitian_status'];
    adviceDietitianId = json['advice_dietitian_id'];
    adviceDietChartId = json['advice_diet_chart_id'];
    tchbId = json['tchb_id'];
    tpmrId = json['tpmr_id'];
    tcmFollowupDate = json['tcm_followup_date'];
    tcmTaskText = json['tcm_task_text'];
    tcmDel = json['tcm_del'];
    tcmCreatedBy = json['tcm_created_by'];
    tcmModifyBy = json['tcm_modify_by'];
    tcmDeleteBy = json['tcm_delete_by'];
    tcmCreatedDate = json['tcm_created_date'];
    tcmModifyDate = json['tcm_modify_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tcm_id'] = this.tcmId;
    data['hm_id'] = this.hmId;
    data['patient_unique_id'] = this.patientUniqueId;
    data['pm_id'] = this.pmId;
    data['um_id'] = this.umId;
    data['dp_id'] = this.dpId;
    data['pam_id'] = this.pamId;
    data['tcm_datetime'] = this.tcmDatetime;
    data['case_consultation_type'] = this.caseConsultationType;
    data['ct_angio'] = this.ctAngio;
    data['angiography'] = this.angiography;
    data['tcm_brief_summary'] = this.tcmBriefSummary;
    data['tcm_nyha_aoe'] = this.tcmNyhaAoe;
    data['tcm_nyha_doe'] = this.tcmNyhaDoe;
    data['tcm_past_history'] = this.tcmPastHistory;
    data['tcm_systmetic_examination'] = this.tcmSystmeticExamination;
    data['tcm_provisional_diagnosis'] = this.tcmProvisionalDiagnosis;
    data['biochemistry_id'] = this.biochemistryId;
    data['tce_id'] = this.tceId;
    data['tcm_usg'] = this.tcmUsg;
    data['tcm_usg_id'] = this.tcmUsgId;
    data['tmt_id'] = this.tmtId;
    data['tcx_id'] = this.tcxId;
    data['holter_id'] = this.holterId;
    data['tceh_id'] = this.tcehId;
    data['ct_para_id'] = this.ctParaId;
    data['tcm_tmm_id'] = this.tcmTmmId;
    data['tcm_tmr_type'] = this.tcmTmrType;
    data['tcm_tmm_medicine_name'] = this.tcmTmmMedicineName;
    data['tcm_tmm_generic_name'] = this.tcmTmmGenericName;
    data['tcm_tmm_time'] = this.tcmTmmTime;
    data['tcm_tmm_days'] = this.tcmTmmDays;
    data['tcm_tmm_duration_type'] = this.tcmTmmDurationType;
    data['tmm_root'] = this.tmmRoot;
    data['tcm_tmm_freq_morning'] = this.tcmTmmFreqMorning;
    data['tcm_tmm_freq_afternoon'] = this.tcmTmmFreqAfternoon;
    data['tcm_tmm_freq_evening'] = this.tcmTmmFreqEvening;
    data['tcm_tmm_freq_night'] = this.tcmTmmFreqNight;
    data['tmtd_tmm_special_instructions'] = this.tmtdTmmSpecialInstructions;
    data['prescription_id'] = this.prescriptionId;
    data['tcm_advice'] = this.tcmAdvice;
    data['advice_for_eecp'] = this.adviceForEecp;
    data['advice_for_detox'] = this.adviceForDetox;
    data['tim_id'] = this.timId;
    data['advice_dietitian_status'] = this.adviceDietitianStatus;
    data['advice_dietitian_id'] = this.adviceDietitianId;
    data['advice_diet_chart_id'] = this.adviceDietChartId;
    data['tchb_id'] = this.tchbId;
    data['tpmr_id'] = this.tpmrId;
    data['tcm_followup_date'] = this.tcmFollowupDate;
    data['tcm_task_text'] = this.tcmTaskText;
    data['tcm_del'] = this.tcmDel;
    data['tcm_created_by'] = this.tcmCreatedBy;
    data['tcm_modify_by'] = this.tcmModifyBy;
    data['tcm_delete_by'] = this.tcmDeleteBy;
    data['tcm_created_date'] = this.tcmCreatedDate;
    data['tcm_modify_date'] = this.tcmModifyDate;
    return data;
  }
}
