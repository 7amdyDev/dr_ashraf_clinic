class OnlineReservModel {
  String? id;
  final String name;
  final String mobile;
  final String dateTime;
  final int clinicId;
  final bool isScheduled;

  OnlineReservModel({
    this.id,
    required this.name,
    required this.mobile,
    required this.dateTime,
    required this.clinicId,
    this.isScheduled = false,
  });
}
