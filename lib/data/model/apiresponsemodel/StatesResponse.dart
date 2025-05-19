class CenterStatesResponse {
  String? message;
  List<Data1>? data;

  CenterStatesResponse({this.message, this.data});

  CenterStatesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data1>[];
      json['data'].forEach((v) {
        data!.add(new Data1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data1 {
  String? stateName;
  String? image;

  Data1({this.stateName, this.image});

  Data1.fromJson(Map<String, dynamic> json) {
    stateName = json['state_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_name'] = this.stateName;
    data['image'] = this.image;
    return data;
  }
}
