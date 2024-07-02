import 'package:dr_ashraf_clinic/view/home_page/widget/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceptionSchedulePage extends StatelessWidget {
  const ReceptionSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Schedule Table',
            style: GoogleFonts.elMessiri(
              fontSize: 32,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HFilledButton(text: 'Today', onPressed: () {}),
              HFilledButton(text: 'Select Date', onPressed: () {}),
            ],
          ),
          Table()
        ],
      ),
    );
  }
}
