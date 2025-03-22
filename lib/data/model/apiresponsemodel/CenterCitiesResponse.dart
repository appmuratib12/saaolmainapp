class CenterCitiesResponse {
  String? message;
  List<String>? data;

  CenterCitiesResponse({this.message, this.data});

  CenterCitiesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
