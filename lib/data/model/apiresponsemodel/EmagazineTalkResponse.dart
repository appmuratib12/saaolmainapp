class EmagazineTalkResponse {
  bool? status;
  List<Data>? data;

  EmagazineTalkResponse({this.status, this.data});

  EmagazineTalkResponse.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? type;
  String? content;
  String? month;

  Data({this.image, this.type, this.content, this.month});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    type = json['type'];
    content = json['content'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['type'] = this.type;
    data['content'] = this.content;
    data['month'] = this.month;
    return data;
  }
}
