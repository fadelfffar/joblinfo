import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileProgressBar extends StatelessWidget {
  final int percent;
  final String label;

  const ProfileProgressBar(
      {super.key, required this.percent, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: kFontCaption, color: kColorTextSecondary)),
        const SizedBox(height: kSpace4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent / 100,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            color: kColorPrimary,
          ),
        ),
      ],
    );
  }
}
