class OnlineAppointmentDetails {
  final String patientName;
  final String patientMobile;
  final String appointmentType;

  OnlineAppointmentDetails({
    required this.patientName,
    required this.patientMobile,
    required this.appointmentType,
  });

  factory OnlineAppointmentDetails.fromJson(Map<String, dynamic> json) {
    return OnlineAppointmentDetails(
      patientName: json['patientName'],
      patientMobile: json['patientMobile'],
      appointmentType: json['appointmentType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'patientMobile': patientMobile,
      'appointmentType': appointmentType,
    };
  }
}
