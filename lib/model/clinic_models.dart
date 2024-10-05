// ignore_for_file: public_member_api_docs, sort_constructors_first
class AccountsId {
  final int id;
  final String accountName;
  final String category;
  AccountsId({
    required this.id,
    required this.accountName,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_name': accountName,
      'category': category,
    };
  }

  factory AccountsId.fromJson(dynamic json) {
    return AccountsId(
      id: json['id'],
      accountName: json['account_name'],
      category: json['category'],
    );
  }

  static List<AccountsId> listFromJson(dynamic json) {
    return List<AccountsId>.from(
        json.map((account) => AccountsId.fromJson(account)));
  }
}

class ServicesId {
  final int id;
  final String serviceName;

  ServicesId({
    required this.id,
    required this.serviceName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_name': serviceName,
    };
  }

  factory ServicesId.fromJson(dynamic json) {
    return ServicesId(
      id: json['id'],
      serviceName: json['service_name'],
    );
  }

  static List<ServicesId> listFromJson(dynamic json) {
    return List<ServicesId>.from(
        json.map((service) => ServicesId.fromJson(service)));
  }
}

class ClinicId {
  final int id;
  final String branch;
  ClinicId({
    required this.id,
    required this.branch,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branch': branch,
    };
  }

  factory ClinicId.fromJson(dynamic json) {
    return ClinicId(
      id: json['id'] as int,
      branch: json['branch'] as String,
    );
  }

  static List<ClinicId> listFromJson(dynamic json) {
    return List<ClinicId>.from(json.map((clinic) => ClinicId.fromJson(clinic)));
  }
}

class Fee {
  final int id;
  final int fee;
  final int serviceId;
  final int clinicId;
  Fee({
    required this.id,
    required this.fee,
    required this.serviceId,
    required this.clinicId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fee': fee,
      'service_id': serviceId,
      'clinic_id': clinicId,
    };
  }

  factory Fee.fromJson(dynamic json) {
    return Fee(
      id: json['id'] as int,
      fee: json['fee'] as int,
      serviceId: json['service_id'] as int,
      clinicId: json['clinic_id'] as int,
    );
  }

  static List<Fee> listFromJson(dynamic json) {
    return List<Fee>.from(json.map((fee) => Fee.fromJson(fee)));
  }

  Fee copyWith({
    int? id,
    int? fee,
    int? serviceId,
    int? clinicId,
  }) {
    return Fee(
      id: id ?? this.id,
      fee: fee ?? this.fee,
      serviceId: serviceId ?? this.serviceId,
      clinicId: clinicId ?? this.clinicId,
    );
  }
}
