import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/model/online_reserv_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:dr_ashraf_clinic/utils/helper/helper_functions.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/label_text_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/page_title_widget.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/pick_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookNowSheet extends StatelessWidget {
  const BookNowSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var size = HelperFunctions.screenSize();
    TextEditingController dateController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController mobileController = TextEditingController();

    var controller = Get.put(ClinicController());
    return Container(
      constraints: const BoxConstraints(maxWidth: 1024),
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: HColors.primaryBackground,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const PageTitleWidget(
              text: 'book_sheet_label',
            ),
            const Divider(),
            const SizedBox(
              height: HSizes.spaceBtwSections,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LabelTextWidget(
                      text: 'name_label',
                    ),
                    SizedBox(
                      height: HSizes.spaceBtwSections,
                    ),
                    LabelTextWidget(
                      text: 'mobile_label',
                    ),
                    SizedBox(
                      height: HSizes.spaceBtwSections,
                    ),
                    LabelTextWidget(
                      text: 'book_date_label',
                    ),
                    SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        width: size.width / 4,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: nameController,
                        )),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    SizedBox(
                        width: size.width / 4,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: mobileController,
                        )),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                    PickDateWidget(
                        width: size.width / 4, dateController: dateController),
                    const SizedBox(
                      height: HSizes.spaceBtwItems,
                    ),
                  ],
                ),
                const SizedBox(
                  width: HSizes.spaceBtwSections,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HFilledButton(
                      text: 'save_button',
                      onPressed: () {
                        var reservation = OnlineReservModel(
                            name: nameController.text,
                            mobile: mobileController.text,
                            dateTime: dateController.text);
                        controller.createOnlineReserv(reservation);
                        Get.back();
                      },
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
