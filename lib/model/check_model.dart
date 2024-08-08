class CheckModel {
  int? id;
  int appointId;
  String dateTime;
  int patientId;
  String bloodPressure;
  int temperature;
  String note;
  CheckModel({
    this.id,
    required this.appointId,
    required this.dateTime,
    required this.patientId,
    required this.bloodPressure,
    required this.temperature,
    required this.note,
  });
}

class SymptomsModel {
  int? id;
  int appointId;
  int checkId;
  String item1;
  String item2;
  String item3;
  String item4;
  String item5;
  String item6;
  String item7;
  String item8;
  String item9;
  SymptomsModel({
    this.id,
    required this.appointId,
    required this.checkId,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
    required this.item5,
    required this.item6,
    required this.item7,
    required this.item8,
    required this.item9,
  });
}

class DiagnosticModel {
  int? id;
  int appointId;
  int checkId;
  String item1;
  String item2;
  String item3;
  String item4;
  String item5;
  String item6;
  String item7;
  String item8;
  String item9;
  DiagnosticModel({
    this.id,
    required this.appointId,
    required this.checkId,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
    required this.item5,
    required this.item6,
    required this.item7,
    required this.item8,
    required this.item9,
  });
}

class PrescriptionModel {
  int? id;
  int appointId;
  int checkId;
  String item1;
  String item2;
  String item3;
  String item4;
  String item5;
  String item6;
  String item7;
  String item8;
  String item9;
  PrescriptionModel({
    this.id,
    required this.appointId,
    required this.checkId,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
    required this.item5,
    required this.item6,
    required this.item7,
    required this.item8,
    required this.item9,
  });
}
