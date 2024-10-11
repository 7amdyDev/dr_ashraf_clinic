class AssetAccountsModel {
  final int? id;
  final int accountId;
  final int appointmentId;
  final int patientId;
  final String date;
  final int serviceId;
  final int fee;
  final int clinicId;
  final String? name;
  int discount;
  int debit;

  AssetAccountsModel({
    this.id,
    required this.accountId,
    required this.appointmentId,
    required this.patientId,
    required this.date,
    required this.serviceId,
    required this.fee,
    required this.clinicId,
    this.discount = 0,
    this.name,
    required this.debit,
  });

  AssetAccountsModel copyWith({
    int? id,
    int? accountId,
    int? appointmentId,
    int? patientId,
    String? date,
    int? serviceId,
    int? fee,
    int? discount,
    int? debit,
    int? clinicId,
  }) {
    return AssetAccountsModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      appointmentId: appointmentId ?? this.appointmentId,
      patientId: patientId ?? this.patientId,
      date: date ?? this.date,
      serviceId: serviceId ?? this.serviceId,
      fee: fee ?? this.fee,
      discount: discount ?? this.discount,
      debit: debit ?? this.debit,
      clinicId: clinicId ?? this.clinicId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'appointment_id': appointmentId,
      'patient_id': patientId,
      'date': date,
      'service_id': serviceId,
      'fee': fee,
      'discount': discount,
      'debit': debit,
      'clinic_id': clinicId,
    };
  }

  factory AssetAccountsModel.fromJson(dynamic json) {
    return AssetAccountsModel(
        id: json['id'],
        accountId: json['account_id'],
        appointmentId: json['appointment_id'],
        patientId: json['patient_id'],
        date: json['date'],
        serviceId: json['service_id'],
        fee: json['fee'],
        discount: json['discount'],
        debit: json['debit'],
        clinicId: json['clinic_id'],
        name: json['name']);
  }

  static List<AssetAccountsModel> listFromJson(dynamic json) {
    return List<AssetAccountsModel>.from(
        json.map((asset) => AssetAccountsModel.fromJson(asset)));
  }
}

class RevenueAccounts {
  final int? id;
  final int revenueAccount;
  final int appointmentId;
  final int patientId;
  final String dateTime;
  final int amount;
  final int serviceId;
  final int clinicId;

  RevenueAccounts({
    this.id,
    required this.revenueAccount,
    required this.appointmentId,
    required this.patientId,
    required this.dateTime,
    required this.amount,
    required this.serviceId,
    required this.clinicId,
  });

  RevenueAccounts copyWith({
    int? id,
    int? revenueAccount,
    int? appointmentId,
    int? patientId,
    String? dateTime,
    int? amount,
    int? serviceId,
    int? clinicId,
  }) {
    return RevenueAccounts(
      id: id ?? this.id,
      revenueAccount: revenueAccount ?? this.revenueAccount,
      appointmentId: appointmentId ?? this.appointmentId,
      patientId: patientId ?? this.patientId,
      dateTime: dateTime ?? this.dateTime,
      amount: amount ?? this.amount,
      serviceId: serviceId ?? this.serviceId,
      clinicId: clinicId ?? this.clinicId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'revenue_account': revenueAccount,
      'appointment_id': appointmentId,
      'patient_id': patientId,
      'dateTime': dateTime,
      'amount': amount,
      'service_id': serviceId,
      'clinic_id': clinicId,
    };
  }

  factory RevenueAccounts.fromJson(dynamic json) {
    return RevenueAccounts(
      id: json['id'],
      revenueAccount: json['revenue_account'],
      appointmentId: json['appointment_id'],
      patientId: json['patient_id'],
      dateTime: json['dateTime'],
      amount: json['amount'],
      serviceId: json['service_id'],
      clinicId: json['clinic_id'],
    );
  }

  static List<RevenueAccounts> listFromJson(dynamic json) {
    return List<RevenueAccounts>.from(
        json.map((revenue) => RevenueAccounts.fromJson(revenue)));
  }
}

class AppointmentFinance {
  final int appointmentId;
  final int patientId;
  final String fee;
  final String? paid;
  final String unPaid;
  final String date;
  final int serviceId;
  final int clinicId;
  final String name;
  final String mobile;
  AppointmentFinance({
    required this.appointmentId,
    required this.patientId,
    required this.fee,
    required this.paid,
    required this.unPaid,
    required this.date,
    required this.serviceId,
    required this.clinicId,
    required this.name,
    required this.mobile,
  });

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': appointmentId,
      'patient_id': patientId,
      'fee': fee,
      'paid': paid,
      'unpaid': unPaid,
      'date': date,
      'service_id': serviceId,
      'clinic_id': clinicId,
      'name': name,
      'mobile': mobile,
    };
  }

  factory AppointmentFinance.fromJson(Map<String, dynamic> json) {
    return AppointmentFinance(
      appointmentId: json['appointment_id'],
      patientId: json['patient_id'],
      fee: json['fee'],
      paid: json['paid'] ?? '0',
      unPaid: json['unpaid'],
      date: json['date'],
      serviceId: json['service_id'],
      clinicId: json['clinic_id'],
      name: json['name'],
      mobile: json['mobile'],
    );
  }

  static List<AppointmentFinance> listFromJson(dynamic json) {
    return List<AppointmentFinance>.from(
        json.map((finance) => AppointmentFinance.fromJson(finance)));
  }
}

class TotalIncome {
  int? total;
  String date;
  TotalIncome({
    this.total,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'TOTALDAILYINCOME': total,
      'DATE': date,
    };
  }

  factory TotalIncome.fromJson(dynamic json) {
    return TotalIncome(
      total: int.tryParse(json['TOTALDAILYINCOME']) ?? 0,
      date: json['DATE'],
    );
  }

  static List<TotalIncome> listFromJson(dynamic json) {
    return List<TotalIncome>.from(
        json.map((total) => TotalIncome.fromJson(total)));
  }
}
