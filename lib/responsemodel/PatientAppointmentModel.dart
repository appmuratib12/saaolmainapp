class PatientAppointmentModel {
  final int? id; // Nullable for auto-incremented ID
  final String date;
  final String time;
  final String mode;
  final String centerLocation;
  final String totalAmount;
  final String paymentID;

  PatientAppointmentModel({
    this.id,
    required this.date,
    required this.time,
    required this.mode,
    required this.centerLocation,
    required this.totalAmount,
    required this.paymentID,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'mode': mode,
      'centerLocation': centerLocation,
      'totalAmount': totalAmount,
      'paymentID': paymentID,
    };
  }
  factory PatientAppointmentModel.fromMap(Map<String, dynamic> map) {
    return PatientAppointmentModel(
      id: map['id'],
      date: map['date'],
      time: map['time'],
      mode: map['mode'],
      centerLocation: map['centerLocation'],
      totalAmount: map['totalAmount'],
      paymentID: map['paymentID'],
    );
  }
}
