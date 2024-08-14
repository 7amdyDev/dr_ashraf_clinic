class PatientModel {
  final int? id;
  final String name;
  final String mobile;
  final int age;
  final String address;
  final int gender;
  final String? familyMedicalHistory;
  final String? surgicalHistory;
  final String? medicine;
  final String? allergies;
  final String? pastMedicalHistory;
  final String? notes;

  PatientModel({
    this.id,
    required this.name,
    required this.mobile,
    required this.age,
    required this.address,
    required this.gender,
    this.familyMedicalHistory,
    this.surgicalHistory,
    this.medicine,
    this.allergies,
    this.pastMedicalHistory,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'age': age,
      'address': address,
      'gender': gender,
      'familyMedicalHistory': familyMedicalHistory,
      'surgicalHistory': surgicalHistory,
      'medicine': medicine,
      'allergies': allergies,
      'pastMedicalHistory': pastMedicalHistory,
      'notes': notes,
    };
  }

  factory PatientModel.fromJson(dynamic json) => PatientModel(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        age: json["age"],
        address: json["address"],
        gender: json["gender"],
        familyMedicalHistory: json["familyMedicalHistory"],
        surgicalHistory: json["surgicalHistory"],
        medicine: json["medicine"],
        allergies: json["allergies"],
        pastMedicalHistory: json["pastMedicalHistory"],
        notes: json["notes"],
      );

  static List<PatientModel> listFromJson(dynamic json) {
    return List<PatientModel>.from(
        json.map((patient) => PatientModel.fromJson(patient)));
  }
}
