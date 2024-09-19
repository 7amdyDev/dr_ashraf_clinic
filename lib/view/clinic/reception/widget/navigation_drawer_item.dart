import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationDrawerItem extends StatelessWidget {
  const NavigationDrawerItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onPressed,
    required this.pageIndex,
  });
  final String imagePath;
  final String title;
  final VoidCallback onPressed;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    final clinicController = Get.find<ClinicController>();
    return Obx(() => ListTile(
        selected: pageIndex == clinicController.pageIndex.value ? true : false,
        selectedColor: Colors.red[600],
        selectedTileColor: Colors.black12,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
              style: const TextStyle(
                fontFamily: 'Beiruti',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              title.tr),
        ),
        leading: Image(
          width: 45,
          height: 45,
          image: AssetImage(imagePath),
        ),
        onTap: onPressed));
  }
}
