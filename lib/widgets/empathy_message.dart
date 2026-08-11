import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class EmpathyMessage extends StatelessWidget {
  final String message;
  final String? subtitle;

  const EmpathyMessage({super.key, required this.message, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: kColorRejectionNeutral.withAlpha(15),
        borderRadius: BorderRadius.circular(kRadiusCard),
        border:
            Border.all(color: kColorRejectionNeutral.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message,
              style: const TextStyle(
                  fontSize: kFontSubtitle,
                  fontWeight: FontWeight.w600,
                  color: kColorTextPrimary)),
          if (subtitle != null) ...[
            const SizedBox(height: kSpace4),
            Text(subtitle!,
                style: const TextStyle(
                    fontSize: kFontBody, color: kColorTextSecondary)),
          ],
        ],
      ),
    );
  }
}
