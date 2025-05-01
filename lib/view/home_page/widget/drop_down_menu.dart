import 'package:dr_ashraf_clinic/controller/auth_controller.dart';
import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/clinic_models.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HDropDownMenu extends StatefulWidget {
  const HDropDownMenu({super.key});

  @override
  State<HDropDownMenu> createState() => _HDropDownMenuState();
}

final authController = Get.find<AuthController>();
final clinicController = Get.find<ClinicController>();
final FocusNode passwordFocusNode = FocusNode();

class _HDropDownMenuState extends State<HDropDownMenu> {
  String _selectedItem = 'Smouha';
  TextEditingController password = TextEditingController();
  int selectedBranch = 1;
  bool showBranches = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Center(
          child: Column(
            children: [
              showBranches
                  ? Obx(() => DropdownButtonFormField<int>(
                        value: selectedBranch,
                        focusColor: Colors.transparent,
                        alignment: Alignment.center,
                        onChanged: (int? value) {
                          setState(() {
                            selectedBranch = value!;
                            clinicController.clinicId.value = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'clinic_branch_label'.tr,
                          border: const OutlineInputBorder(),
                        ),
                        items: clinicController.clinicBranches
                            .map<DropdownMenuItem<int>>((ClinicId value) {
                          return DropdownMenuItem<int>(
                            value: value.id,
                            child: Center(
                                child: Text(clinicController.clinicBranches
                                    .firstWhere(
                                        (clinic) => clinic.id == value.id)
                                    .branch)),
                          );
                        }).toList(),
                      ))
                  : Container(),
              const SizedBox(
                height: HSizes.spaceBtwItems,
              ),
              DropdownButtonFormField<String>(
                value: _selectedItem,
                focusColor: Colors.transparent,
                alignment: Alignment.center,
                onChanged: (String? value) {
                  setState(() {
                    if (value == 'Smouha' || value == 'Agamy') {
                      showBranches = false;
                    } else {
                      showBranches = true;
                    }
                    _selectedItem = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'choose_user_label'.tr,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  'Smouha',
                  'Agamy',
                  'Doctor',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    onTap: () {
                      // Move focus to the result field when the user submits
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    child: Center(child: Text(value)),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: HSizes.spaceBtwItems,
              ),
              TextField(
                obscureText: true,
                controller: password,
                focusNode: passwordFocusNode,
                onSubmitted: (value) {
                  authController.signInWithEmailAndPassword(
                      _selectedItem, password.text);
                },
                decoration: InputDecoration(
                  labelText: 'password_label'.tr,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: HSizes.spaceBtwSections,
              ),
              HFilledButton(
                text: 'login_button',
                onPressed: () {
                  authController.signInWithEmailAndPassword(
                      _selectedItem, password.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
