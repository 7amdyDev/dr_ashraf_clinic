import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicBranchName extends StatelessWidget {
  ClinicBranchName({
    super.key,
  });

  final clinicController = Get.find<ClinicController>();

  @override
  Widget build(BuildContext context) {
    var clinicBranch = clinicController.getClinicBranchName();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          clinicBranch,
          softWrap: true,
          style: const TextStyle(
              shadows: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 3), blurRadius: 2)
              ],
              fontSize: 32,
              color: HColors.primary,
              fontFamily: 'Lemonada',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
