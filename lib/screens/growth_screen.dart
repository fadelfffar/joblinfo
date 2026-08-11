import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/badge_chip.dart';
import '../widgets/progress_bar.dart';

class GrowthScreen extends StatelessWidget {
  const GrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Growth 📈')),
      body: ListView(
        padding: const EdgeInsets.all(kSpace16),
        children: [
          // Motivational nudge
          Container(
            padding: const EdgeInsets.all(kSpace16),
            decoration: BoxDecoration(
              color: kColorPrimary.withAlpha(15),
              borderRadius: BorderRadius.circular(kRadiusCard),
            ),
            child: const Text(
              'It takes 20–40 applications on average to land a job. '
              'You\'re building momentum. 💪',
              style: TextStyle(
                  fontSize: kFontBody, color: kColorTextPrimary),
            ),
          ),
          const SizedBox(height: kSpace24),

          // Skill gap suggestions
          const Text('Skill-gap suggestions',
              style: TextStyle(
                  fontSize: kFontTitle,
                  fontWeight: FontWeight.w700,
                  color: kColorTextPrimary)),
          const SizedBox(height: kSpace8),
          const Text(
            'Based on jobs you\'ve applied to, here are free courses to close the gaps:',
            style:
                TextStyle(fontSize: kFontBody, color: kColorTextSecondary),
          ),
          const SizedBox(height: kSpace12),
          ...mockSkillSuggestions.map((s) => Card(
                margin: const EdgeInsets.only(bottom: kSpace8),
                child: Padding(
                  padding: const EdgeInsets.all(kSpace12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.school_outlined,
                              color: kColorPrimary, size: 18),
                          const SizedBox(width: kSpace8),
                          Text(s.skill,
                              style: const TextStyle(
                                  fontSize: kFontSubtitle,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: kSpace4),
                      Text(s.courseTitle,
                          style: const TextStyle(
                              fontSize: kFontBody,
                              color: kColorTextPrimary)),
                      const SizedBox(height: kSpace4),
                      Text(s.platform,
                          style: const TextStyle(
                              fontSize: kFontCaption,
                              color: kColorTextSecondary)),
                      const SizedBox(height: kSpace8),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('View free course →'),
                      ),
                    ],
                  ),
                ),
              )),

          const SizedBox(height: kSpace24),

          // Resilience badges
          const Text('Your badges',
              style: TextStyle(
                  fontSize: kFontTitle,
                  fontWeight: FontWeight.w700,
                  color: kColorTextPrimary)),
          const SizedBox(height: kSpace4),
          const Text(
            'Earned through effort, not just results.',
            style:
                TextStyle(fontSize: kFontBody, color: kColorTextSecondary),
          ),
          const SizedBox(height: kSpace12),
          Wrap(
            spacing: kSpace8,
            runSpacing: kSpace8,
            children: mockUser.badges
                .map((b) => BadgeChip(
                      emoji: b.emoji,
                      label: b.label,
                      earned: b.earned,
                    ))
                .toList(),
          ),

          const SizedBox(height: kSpace24),

          // Progress bar
          const Text('Skills progress',
              style: TextStyle(
                  fontSize: kFontTitle,
                  fontWeight: FontWeight.w700,
                  color: kColorTextPrimary)),
          const SizedBox(height: kSpace12),
          ProfileProgressBar(
            percent: 60,
            label: 'Design skills',
          ),
          const SizedBox(height: kSpace12),
          ProfileProgressBar(
            percent: 40,
            label: 'Technical skills',
          ),
          const SizedBox(height: kSpace12),
          ProfileProgressBar(
            percent: 75,
            label: 'Communication skills',
          ),
          const SizedBox(height: kSpace32),
        ],
      ),
    );
  }
}

