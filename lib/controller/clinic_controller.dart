import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
import 'package:dr_ashraf_clinic/model/patient_model.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController {
  RxBool isCollapsed = true.obs;
  RxBool show = false.obs;
  RxInt recordIndex = 0.obs;
  RxInt totalDailyExpenses = 0.obs;
  RxList<ExpenseModel> expenseSearchResult = <ExpenseModel>[].obs;
  RxList<OnlineReservModel> onlineReservData = <OnlineReservModel>[].obs;
  RxList<PatientModel> patientList = <PatientModel>[].obs;
  RxInt receptionPageIndex = 0.obs;
  RxList<String> patientSearchResult = <String>[].obs;
  void updateCollapsed(bool collapsed) {
    isCollapsed.value = collapsed;
  }

  void addExpense(ExpenseModel expense) {
    expenseSearchResult.add(expense); // Update the list
    // Call your function here
    onExpenseListUpdated(); // Example function call
  }

  void deleteExpense(int index) {
    expenseSearchResult.removeAt(index); // Update the list
    // Call your function here
    onExpenseListUpdated(); // Example function call
  }

  void onExpenseListUpdated() {
    int totalExpense = 0;
    for (var item in expenseSearchResult) {
      totalExpense += item.value;
    }
    totalDailyExpenses.value = totalExpense;
  }

  void addNewPatient(PatientModel patient) {
    patientList.add(patient);
  }
}
