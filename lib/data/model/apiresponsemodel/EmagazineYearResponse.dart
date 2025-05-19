class EmagazineYearResponse {
  String? title;
  List<String>? data;

  EmagazineYearResponse({this.title, this.data});

  EmagazineYearResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['data'] = this.data;
    return data;
  }
}
