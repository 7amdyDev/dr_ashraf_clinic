import 'package:dr_ashraf_clinic/controller/patient_controller.dart';
import 'package:dr_ashraf_clinic/view/clinic/reception/widget/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchListFormField extends StatefulWidget {
  final List<String> items; // List of items for search
  final String? Function(String?)? validator; // Optional validator function
  final void Function(String?)?
      onSaved; // Optional callback for saving the selected value

  const SearchListFormField({
    super.key,
    required this.items,
    this.validator,
    this.onSaved,
  });

  @override
  State<SearchListFormField> createState() => _SearchListFormFieldState();
}

class _SearchListFormFieldState extends State<SearchListFormField> {
  String? _searchText = '';
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items; // Initialize with all items
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatientController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLength: 30,
          decoration: InputDecoration(
              hintText: 'hint_search_label'.tr,
              counterText: '',
              //  labelText: widget.labelText,
              prefixIcon: const Icon(Icons.search)),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              if (value.isEmpty) {
                //  _filteredItems = widget.items; // Show all items on empty search
              } else {
                // _filteredItems = widget.items
                //     .where((item) =>
                //         item.toLowerCase().contains(value.toLowerCase()))
                //     .toList(); // Filter items based on search text
              }
            });
          },
          validator: widget.validator,
          onSaved: widget.onSaved,
        ),
        const SizedBox(
            height: 8), // Add some spacing between text field and list
        _searchText!.isNotEmpty
            ? Card(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                  shrinkWrap: true,
                  itemCount: _filteredItems.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search),
                        Text(_searchText!),
                        Text(" ${_filteredItems[index].tr} "),
                      ],
                    ),
                    onTap: () {
                      controller.choosePatient(0);
                      switch (index) {
                        case 0:
                          controller.patientSearch(name: _searchText);
                          break;
                        case 1:
                          controller.patientSearch(mobile: _searchText);
                          break;
                        case 2:
                          controller.patientSearch(
                              id: int.tryParse(_searchText!));
                          break;
                      }
                      Get.dialog(
                        SearchDialogWidget(controller: controller),
                      );
                      // Handle item selection (optional)
                      setState(() {
                        _searchText = '';
                      });
                    },
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
