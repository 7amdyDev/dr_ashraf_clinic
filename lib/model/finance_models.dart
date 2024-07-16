class AssetAccountsModel {
  final int? id;
  final int accountNumber;
  final int appointmentId;
  final int patientId;
  final String dateTime;
  final int serviceId;
  final int value;
  final int discount;
  final int debit;
  final int credit;

  AssetAccountsModel({
    this.id,
    required this.accountNumber,
    required this.appointmentId,
    required this.patientId,
    required this.dateTime,
    required this.serviceId,
    required this.value,
    required this.discount,
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
