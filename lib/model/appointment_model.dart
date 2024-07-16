class AppointmentModel {
  final int? id;
  final int patientId;
  final int serviceId;
  final int status;
  final String dateTime;
  final String? notes;

  AppointmentModel(
    this.status, {
    this.id,
    required this.patientId,
    required this.serviceId,
    required this.dateTime,
    this.notes,
  });
}
