import 'package:dr_ashraf_clinic/controller/clinic_controller.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/screen/schedule/widget/table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReferralDropDownMenu extends StatefulWidget {
  final Function(int) onSelected; // Callback for selection change
  final int referralIndex;
  const ReferralDropDownMenu({
    super.key,
    required this.onSelected,
    required this.referralIndex,
  });

  @override
  State<ReferralDropDownMenu> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<ReferralDropDownMenu> {
  // Default selected value

  @override
  Widget build(BuildContext context) {
    int selectedValue = widget.referralIndex;
    var clinicController = Get.put(ClinicController());
    var list = clinicController.dbReferralsList;

    return DropdownButtonFormField<int>(
      style: const TextStyle(
        fontFamily: 'NotoNaskh',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      value: selectedValue, // Currently selected value
      items: list.map((referral) {
        return DropdownMenuItem<int>(
          value: list.indexOf(referral),
          child: TableDataCell(
            text: referral.name,
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value!; // Update selected value
        });
        widget.onSelected(value!); // Call callback with selected value
      },
    );
  }
}
