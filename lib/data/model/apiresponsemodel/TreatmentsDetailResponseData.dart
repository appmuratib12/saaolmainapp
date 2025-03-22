class TreatmentsDetailResponseData {
  String? status;
  Data? data;

  TreatmentsDetailResponseData({this.status, this.data});

  TreatmentsDetailResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? chooseTreatment;
  String? chooseDescriptionImage;
  String? chooseAdvantageImage;
  String? chooseDisadvantageImage;
  String? description;
  String? advantage;
  String? disadvantge;
  String? whythisOtherData;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.chooseTreatment,
      this.chooseDescriptionImage,
      this.chooseAdvantageImage,
      this.chooseDisadvantageImage,
      this.description,
      this.advantage,
      this.disadvantge,
      this.whythisOtherData,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chooseTreatment = json['choose_treatment'];
    chooseDescriptionImage = json['choose_description_image'];
    chooseAdvantageImage = json['choose_advantage_image'];
    chooseDisadvantageImage = json['choose_disadvantage_image'];
    description = json['description'];
    advantage = json['advantage'];
    disadvantge = json['disadvantge'];
    whythisOtherData = json['whythis_other_data'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['choose_treatment'] = chooseTreatment;
    data['choose_description_image'] = chooseDescriptionImage;
    data['choose_advantage_image'] = chooseAdvantageImage;
    data['choose_disadvantage_image'] = chooseDisadvantageImage;
    data['description'] = description;
    data['advantage'] = advantage;
    data['disadvantge'] = disadvantge;
    data['whythis_other_data'] = whythisOtherData;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
