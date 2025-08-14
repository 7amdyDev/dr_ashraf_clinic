import 'package:dr_ashraf_clinic/controller/clinic_contact_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicContactWidget extends StatelessWidget {
  const ClinicContactWidget({super.key, required this.desktopView});
  final bool desktopView;
  @override
  Widget build(BuildContext context) {
    // Get the controller instance using Get.find()
    final ClinicContactController clinicController =
        Get.find<ClinicContactController>();

    return Obx(() {
      // Use Obx to react to changes in observable variables
      if (clinicController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (clinicController.errorMessage.value != null) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Error: ${clinicController.errorMessage.value}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        );
      } else if (clinicController.clinics.isEmpty) {
        return const Center(
          child: Text(
            'No clinics found. Please check back later.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
      } else {
        return desktopView
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 16 / 9, // Adjust aspect ratio as needed
                  crossAxisSpacing: 16,
                ),
                padding: const EdgeInsets.all(16.0),
                itemCount: clinicController.clinics.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final clinic = clinicController.clinics[index];
                  final String clinicId = clinic.id
                      .toString(); // Use clinic ID for unique iframe key

                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HelperFunctions.isLocalEnglish()
                                ? clinic.titleEn ?? clinic.title
                                : clinic.title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: HColors.textTitle,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FittedBox(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${'address_label'.tr} : ',
                                    style: const TextStyle(
                                      fontSize: 18,

                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text: HelperFunctions.isLocalEnglish()
                                        ? clinic.addressEn ?? clinic.address
                                        : clinic.address,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          FittedBox(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${'schedule_label'.tr} : ',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text: HelperFunctions.isLocalEnglish()
                                        ? clinic.scheduleEn ?? clinic.schedule
                                        : clinic.schedule,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),

                          FittedBox(
                            child: SelectableText.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${'telephone_label'.tr} : ',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text: clinic.phones,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),
                          if (clinic.mapLink != null &&
                              clinic.mapLink!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                // Container for the Google Map iframe
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                  clipBehavior: Clip
                                      .antiAlias, // Clip content to rounded borders
                                  height: 200, // Fixed height for the map
                                  width: double.infinity, // Take full width
                                  // Call the controller's method to build the iframe
                                  child: clinicController.buildMapIframe(
                                    clinic.mapLink!,
                                    clinicId,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: clinicController.clinics.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final clinic = clinicController.clinics[index];
                  final String clinicId = clinic.id
                      .toString(); // Use clinic ID for unique iframe key

                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HelperFunctions.isLocalEnglish()
                                ? clinic.titleEn ?? clinic.title
                                : clinic.title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: HColors.textTitle,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FittedBox(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${'address_label'.tr} : ',
                                    style: const TextStyle(
                                      fontSize: 18,

                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text: HelperFunctions.isLocalEnglish()
                                        ? clinic.addressEn ?? clinic.address
                                        : clinic.address,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          FittedBox(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${'schedule_label'.tr} : ',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text: HelperFunctions.isLocalEnglish()
                                        ? clinic.scheduleEn ?? clinic.schedule
                                        : clinic.schedule,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),

                          FittedBox(
                            child: SelectableText.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${'telephone_label'.tr} : ',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text: clinic.phones,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),
                          if (clinic.mapLink != null &&
                              clinic.mapLink!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                // Container for the Google Map iframe
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                  clipBehavior: Clip
                                      .antiAlias, // Clip content to rounded borders
                                  height: 200, // Fixed height for the map
                                  width: double.infinity, // Take full width
                                  // Call the controller's method to build the iframe
                                  child: clinicController.buildMapIframe(
                                    clinic.mapLink!,
                                    clinicId,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
      }
    });
  }
}
