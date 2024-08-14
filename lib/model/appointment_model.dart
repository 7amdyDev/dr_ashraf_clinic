class AppointmentModel {
  final int? id;
  final int patientId;
  final int serviceId;
  final int statusId;
  final String dateTime;
  final String mobile;
  final String? notes;

  AppointmentModel({
    this.id,
    required this.patientId,
    required this.serviceId,
    required this.mobile,
    required this.dateTime,
    required this.statusId,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'serviceId': serviceId,
      'mobile': mobile,
      'dateTime': dateTime,
      'statusId': statusId,
      'notes': notes,
    };
  }

  factory AppointmentModel.fromJson(dynamic json) => AppointmentModel(
        id: json["id"],
        patientId: json["patient_id"],
        serviceId: json["serviceId"],
        mobile: json["mobile"],
        dateTime: json["dateTime"],
        statusId: json["statusId"],
        notes: json["notes"],
      );

  static List<AppointmentModel> listFromJson(dynamic json) {
    return List<AppointmentModel>.from(
        json.map((appointment) => AppointmentModel.fromJson(appointment)));
  }
}
