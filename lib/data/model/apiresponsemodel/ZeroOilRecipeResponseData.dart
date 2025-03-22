class ZeroOilRecipeResponseData {
  String? status;
  String? message;
  List<Data>? data;

  ZeroOilRecipeResponseData({this.status, this.message, this.data});

  ZeroOilRecipeResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? image;
  String? tag;
  String? contentCard;
  String? chooseTreatmentDetail;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.image,
      this.tag,
      this.contentCard,
      this.chooseTreatmentDetail,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    tag = json['tag'];
    contentCard = json['content_card'];
    chooseTreatmentDetail = json['choose_treatment_detail'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['tag'] = tag;
    data['content_card'] = contentCard;
    data['choose_treatment_detail'] = chooseTreatmentDetail;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
