import 'package:dr_ashraf_clinic/db/doctor_info_api.dart';
import 'package:dr_ashraf_clinic/model/clinic_contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web/web.dart' as web; // Import for web-specific HTML elements
import 'dart:ui_web' as ui_web; // Import for platform view registration

class ClinicContactController extends GetxController {
  final DoctorInfoApi _apiService = Get.find<DoctorInfoApi>();

  // RxList makes the list observable, so GetX automatically rebuilds widgets.
  var clinics = <Clinic>[].obs;
  var isLoading = true.obs;
  var errorMessage = Rx<String?>(null); // Rx<T?> for nullable observable
  final Map<String, bool> _registeredViewFactories = {};
  @override
  void onInit() {
    super.onInit();
    fetchClinics(); // Fetch data when the controller is initialized
  }

  // Fetches clinics and updates the state.
  Future<void> fetchClinics() async {
    try {
      isLoading.value = true;
      errorMessage.value = null; // Clear any previous error

      final fetchedClinics = await _apiService.fetchClinics();
      clinics.assignAll(
        fetchedClinics,
      ); // Assign all new clinics to the observable list
    } catch (e) {
      errorMessage.value = e.toString();
      clinics.clear(); // Clear clinics on error
    } finally {
      isLoading.value = false;
    }
  }

  Widget buildMapIframe(String mapLink, String clinicId) {
    // Create a unique view type string for each iframe based on clinic ID.
    final String viewType = 'google-maps-iframe-$clinicId';

    // Register the view factory only once for each unique view type.
    if (!_registeredViewFactories.containsKey(viewType)) {
      ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
        final iframe = web.HTMLIFrameElement()
          ..src =
              mapLink // Set the map link as the iframe source
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..allowFullscreen = true; // Allow fullscreen for the map
        return iframe;
      });
      _registeredViewFactories[viewType] = true; // Mark as registered
    }

    // Return the HtmlElementView, referencing the unique view type.
    return HtmlElementView(viewType: viewType);
  }
}
