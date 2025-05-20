class GoogleUserResponse {
  String? status;
  String? message;
  Data? data;

  GoogleUserResponse({this.status, this.message, this.data});

  GoogleUserResponse.fromJson(Map<String, dynamic> json) {
    print("Parsing GoogleUserResponse: $json"); // Add this
    status = json['status']?.toString();
    message = json['message']?.toString();
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? googleId;
  Null? image;
  String? token;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? profilePhotoUrl;

  Data(
      {this.name,
        this.email,
        this.googleId,
        this.image,
        this.token,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.profilePhotoUrl});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    googleId = json['google_id'];
    image = json['image'];
    token = json['token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['google_id'] = this.googleId;
    data['image'] = this.image;
    data['token'] = this.token;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
