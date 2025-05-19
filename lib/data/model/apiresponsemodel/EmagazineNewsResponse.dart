class EmagazineNewsResponse {
  bool? status;
  List<Data>? data;

  EmagazineNewsResponse({this.status, this.data});

  EmagazineNewsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? catgeoryId;
  String? title;
  String? tag;
  String? content;
  String? image;
  String? month;
  String? year;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? link;
  String? heading;

  Data(
      {this.id,
        this.catgeoryId,
        this.title,
        this.tag,
        this.content,
        this.image,
        this.month,
        this.year,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.link,
        this.heading});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catgeoryId = json['catgeory_id'];
    title = json['title'];
    tag = json['tag'];
    content = json['content'];
    image = json['image'];
    month = json['month'];
    year = json['year'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    link = json['link'];
    heading = json['heading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catgeory_id'] = this.catgeoryId;
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['content'] = this.content;
    data['image'] = this.image;
    data['month'] = this.month;
    data['year'] = this.year;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['link'] = this.link;
    data['heading'] = this.heading;
    return data;
  }
}
