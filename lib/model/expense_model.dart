class ExpenseModel {
  int? id;
  String description;
  int value;
  int accountId;
  int clinicId;
  String date;
  ExpenseModel({
    this.id,
    required this.description,
    required this.value,
    required this.accountId,
    required this.clinicId,
    required this.date,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'value': value,
      'account_id': accountId,
      'date': date,
      'clinic_id': clinicId,
    };
  }

  factory ExpenseModel.fromJson(dynamic json) => ExpenseModel(
      id: json["id"],
      description: json["description"],
      value: json["value"],
      accountId: json["account_id"],
      date: json["date"],
      clinicId: json["clinic_id"]);

  static List<ExpenseModel> listFromJson(dynamic json) {
    return List<ExpenseModel>.from(
        json.map((expense) => ExpenseModel.fromJson(expense)));
  }

  ExpenseModel copyWith({
    int? id,
    String? description,
    int? value,
    int? accountId,
    String? date,
    int? clinicId,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      description: description ?? this.description,
      value: value ?? this.value,
      accountId: accountId ?? this.accountId,
      date: date ?? this.date,
      clinicId: clinicId ?? this.clinicId,
    );
  }
}

class TotalExpenses {
  int? total;
  String date;
  TotalExpenses({
    this.total,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'TOTALDAILYEXPENSES': total,
      'DATE': date,
    };
  }

  factory TotalExpenses.fromJson(dynamic json) {
    return TotalExpenses(
      total: int.tryParse(json['TOTALDAILYEXPENSES']) ?? 0,
      date: json['DATE'],
    );
  }

  static List<TotalExpenses> listFromJson(dynamic json) {
    return List<TotalExpenses>.from(
        json.map((total) => TotalExpenses.fromJson(total)));
  }
}
