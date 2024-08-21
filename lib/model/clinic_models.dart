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
  final int fee;
  ServicesId({
    required this.id,
    required this.serviceName,
    required this.fee,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_name': serviceName,
      'fee': fee,
    };
  }

  factory ServicesId.fromJson(dynamic json) {
    return ServicesId(
      id: json['id'],
      serviceName: json['service_name'],
      fee: json['fee'],
    );
  }

  static List<ServicesId> listFromJson(dynamic json) {
    return List<ServicesId>.from(
        json.map((service) => ServicesId.fromJson(service)));
  }
}
