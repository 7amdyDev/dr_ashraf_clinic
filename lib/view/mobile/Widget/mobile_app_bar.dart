import 'package:dr_ashraf_clinic/view/home_page/widget/clinic_name_logo.dart';
import 'package:flutter/material.dart';

class MobileAppbar extends StatelessWidget {
  const MobileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ClinicNameLogo(),

        const Spacer(),
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, size: width * 0.05),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ],
    );
  }
}
