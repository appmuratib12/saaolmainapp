class CenterStatesResponse {
  String? message;
  List<String>? data;

  CenterStatesResponse({this.message, this.data});

  CenterStatesResponse.fromJson(Map<String, dynamic> json) {
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
