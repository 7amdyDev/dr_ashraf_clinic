// ignore_for_file: public_member_api_docs, sort_constructors_first
class IncomeExpenseModel {
  int? totalIncome;
  int? totalExpense;
  String period;
  IncomeExpenseModel({
    this.totalIncome,
    this.totalExpense,
    required this.period,
  });

  factory IncomeExpenseModel.fromJson(dynamic json) {
    return IncomeExpenseModel(
      totalIncome: json['totalIncome'] ?? 0,
      totalExpense: json['totalExpense'] ?? 0,
      period: json['period'] as String,
    );
  }

  static List<IncomeExpenseModel> listFromJson(dynamic json) {
    return List<IncomeExpenseModel>.from(
        json.map((view) => IncomeExpenseModel.fromJson(view)));
  }
}

class IncomeReferralModel {
  int totalIncome;
  int count;
  String? referral;
  IncomeReferralModel({
    required this.totalIncome,
    required this.count,
    this.referral,
  });
  factory IncomeReferralModel.fromJson(dynamic json) {
    return IncomeReferralModel(
      totalIncome: json['totalIncome'],
      count: json['count'],
      referral: json['referral'],
    );
  }

  static List<IncomeReferralModel> listFromJson(dynamic json) {
    return List<IncomeReferralModel>.from(
        json.map((view) => IncomeReferralModel.fromJson(view)));
  }
}

class ExpenseOverviewModel {
  int totalExpense;
  int accountId;
  ExpenseOverviewModel({
    required this.totalExpense,
    required this.accountId,
  });
  factory ExpenseOverviewModel.fromJson(dynamic json) {
    return ExpenseOverviewModel(
      totalExpense: json['totalExpense'],
      accountId: json['accountId'],
    );
  }

  static List<ExpenseOverviewModel> listFromJson(dynamic json) {
    return List<ExpenseOverviewModel>.from(
        json.map((view) => ExpenseOverviewModel.fromJson(view)));
  }
}
