import 'package:dr_ashraf_clinic/controller/auth_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/utils/validator/validation.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/reservation/widget/data_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserChangePassword extends StatelessWidget {
  const UserChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    var currentPasswordController = TextEditingController();
    var newPasswordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var newKey = GlobalKey<FormState>();
    var confirmKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: HSizes.spaceBtwSections,
          ),
          SizedBox(
            width: HelperFunctions.clinicPagesWidth() / 2,
            child: Card(
              child: Column(
                children: [
                  const SizedBox(
                    height: HSizes.spaceBtwSections,
                  ),
                  DataTextWidget(
                    label: 'current_password'.tr,
                    textEditingController: currentPasswordController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: HSizes.spaceBtwItems,
                  ),
                  Form(
                    key: newKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: DataTextWidget(
                      label: 'new_password'.tr,
                      textEditingController: newPasswordController,
                      validator: HValidator.validatePassword,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: HSizes.spaceBtwItems,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: confirmKey,
                    child: DataTextWidget(
                      label: 'confirm_password'.tr,
                      textEditingController: confirmPasswordController,
                      obscureText: true,
                      validator: (p0) {
                        if (p0 != newPasswordController.text) {
                          return 'Do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: HSizes.spaceBtwSections,
                  ),
                  HFilledButton(
                    text: 'change_button',
                    onPressed: () {
                      if (newKey.currentState!.validate() &&
                          confirmKey.currentState!.validate()) {
                        authController
                            .changePassword(currentPasswordController.text,
                                newPasswordController.text)
                            .then((onValue) {
                          if (onValue) {
                            newKey.currentState!.reset();
                            confirmPasswordController.clear();
                            newPasswordController.clear();
                            currentPasswordController.clear();
                          }
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: HSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
