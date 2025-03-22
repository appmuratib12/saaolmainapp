class NearestCenterResponseData {
  bool? success;
  Location? location;
  List<Centers>? centers;

  NearestCenterResponseData({this.success, this.location, this.centers});

  NearestCenterResponseData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['centers'] != null) {
      centers = <Centers>[];
      json['centers'].forEach((v) {
        centers!.add(new Centers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (centers != null) {
      data['centers'] = centers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String? pincode;
  double? latitude;
  double? longitude;

  Location({this.pincode, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pincode'] = pincode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Centers {
  int? id;
  String? centerName;
  String? hmPincodeCoordinates;
  String? contactNo;
  String? iframeUrl;
  String? city;
  String? address1;
  double? distance;
  String? distanceText;
  String? durationText;
  String? googleMapsDirections;

  Centers(
      {this.id,
      this.centerName,
      this.hmPincodeCoordinates,
      this.contactNo,
      this.iframeUrl,
      this.city,
      this.address1,
      this.distance,
      this.distanceText,
      this.durationText,
      this.googleMapsDirections});

  Centers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centerName = json['center_name'];
    hmPincodeCoordinates = json['hm_pincode_coordinates'];
    contactNo = json['contact_no'];
    iframeUrl = json['iframe_url'];
    city = json['city'];
    address1 = json['address1'];
    distance = json['distance'];
    distanceText = json['distance_text'];
    durationText = json['duration_text'];
    googleMapsDirections = json['google_maps_directions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['center_name'] = centerName;
    data['hm_pincode_coordinates'] = hmPincodeCoordinates;
    data['contact_no'] = contactNo;
    data['iframe_url'] = iframeUrl;
    data['city'] = city;
    data['address1'] = address1;
    data['distance'] = distance;
    data['distance_text'] = distanceText;
    data['duration_text'] = durationText;
    data['google_maps_directions'] = googleMapsDirections;
    return data;
  }
}
