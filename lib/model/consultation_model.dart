// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConsultationModel {
  int? id;
  int appointId;
  String dateTime;
  int patientId;
  String? note;
  int serviceId;
  ConsultationModel(
      {this.id,
      required this.appointId,
      required this.dateTime,
      required this.patientId,
      required this.note,
      required this.serviceId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appointment_id': appointId,
      'date': dateTime,
      'patient_id': patientId,
      'note': note,
      'service_id': serviceId,
    };
  }

  factory ConsultationModel.fromJson(dynamic json) {
    return ConsultationModel(
      id: json['id'],
      appointId: json['appointment_id'],
      dateTime: json['date'],
      patientId: json['patient_id'],
      note: json['note'],
      serviceId: json['service_id'],
    );
  }

  static List<ConsultationModel> listFromJson(dynamic json) {
    return List<ConsultationModel>.from(
        json.map((consultation) => ConsultationModel.fromJson(consultation)));
  }

  ConsultationModel copyWith({
    int? id,
    int? appointId,
    String? dateTime,
    int? patientId,
    String? note,
    int? serviceId,
  }) {
    return ConsultationModel(
      id: id ?? this.id,
      appointId: appointId ?? this.appointId,
      dateTime: dateTime ?? this.dateTime,
      patientId: patientId ?? this.patientId,
      note: note ?? this.note,
      serviceId: serviceId ?? this.serviceId,
    );
  }
}

class SymptomsModel {
  int? id;
  int consultationId;
  String description;

  SymptomsModel({
    this.id,
    required this.consultationId,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'consultation_id': consultationId,
      'description': description,
    };
  }

  factory SymptomsModel.fromJson(dynamic map) {
    return SymptomsModel(
      id: map['id'],
      consultationId: map['consultation_id'],
      description: map['description'],
    );
  }

  static List<SymptomsModel> listFromJson(dynamic json) {
    return List<SymptomsModel>.from(
        json.map((symptoms) => SymptomsModel.fromJson(symptoms)));
  }
}

class DiagnosisModel {
  int? id;
  int consultationId;
  String description;

  DiagnosisModel({
    this.id,
    required this.consultationId,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'consultation_id': consultationId,
      'description': description,
    };
  }

  factory DiagnosisModel.fromJson(dynamic map) {
    return DiagnosisModel(
      id: map['id'],
      consultationId: map['consultation_id'],
      description: map['description'],
    );
  }

  static List<DiagnosisModel> listFromJson(dynamic json) {
    return List<DiagnosisModel>.from(
        json.map((diagnosis) => DiagnosisModel.fromJson(diagnosis)));
  }
}

class PrescriptionModel {
  int? id;
  int consultationId;
  String medicine;
  String? dosage;
  String? notes;

  PrescriptionModel({
    this.id,
    required this.consultationId,
    required this.medicine,
    this.dosage,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'consultation_id': consultationId,
      'medicine': medicine,
      'dosage': dosage,
      'notes': notes,
    };
  }

  factory PrescriptionModel.fromJson(dynamic map) {
    return PrescriptionModel(
      id: map['id'],
      consultationId: map['consultation_id'],
      medicine: map['medicine'],
      dosage: map['dosage'],
      notes: map['notes'],
    );
  }
  static List<PrescriptionModel> listFromJson(dynamic json) {
    return List<PrescriptionModel>.from(
        json.map((medicine) => PrescriptionModel.fromJson(medicine)));
  }
}

class MedicineModel {
  String? key;
  String name;
  MedicineModel({
    required this.name,
    this.key,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory MedicineModel.fromJson(dynamic map) {
    return MedicineModel(
      name: map['name'],
      key: map['key'],
    );
  }
  static List<MedicineModel> listFromJson(dynamic json) {
    return List<MedicineModel>.from(
        json.map((medicine) => MedicineModel.fromJson(medicine)));
  }
}

class ExaminationModel {
  String? key;
  String name;
  ExaminationModel({
    required this.name,
    this.key,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory ExaminationModel.fromJson(dynamic map) {
    return ExaminationModel(
      name: map['name'],
      key: map['key'],
    );
  }
  static List<ExaminationModel> listFromJson(dynamic json) {
    return List<ExaminationModel>.from(
        json.map((test) => ExaminationModel.fromJson(test)));
  }
}

class ExaminationsResultModel {
  int? id;
  int consultationId;
  String name;
  String? result;
  String? notes;

  ExaminationsResultModel({
    this.id,
    required this.consultationId,
    required this.name,
    this.result,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'consultation_id': consultationId,
      'name': name,
      'result': result,
      'notes': notes,
    };
  }

  factory ExaminationsResultModel.fromJson(dynamic map) {
    return ExaminationsResultModel(
      id: map['id'],
      consultationId: map['consultation_id'],
      name: map['name'],
      result: map['result'],
      notes: map['notes'],
    );
  }
  static List<ExaminationsResultModel> listFromJson(dynamic json) {
    return List<ExaminationsResultModel>.from(
        json.map((result) => ExaminationsResultModel.fromJson(result)));
  }
}
