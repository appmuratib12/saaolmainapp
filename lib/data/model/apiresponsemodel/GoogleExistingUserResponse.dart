class GoogleExistingUserResponse {
  String? status;
  String? message;
  Data? data;

  GoogleExistingUserResponse({this.status, this.message, this.data});

  GoogleExistingUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['status'] = status;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? twoFactorConfirmedAt;
  String? currentTeamId;
  String? profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  int? role;
  String? status;
  String? middleName;
  String? lastName;
  String? mobile;
  String? image;
  String? aboutUs;
  String? deletedAt;
  String? address;
  String? age; // handled as string
  String? googleId;
  String? token;
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
    emailVerifiedAt = json['email_verified_at']?.toString();
    twoFactorConfirmedAt = json['two_factor_confirmed_at']?.toString();
    currentTeamId = json['current_team_id']?.toString();
    profilePhotoPath = json['profile_photo_path']?.toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    status = json['status'];
    middleName = json['Middle_name']?.toString();
    lastName = json['last_name']?.toString();
    mobile = json['mobile']?.toString();
    image = json['image']?.toString();
    aboutUs = json['about_us']?.toString();
    deletedAt = json['deleted_at']?.toString();
    address = json['address']?.toString();
    age = json['age']?.toString(); // always safe as String
    googleId = json['google_id'];
    token = json['token'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['name'] = name;
    result['email'] = email;
    result['email_verified_at'] = emailVerifiedAt;
    result['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    result['current_team_id'] = currentTeamId;
    result['profile_photo_path'] = profilePhotoPath;
    result['created_at'] = createdAt;
    result['updated_at'] = updatedAt;
    result['role'] = role;
    result['status'] = status;
    result['Middle_name'] = middleName;
    result['last_name'] = lastName;
    result['mobile'] = mobile;
    result['image'] = image;
    result['about_us'] = aboutUs;
    result['deleted_at'] = deletedAt;
    result['address'] = address;
    result['age'] = age;
    result['google_id'] = googleId;
    result['token'] = token;
    result['profile_photo_url'] = profilePhotoUrl;
    return result;
  }
}
