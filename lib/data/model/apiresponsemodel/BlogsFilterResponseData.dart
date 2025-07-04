class BlogsFilterResponseData {
  String? status;
  List<Data>? data;

  BlogsFilterResponseData({this.status, this.data});

  BlogsFilterResponseData.fromJson(Map<String, dynamic> json) {
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
  String? blogId;
  String? title;
  String? date;
  String? content;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.blogId,
        this.title,
        this.date,
        this.content,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blogId = json['blog_id'];
    title = json['title'];
    date = json['date'];
    content = json['content'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['blog_id'] = this.blogId;
    data['title'] = this.title;
    data['date'] = this.date;
    data['content'] = this.content;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
