import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BadgeChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool earned;

  const BadgeChip(
      {super.key,
      required this.emoji,
      required this.label,
      required this.earned});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Text(emoji, style: const TextStyle(fontSize: 16)),
      label: Text(label,
          style: TextStyle(
              color: earned ? kColorTextPrimary : kColorTextSecondary,
              fontWeight:
                  earned ? FontWeight.w600 : FontWeight.w400,
              fontSize: kFontCaption)),
      backgroundColor: earned
          ? kColorPrimary.withAlpha(20)
          : Colors.grey.shade100,
      side: BorderSide(
          color: earned ? kColorPrimary.withAlpha(60) : Colors.grey.shade200),
      padding: const EdgeInsets.symmetric(horizontal: kSpace4),
    );
  }
}
