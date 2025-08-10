import 'package:dr_ashraf_clinic/controller/doctor_info_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var width = HelperFunctions.screenSize().width;
    final DoctorController doctorController = Get.find<DoctorController>();

    return doctorController.obx(
      // The success widget to show the doctor's profile
      (state) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the doctor's image if it exists
            if (state!.imageUrl != null)
              Container(
                width: width * 0.4,
                height: width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: HColors.primary, // Choose your border color
                    width: 4, // Border thickness
                  ),
                  borderRadius: BorderRadius.circular(24), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(state.imageUrl!, fit: BoxFit.fill),
              )
            else
              const CircleAvatar(
                radius: 80,
                child: Icon(Icons.person, size: 80),
              ),
            const SizedBox(height: 20),
            // Fade-in animation for doctor name
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 900),
              builder: (context, value, child) =>
                  Opacity(opacity: value, child: child),
              child: Text(
                HelperFunctions.isLocalEnglish()
                    ? state.doctorNameEn
                    : state.doctorNameAr,

                style: const TextStyle(
                  fontSize: 24,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(color: HColors.darkGrey, thickness: 1),
            const SizedBox(height: 20),
            Text(
              HelperFunctions.isLocalEnglish()
                  ? state.specialtyEn
                  : state.specialtyAr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HColors.textTitle,
              ),
            ),
            const SizedBox(height: 8),
            // Scale animation for doctor qualification
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOut,
              builder: (context, value, child) =>
                  Transform.scale(scale: value, child: child),
              child: Text(
                HelperFunctions.isLocalEnglish()
                    ? state.qualificationEn
                    : state.qualificationAr,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      // The loading widget
      onLoading: const Center(child: CircularProgressIndicator()),
      // The error widget
      onError: (error) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(error.toString(), textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
