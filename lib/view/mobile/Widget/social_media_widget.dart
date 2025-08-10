import 'package:dr_ashraf_clinic/controller/social_buttons_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SocialButtonsController socialController =
        Get.find<SocialButtonsController>();
    return Obx(() {
      if (socialController.isLoading.value) {
        return CircularProgressIndicator();
      }
      return FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: socialController.buttons
              .map(
                (btn) => IconButton(
                  iconSize: 40,
                  icon: Image.network(btn.iconUrl, width: 80),
                  onPressed: () => launchUrl(
                    Uri.parse(btn.link),
                  ), // Use url_launcher package
                ),
              )
              .toList(),
        ),
      );
    });
  }
}
