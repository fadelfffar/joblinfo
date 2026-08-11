import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StreakBanner extends StatelessWidget {
  final int streakDays;

  const StreakBanner({super.key, required this.streakDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: kSpace16, vertical: kSpace8),
      padding: const EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kColorPrimary, kColorPrimary.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(kRadiusCard),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 28)),
          const SizedBox(width: kSpace12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$streakDays-day search streak 💪',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: kFontSubtitle,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: kSpace4),
              const Text(
                'Consistency is how people get hired.',
                style: TextStyle(
                    color: Colors.white70, fontSize: kFontCaption),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

