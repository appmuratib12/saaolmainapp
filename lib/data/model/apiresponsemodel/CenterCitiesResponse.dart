class CenterCitiesResponse {
  String? message;
  List<Data>? data;

  CenterCitiesResponse({this.message, this.data});

  CenterCitiesResponse.fromJson(Map<String, dynamic> json) {
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? cityName;
  String? image;

  Data({this.cityName, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_name'] = this.cityName;
    data['image'] = this.image;
    return data;
  }
}
