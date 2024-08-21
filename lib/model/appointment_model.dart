class AppointmentModel {
  final int? id;
  final int patientId;
  final int serviceId;
  final int statusId;
  final String date;
  final String? notes;

  AppointmentModel({
    this.id,
    required this.patientId,
    required this.serviceId,
    required this.date,
    required this.statusId,
    this.notes,
  });
  AppointmentModel copyWith({
    int? id,
    int? patientId,
    int? serviceId,
    int? statusId,
    String? date,
    String? mobile,
    String? notes,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      serviceId: serviceId ?? this.serviceId,
      date: date ?? this.date,
      statusId: statusId ?? this.statusId,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'service_id': serviceId,
      'date': date,
      'statusId': statusId,
      'notes': notes,
    };
  }

  factory AppointmentModel.fromJson(dynamic json) => AppointmentModel(
        id: json["id"],
        patientId: json["patient_id"],
        serviceId: json["service_id"],
        date: json["date"],
        statusId: json["statusId"],
        notes: json["notes"],
      );

  static List<AppointmentModel> listFromJson(dynamic json) {
    return List<AppointmentModel>.from(
        json.map((appointment) => AppointmentModel.fromJson(appointment)));
  }
}
