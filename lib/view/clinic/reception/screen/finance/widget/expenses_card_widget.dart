import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/formatters/formatter.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/finance/widget/expenses_dropdownmenu.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpensesCardWidget extends StatelessWidget {
  const ExpensesCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    String expenseType = '201';
    TextEditingController valueController = TextEditingController();
    final controller = Get.put(ClinicController());
    final valueKey = GlobalKey<FormState>();
    final descriptionKey = GlobalKey<FormState>();

    return Card(
      child: Padding(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            children: [
              Text(
                'add_expense_label'.tr,
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(),
              const SizedBox(
                height: HSizes.spaceBtwItems,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: descriptionKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: DataTextWidget(
                      label: 'description_label'.tr,
                      enable: true,
                      validator: HValidator.validateText,
                      textEditingController: descriptionController,
                    ),
                  ),
                  DataTextWidget(
                    label: 'expense_type_label'.tr,
                    child: ExpensesDropdownMenu(
                      onSelected: (value) {
                        expenseType = value;
                      },
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: valueKey,
                    child: DataTextWidget(
                      label: 'value_label'.tr,
                      enable: true,
                      textEditingController: valueController,
                      validator: HValidator.validateNumber,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: HSizes.spaceBtwSections,
              ),
              HFilledButton(
                  text: 'save_button',
                  fontSize: 22,
                  onPressed: () {
                    if (valueKey.currentState!.validate() &&
                        descriptionKey.currentState!.validate()) {
                      var valueText = HFormatter.convertArabicToEnglishNumbers(
                          valueController.value.text);
                      var expense = ExpenseModel(
                          description: descriptionController.value.text,
                          value: int.parse(valueText),
                          expenseType: expenseType,
                          dateTime: HFormatter.formatDate(DateTime.now()));
                      controller.addExpense(expense);
                      descriptionController.clear();
                      valueController.clear();
                    }
                  }),
            ],
          )),
    );
  }
}
