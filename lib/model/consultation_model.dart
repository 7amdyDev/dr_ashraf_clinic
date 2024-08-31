class ConsultationModel {
  int? id;
  int appointId;
  String dateTime;
  int patientId;
  String? bloodPressure;
  String? temperature;
  String? note;
  int serviceId;
  ConsultationModel(
      {this.id,
      required this.appointId,
      required this.dateTime,
      required this.patientId,
      required this.bloodPressure,
      required this.temperature,
      required this.note,
      required this.serviceId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appointment_id': appointId,
      'date': dateTime,
      'patient_id': patientId,
      'blood_pressure': bloodPressure,
      'temperature': temperature,
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
      bloodPressure: json['blood_pressure'],
      temperature: json['temperature'],
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
    String? bloodPressure,
    String? temperature,
    String? note,
    int? serviceId,
  }) {
    return ConsultationModel(
      id: id ?? this.id,
      appointId: appointId ?? this.appointId,
      dateTime: dateTime ?? this.dateTime,
      patientId: patientId ?? this.patientId,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      temperature: temperature ?? this.temperature,
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

  PrescriptionModel({
    this.id,
    required this.consultationId,
    required this.medicine,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'consultation_id': consultationId,
      'medicine': medicine,
    };
  }

  factory PrescriptionModel.fromJson(dynamic map) {
    return PrescriptionModel(
      id: map['id'],
      consultationId: map['consultation_id'],
      medicine: map['medicine'],
    );
  }
  static List<PrescriptionModel> listFromJson(dynamic json) {
    return List<PrescriptionModel>.from(
        json.map((medicine) => PrescriptionModel.fromJson(medicine)));
  }
}
