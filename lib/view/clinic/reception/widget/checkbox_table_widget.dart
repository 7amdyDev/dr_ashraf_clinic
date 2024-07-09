import 'package:flutter/material.dart';

class TableCheckBoxWidget extends StatefulWidget {
  const TableCheckBoxWidget({
    super.key,
  });
  @override
  State<TableCheckBoxWidget> createState() => _TableCheckBoxState();
}

class _TableCheckBoxState extends State<TableCheckBoxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
        });
  }
}
