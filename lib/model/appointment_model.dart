class AppointmentModel {
  final int? id;
  final int patientId;
  final int serviceId;
  final int statusId;
  final int clinicId;
  final String date;
  final String? notes;
  final String? referral;

  AppointmentModel({
    this.id,
    required this.patientId,
    required this.serviceId,
    required this.date,
    required this.statusId,
    required this.clinicId,
    this.notes,
    this.referral,
  });
  AppointmentModel copyWith({
    int? id,
    int? patientId,
    int? serviceId,
    int? statusId,
    int? clinicId,
    String? date,
    String? mobile,
    String? notes,
    String? referral,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      serviceId: serviceId ?? this.serviceId,
      date: date ?? this.date,
      statusId: statusId ?? this.statusId,
      clinicId: clinicId ?? this.clinicId,
      notes: notes ?? this.notes,
      referral: referral ?? this.referral,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'service_id': serviceId,
      'date': date,
      'statusId': statusId,
      'clinic_id': clinicId,
      'notes': notes,
      'referral': referral,
    };
  }

  factory AppointmentModel.fromJson(dynamic json) => AppointmentModel(
      id: json["id"],
      patientId: json["patient_id"],
      serviceId: json["service_id"],
      date: json["date"],
      statusId: json["statusId"],
      clinicId: json["clinic_id"],
      notes: json["notes"],
      referral: json["referral"]);

  static List<AppointmentModel> listFromJson(dynamic json) {
    return List<AppointmentModel>.from(
        json.map((appointment) => AppointmentModel.fromJson(appointment)));
  }
}
