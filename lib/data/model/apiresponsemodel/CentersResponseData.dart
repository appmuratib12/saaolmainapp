/*
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
*/


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
        data!.add(new Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Data {
  int? id;
  String? stateName;
  String? cityName;
  String? cityAddr;
  String? phoneNo;
  String? centerEmail;
  String? openingDays;
  String? timings;
  String? timingsUpdate;
  String? ccEmail;
  String? iframeUrl;
  String? iframeTitle;
  String? centerUrl;
  String? centerAppointmentUrl;
  String? hmPincodeCoordinates;
  String? image;
  String? status;
  double? distance;

  Data(
      {this.id,
        this.stateName,
        this.cityName,
        this.cityAddr,
        this.phoneNo,
        this.centerEmail,
        this.openingDays,
        this.timings,
        this.timingsUpdate,
        this.ccEmail,
        this.iframeUrl,
        this.iframeTitle,
        this.centerUrl,
        this.centerAppointmentUrl,
        this.hmPincodeCoordinates,
        this.image,
        this.status,
        this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    cityAddr = json['city_addr'];
    phoneNo = json['phone_no'];
    centerEmail = json['center_email'];
    openingDays = json['opening_days'];
    timings = json['timings'];
    timingsUpdate = json['timings_update'];
    ccEmail = json['cc_email'];
    iframeUrl = json['iframe_url'];
    iframeTitle = json['iframe_title'];
    centerUrl = json['center_url'];
    centerAppointmentUrl = json['center_appointment_url'];
    hmPincodeCoordinates = json['hm_pincode_coordinates'];
    image = json['image'];
    status = json['status'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['city_addr'] = this.cityAddr;
    data['phone_no'] = this.phoneNo;
    data['center_email'] = this.centerEmail;
    data['opening_days'] = this.openingDays;
    data['timings'] = this.timings;
    data['timings_update'] = this.timingsUpdate;
    data['cc_email'] = this.ccEmail;
    data['iframe_url'] = this.iframeUrl;
    data['iframe_title'] = this.iframeTitle;
    data['center_url'] = this.centerUrl;
    data['center_appointment_url'] = this.centerAppointmentUrl;
    data['hm_pincode_coordinates'] = this.hmPincodeCoordinates;
    data['image'] = this.image;
    data['status'] = this.status;
    data['distance'] = this.distance;
    return data;
  }
}
