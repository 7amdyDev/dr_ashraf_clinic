class ExpenseModel {
  int? id;
  String description;
  int value;
  int expenseAccount;
  String dateTime;
  ExpenseModel({
    this.id,
    required this.description,
    required this.value,
    required this.expenseAccount,
    required this.dateTime,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'value': value,
      'expenseAccount': expenseAccount,
      'dateTime': dateTime
    };
  }

  factory ExpenseModel.fromJson(dynamic json) => ExpenseModel(
        id: json["id"],
        description: json["description"],
        value: json["value"],
        expenseAccount: json["expenseAccount"],
        dateTime: json["dateTime"],
      );

  static List<ExpenseModel> listFromJson(dynamic json) {
    return List<ExpenseModel>.from(
        json.map((expense) => ExpenseModel.fromJson(expense)));
  }
}
