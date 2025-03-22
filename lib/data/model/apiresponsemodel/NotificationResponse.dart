class NotificationResponse {
  String? status;
  String? msg;
  List<Data>? data;

  NotificationResponse({this.status, this.msg, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
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
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? notificationType;
  String? image;
  String? msg;
  String? title;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.notificationType,
      this.image,
      this.msg,
      this.title,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationType = json['notification_type'];
    image = json['image'];
    msg = json['msg'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notification_type'] = notificationType;
    data['image'] = image;
    data['msg'] = msg;
    data['title'] = title;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
