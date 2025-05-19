
class FamilyMember {
  final String name;
  final String relation;
  final String gender;
  final String age;

  FamilyMember({
    required this.name,
    required this.relation,
    required this.gender,
    required this.age,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'relation': relation,
    'gender': gender,
    'age': age,
  };

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
    name: json['name'],
    relation: json['relation'],
    gender: json['gender'],
    age: json['age'],
  );
}
