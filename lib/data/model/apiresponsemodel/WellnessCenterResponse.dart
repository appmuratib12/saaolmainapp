class WellnessCenterResponse {
  bool? success;
  List<Data>? data;

  WellnessCenterResponse({this.success, this.data});

  WellnessCenterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? image;
  String? video;
  String? centerName;
  String? locationName;
  String? content;
  String? lat;
  String? long;
  String? createdAt;
  String? updatedAt;
  String? status;
  List<String>? images;

  Data(
      {this.id,
        this.image,
        this.video,
        this.centerName,
        this.locationName,
        this.content,
        this.lat,
        this.long,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    video = json['video'];
    centerName = json['center_name'];
    locationName = json['location_name'];
    content = json['content'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['video'] = this.video;
    data['center_name'] = this.centerName;
    data['location_name'] = this.locationName;
    data['content'] = this.content;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['images'] = this.images;
    return data;
  }
}
