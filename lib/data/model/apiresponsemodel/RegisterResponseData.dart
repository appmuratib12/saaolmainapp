class RegisterResponseData {
  String? status;
  String? message;
  Data? data;

  RegisterResponseData({this.status, this.message, this.data});

  RegisterResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  Null? lastName;
  String? mobile;
  String? email;
  Null? role;
  String? image;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? profilePhotoUrl;

  Data(
      {this.name,
      this.lastName,
      this.mobile,
      this.email,
      this.role,
      this.image,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.profilePhotoUrl});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    role = json['role'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['role'] = role;
    data['image'] = image;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['profile_photo_url'] = profilePhotoUrl;
    return data;
  }
}
