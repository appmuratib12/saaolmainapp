class FamilyMember {
  final String name;
  final String relation;
  final String gender;
  final String age;
  final String emailID;
  final String mobileNumber;
  final String dateOfBirth;

  FamilyMember({
    required this.name,
    required this.relation,
    required this.gender,
    required this.age,
    required this.emailID,
    required this.mobileNumber,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'relation': relation,
    'gender': gender,
    'age': age,
    'email': emailID,
    'mobile_number': mobileNumber,
    'dob': dateOfBirth,
  };

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
    name: json['name'] ?? '',
    relation: json['relation'] ?? '',
    gender: json['gender'] ?? '',
    age: json['age'] ?? '',
    emailID: json['email'] ?? '',
    mobileNumber: json['mobile_number'] ?? '',
    dateOfBirth: json['dob'] ?? '',
  );
}
