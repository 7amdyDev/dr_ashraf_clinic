import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class RectangleImage extends StatelessWidget {
  const RectangleImage({
    super.key,
    required this.width,
    required this.height,
    required this.imagePath,
    this.shadow = true,
  });

  final double width;
  final double height;
  final String imagePath;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    double maxPageWidth = HSizes.maxPageWidth;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        height: height,
        width: width,
        constraints: BoxConstraints(
            maxWidth: maxPageWidth / 3, maxHeight: maxPageWidth / 3.5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image:
                DecorationImage(fit: BoxFit.fill, image: AssetImage(imagePath)),
            boxShadow: shadow
                ? [
                    const BoxShadow(
                        color: Colors.black38,
                        blurRadius: 2.0,
                        offset: Offset(0, 4)),
                  ]
                : null),
      ),
    );
  }
}
