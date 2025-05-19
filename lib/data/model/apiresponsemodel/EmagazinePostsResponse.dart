class EmagazinePostsResponse {
  bool? status;
  List<Data>? data;

  EmagazinePostsResponse({this.status, this.data});

  EmagazinePostsResponse.fromJson(Map<String, dynamic> json) {
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
  Null? date;
  String? month;
  String? year;
  String? time;
  String? image;
  String? title;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.date,
        this.month,
        this.year,
        this.time,
        this.image,
        this.title,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    month = json['month'];
    year = json['year'];
    time = json['time'];
    image = json['image'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['month'] = this.month;
    data['year'] = this.year;
    data['time'] = this.time;
    data['image'] = this.image;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
