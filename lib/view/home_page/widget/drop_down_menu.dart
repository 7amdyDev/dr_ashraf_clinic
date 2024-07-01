import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HDropDownMenu extends StatefulWidget {
  const HDropDownMenu({super.key});

  @override
  State<HDropDownMenu> createState() => _HDropDownMenuState();
}

class _HDropDownMenuState extends State<HDropDownMenu> {
  String _selectedItem = 'Reception';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: DropdownButtonFormField<String>(
          value: _selectedItem,
          onChanged: (String? value) {
            setState(() {
              _selectedItem = value!;
            });
          },
          decoration: InputDecoration(
            labelText: 'choose_user_label'.tr,
            border: const OutlineInputBorder(),
          ),
          items: [
            'Reception',
            'Doctor',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  const Icon(Icons.star),
                  const SizedBox(width: 10),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
