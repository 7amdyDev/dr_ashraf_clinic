class ExpenseModel {
  int? id;
  String description;
  int value;
  String expenseAccount;
  String dateTime;
  ExpenseModel({
    this.id,
    required this.description,
    required this.value,
    required this.expenseAccount,
    required this.dateTime,
  });
}
