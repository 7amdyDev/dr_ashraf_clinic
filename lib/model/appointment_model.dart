class AppointmentModel {
  final int? id;
  final int patientId;
  final int serviceId;
  final int status;
  final String dateTime;
  final String mobile;
  final String? notes;

  AppointmentModel({
    this.id,
    required this.status,
    required this.mobile,
    required this.patientId,
    required this.serviceId,
    required this.dateTime,
    this.notes,
  });
}
