class ProfileUpdateResponse {
  String? status;
  String? message;
  Data? data;

  ProfileUpdateResponse({this.status, this.message, this.data});

  ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  int? role;
  String? status;
  dynamic middleName;
  dynamic lastName;
  dynamic countryCode;
  String? mobile;
  dynamic image;
  dynamic aboutUs;
  dynamic deletedAt;
  dynamic address;
  dynamic age;
  dynamic googleId;
  dynamic token;
  String? profilePhotoUrl;

  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.twoFactorConfirmedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.status,
    this.middleName,
    this.lastName,
    this.countryCode,
    this.mobile,
    this.image,
    this.aboutUs,
    this.deletedAt,
    this.address,
    this.age,
    this.googleId,
    this.token,
    this.profilePhotoUrl,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    status = json['status'];
    middleName = json['Middle_name'];
    lastName = json['last_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    image = json['image'];
    aboutUs = json['about_us'];
    deletedAt = json['deleted_at'];
    address = json['address'];
    age = json['age'];
    googleId = json['google_id'];
    token = json['token'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['current_team_id'] = currentTeamId;
    data['profile_photo_path'] = profilePhotoPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['role'] = role;
    data['status'] = status;
    data['Middle_name'] = middleName;
    data['last_name'] = lastName;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['image'] = image;
    data['about_us'] = aboutUs;
    data['deleted_at'] = deletedAt;
    data['address'] = address;
    data['age'] = age;
    data['google_id'] = googleId;
    data['token'] = token;
    data['profile_photo_url'] = profilePhotoUrl;
    return data;
  }
}
