class CentersResponseData {
  String? status;
  String? message;
  List<Data>? data;
  int? statusCode;

  CentersResponseData({this.status, this.message, this.data, this.statusCode});

  CentersResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = statusCode;
    return data;
  }
}

class Data {
  int? id;
  String? centerName;
  String? contactNo;
  String? address1;
  String? area;
  String? city;
  String? state;
  String? pincode;
  String? hmPincodeCoordinates;
  String? status;
  double? distance;

  Data(
      {this.id,
      this.centerName,
      this.contactNo,
      this.address1,
      this.area,
      this.city,
      this.state,
      this.pincode,
      this.hmPincodeCoordinates,
      this.status,
      this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centerName = json['center_name'];
    contactNo = json['contact_no'];
    address1 = json['address1'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    hmPincodeCoordinates = json['hm_pincode_coordinates'];
    status = json['status'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['center_name'] = centerName;
    data['contact_no'] = contactNo;
    data['address1'] = address1;
    data['area'] = area;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['hm_pincode_coordinates'] = hmPincodeCoordinates;
    data['status'] = status;
    data['distance'] = distance;
    return data;
  }
}
