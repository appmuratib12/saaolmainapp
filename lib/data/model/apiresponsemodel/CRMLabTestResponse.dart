class CRMLabTestResponse {
  bool? status;
  String? message;
  List<Data>? data;

  CRMLabTestResponse({this.status, this.message, this.data});

  CRMLabTestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? imId;
  String? testName;
  String? totalPrice;

  Data({this.imId, this.testName, this.totalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    imId = json['im_id'];
    testName = json['test_name'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['im_id'] = imId;
    data['test_name'] = testName;
    data['total_price'] = totalPrice;
    return data;
  }
}
