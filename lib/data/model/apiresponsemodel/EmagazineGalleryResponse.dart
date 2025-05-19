class EmagazineGalleryResponse {
  bool? success;
  bool? matched;
  Gallery? gallery;

  EmagazineGalleryResponse({this.success, this.matched, this.gallery});

  EmagazineGalleryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    matched = json['matched'];
    gallery =
    json['gallery'] != null ? new Gallery.fromJson(json['gallery']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['matched'] = this.matched;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.toJson();
    }
    return data;
  }
}

class Gallery {
  int? id;
  String? year;
  String? month;
  String? title;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? content;
  String? emagzineMonth;
  String? monthName;

  Gallery(
      {this.id,
        this.year,
        this.month,
        this.title,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.content,
        this.emagzineMonth,
        this.monthName});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    month = json['month'];
    title = json['title'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    content = json['content'];
    emagzineMonth = json['emagzine_month'];
    monthName = json['monthName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['month'] = this.month;
    data['title'] = this.title;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content'] = this.content;
    data['emagzine_month'] = this.emagzineMonth;
    data['monthName'] = this.monthName;
    return data;
  }
}
