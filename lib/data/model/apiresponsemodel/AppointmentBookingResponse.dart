class AppointmentBookingResponse {
  String status;
  Data? data;

  AppointmentBookingResponse({
    required this.status,
    this.data,
  });

  factory AppointmentBookingResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentBookingResponse(
      status: json['status'] ?? '',
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class Data {
  final String appointmentType;
  final String name;
  final String email;
  final String mobile;
  final String countryCode;
  final String address;
  final String centerName;
  final String appointmentDate;
  final String appointmentTime;
  final String updatedAt;
  final String createdAt;
  final int id;
  final int userId;
  final int centerId;

  Data({
    required this.appointmentType,
    required this.name,
    required this.email,
    required this.mobile,
    required this.countryCode,
    required this.address,
    required this.centerName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.userId,
    required this.centerId,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      appointmentType: json['appointment_type'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      countryCode: json['country_code'] ?? '',
      address: json['address'] ?? '',
      centerName: json['center_name'] ?? '',
      appointmentDate: json['appointment_date'] ?? '',
      appointmentTime: json['appointment_time'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      centerId: json['center_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointment_type': appointmentType,
      'name': name,
      'email': email,
      'mobile': mobile,
      'country_code': countryCode,
      'address': address,
      'center_name': centerName,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'user_id': userId,
      'center_id': centerId,
    };
  }
}
