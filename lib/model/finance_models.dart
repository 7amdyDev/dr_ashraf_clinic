class AssetAccountsModel {
  final int? id;
  final int accountNumber;
  final int appointmentId;
  final int patientId;
  final String dateTime;
  final int serviceId;
  final int fee;
  int discount;
  int debit;

  AssetAccountsModel({
    this.id,
    required this.accountNumber,
    required this.appointmentId,
    required this.patientId,
    required this.dateTime,
    required this.serviceId,
    required this.fee,
    this.discount = 0,
    required this.debit,
  });
}

class RevenueAccounts {
  final int? id;
  final int revenueAccount;
  final int appointmentId;
  final int patientId;
  final String dateTime;
  final int amount;
  final int serviceId;

  RevenueAccounts({
    this.id,
    required this.revenueAccount,
    required this.appointmentId,
    required this.patientId,
    required this.dateTime,
    required this.amount,
    required this.serviceId,
  });
}

class AppointmentFinance {
  final int appointId;
  final int patientId;
  final int serviceFee;
  final int paid;
  final int unPaid;

  AppointmentFinance(
      {required this.appointId,
      required this.patientId,
      required this.serviceFee,
      required this.paid,
      required this.unPaid});
}
