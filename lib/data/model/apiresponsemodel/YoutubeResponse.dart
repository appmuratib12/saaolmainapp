class YoutubeResponse {
  bool? status;
  String? message;
  List<Data>? data;

  YoutubeResponse({this.status, this.message, this.data});

  YoutubeResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? videoId;
  String? category;
  String? like;
  String? title;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.videoId,
        this.category,
        this.like,
        this.title,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoId = json['video_id'];
    category = json['category'];
    like = json['like'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_id'] = this.videoId;
    data['category'] = this.category;
    data['like'] = this.like;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
