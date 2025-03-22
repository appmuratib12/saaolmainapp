class BlogsResponseData {
  List<Blogs>? blogs;

  BlogsResponseData({this.blogs});

  BlogsResponseData.fromJson(Map<String, dynamic> json) {
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (blogs != null) {
      data['blogs'] = blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  int? id;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? image;
  String? link;
  String? category;

  Blogs(
      {this.id,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.image,
        this.link,
        this.category});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    image = json['image'];
    link = json['link'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    data['image'] = image;
    data['link'] = link;
    data['category'] = category;
    return data;
  }
}
