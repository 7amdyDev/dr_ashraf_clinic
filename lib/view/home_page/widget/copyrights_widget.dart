import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CopyrightsWidget extends StatelessWidget {
  const CopyrightsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            children: [
              TextSpan(
                text: '© ${DateTime.now().year} ',
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    openMailto();
                  },
                text: 'info@hamdy.dev ',
                style: const TextStyle(
                  color: HColors.primary,
                ),
              ),
              const TextSpan(
                text: ' All rights reserved.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> openMailto() async {
  const String email = "info@hamdy.dev";

  final Uri mailtoUri = Uri(
    scheme: 'mailto',
    path: email,
    query: Uri.encodeFull(''),
  );

  if (await canLaunchUrl(mailtoUri)) {
    await launchUrl(mailtoUri);
  } else {
    throw 'Could not launch $mailtoUri';
  }
}
