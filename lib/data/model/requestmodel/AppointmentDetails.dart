
class AppointmentDetails {
  final String patientName;
  final String patientEmail;
  final String patientMobile;
  final String appointmentType;
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentLocation;

  AppointmentDetails({
    required this.patientName,
    required this.patientEmail,
    required this.patientMobile,
    required this.appointmentType,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentLocation,
  });

  factory AppointmentDetails.fromJson(Map<String, dynamic> json) {
    return AppointmentDetails(
      patientName: json['patientName'],
      patientEmail: json['patientEmail'],
      patientMobile: json['patientMobile'],
      appointmentType: json['appointmentType'],
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      appointmentLocation: json['appointmentLocation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'patientEmail': patientEmail,
      'patientMobile': patientMobile,
      'appointmentType': appointmentType,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'appointmentLocation': appointmentLocation,
    };
  }
}
