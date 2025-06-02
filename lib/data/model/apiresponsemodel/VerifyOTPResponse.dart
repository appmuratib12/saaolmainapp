class VerifyOTPResponse {
  String? status;
  String? message;
  String? accessToken;
  String? tokenType;
  int? id;
  String? name;
  String? image;

  VerifyOTPResponse({
    this.status,
    this.message,
    this.accessToken,
    this.tokenType,
    this.id,
    this.name,
    this.image,
  });

  VerifyOTPResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    id = json['id'];
    name = json['name']?.toString();
    image = json['image']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'access_token': accessToken,
      'token_type': tokenType,
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
