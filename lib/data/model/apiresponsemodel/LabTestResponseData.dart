class LabTestResponseData {
  bool? success;
  List<Data>? data;
  String? message;

  LabTestResponseData({this.success, this.data, this.message});

  LabTestResponseData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}


class Data {
  int? id;
  String? image;
  String? price;
  String? name;
  String? reportTime;
  String? createdAt;
  String? updatedAt;
  String? status;

  Data(
      {this.id,
      this.image,
      this.price,
      this.name,
      this.reportTime,
      this.createdAt,
      this.updatedAt,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    price = json['price'];
    name = json['name'];
    reportTime = json['report_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['price'] = price;
    data['name'] = name;
    data['report_time'] = reportTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    return data;
  }
}
