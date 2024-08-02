class AssetAccountsModel {
  final int? id;
  final int accountNumber;
  final int appointmentId;
  final int patientId;
  final String dateTime;
  final int serviceId;
  final int value;
  int discount;
  int debit;
  int credit;

  AssetAccountsModel({
    this.id,
    required this.accountNumber,
    required this.appointmentId,
    required this.patientId,
    required this.dateTime,
    required this.serviceId,
    required this.value,
    this.discount = 0,
    required this.debit,
    required this.credit,
  });
}

class RevenueAccounts {
  final int? id;
  final int revenueAccount;
  final int appointmentId;
  final int patientId;
  final String dateTime;
  final int value;
  final int serviceId;

  RevenueAccounts({
    this.id,
    required this.revenueAccount,
    required this.appointmentId,
    required this.patientId,
    required this.dateTime,
    required this.value,
    required this.serviceId,
  });
}

class AppointmentFinance {
  final int appointId;
  final int patientId;
  final String dateTime;
  final int serviceId;
  final int amount;
  final int paid;
  final int unPaid;

  AppointmentFinance(
      {required this.appointId,
      required this.patientId,
      required this.dateTime,
      required this.serviceId,
      required this.amount,
      required this.paid,
      required this.unPaid});
}
