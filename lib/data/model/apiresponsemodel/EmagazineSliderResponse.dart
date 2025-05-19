class EmagazineSliderResponse {
  String? year;
  String? month;
  List<EmagazineDataSlider>? data;

  EmagazineSliderResponse({this.year, this.month, this.data});

  EmagazineSliderResponse.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    if (json['data'] != null) {
      data = <EmagazineDataSlider>[];
      json['data'].forEach((v) {
        data!.add(new EmagazineDataSlider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmagazineDataSlider {
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

  EmagazineDataSlider(
      {this.id,
        this.year,
        this.month,
        this.title,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.content,
        this.emagzineMonth});

  EmagazineDataSlider.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
