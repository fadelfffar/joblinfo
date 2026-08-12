import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/progress_bar.dart';
import '../widgets/badge_chip.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const user = mockUser;

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: ListView(
        padding: const EdgeInsets.all(kSpace16),
        children: [
          // Avatar + info
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: kColorPrimary.withAlpha(30),
                  child: Text(
                    user.name.split(' ').map((w) => w[0]).take(2).join(),
                    style: const TextStyle(
                        fontSize: kFontHeading,
                        fontWeight: FontWeight.w700,
                        color: kColorPrimary),
                  ),
                ),
                const SizedBox(height: kSpace8),
                Text(user.name,
                    style: const TextStyle(
                        fontSize: kFontTitle,
                        fontWeight: FontWeight.w700,
                        color: kColorTextPrimary)),
                const SizedBox(height: kSpace4),
                Text(user.headline,
                    style: const TextStyle(
                        fontSize: kFontBody, color: kColorTextSecondary)),
                const SizedBox(height: kSpace4),
                Text('📍 ${user.location}',
                    style: const TextStyle(
                        fontSize: kFontCaption, color: kColorTextSecondary)),
              ],
            ),
          ),
          const SizedBox(height: kSpace24),

          // Completeness
          Container(
            padding: const EdgeInsets.all(kSpace16),
            decoration: BoxDecoration(
              color: kColorAccent.withAlpha(20),
              borderRadius: BorderRadius.circular(kRadiusCard),
              border: Border.all(color: kColorAccent.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.completenessPercent}% complete — finish it to get 3× more views',
                  style: const TextStyle(
                      fontSize: kFontBody,
                      fontWeight: FontWeight.w600,
                      color: kColorTextPrimary),
                ),
                const SizedBox(height: kSpace8),
                ProfileProgressBar(
                  percent: user.completenessPercent,
                  label: 'Profile completeness',
                ),
                const SizedBox(height: kSpace8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Complete profile'),
                ),
              ],
            ),
          ),
          const SizedBox(height: kSpace24),

          // Stats
          const Text('Your stats',
              style: TextStyle(
                  fontSize: kFontSubtitle,
                  fontWeight: FontWeight.w700,
                  color: kColorTextPrimary)),
          const SizedBox(height: kSpace12),
          Row(
            children: [
              _StatCard(
                  label: 'Applications',
                  value: '${user.totalApplications}',
                  emoji: '📝'),
              const SizedBox(width: kSpace12),
              _StatCard(
                  label: 'Search streak',
                  value: '${user.searchStreakDays}d',
                  emoji: '🔥'),
            ],
          ),
          const SizedBox(height: kSpace24),

          // Badges
          const Text('Badges earned',
              style: TextStyle(
                  fontSize: kFontSubtitle,
                  fontWeight: FontWeight.w700,
                  color: kColorTextPrimary)),
          const SizedBox(height: kSpace12),
          Wrap(
            spacing: kSpace8,
            runSpacing: kSpace8,
            children: user.badges
                .where((b) => b.earned)
                .map((b) =>
                    BadgeChip(emoji: b.emoji, label: b.label, earned: true))
                .toList(),
          ),
          const SizedBox(height: kSpace32),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String emoji;

  const _StatCard(
      {required this.label, required this.value, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(kSpace16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kRadiusCard),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: kSpace4),
            Text(value,
                style: const TextStyle(
                    fontSize: kFontHeading,
                    fontWeight: FontWeight.w700,
                    color: kColorPrimary)),
            Text(label,
                style: const TextStyle(
                    fontSize: kFontCaption, color: kColorTextSecondary)),
          ],
        ),
      ),
    );
  }
}

