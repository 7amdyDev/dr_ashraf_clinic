class PatientModel {
  final String name;
  final String mobile;
  final int age;
  final String address;
  final int genderType;
  final String? familyMedicalHistory;
  final String? surgicalHistory;
  final String? medicine;
  final String? allergies;
  final String? pastMedicalCondition;
  final String? notes;

  PatientModel({
    required this.name,
    required this.mobile,
    required this.age,
    required this.address,
    required this.genderType,
    this.familyMedicalHistory,
    this.surgicalHistory,
    this.medicine,
    this.allergies,
    this.pastMedicalCondition,
    this.notes,
  });
}
