class MedicineModel {
  final int? id;
  final String name;
  final String type;
  final String time;
  final String schedule;


  MedicineModel({
    this.id,
    required this.name,
    required this.type,
    required this.time,
    required this.schedule,
  });

  // Convert a Medicine object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'time': time,
      'schedule': schedule,
    };
  }

  // Extract a Medicine object from a Map object
  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      time: map['time'],
      schedule: map['schedule'],
    );
  }
}
