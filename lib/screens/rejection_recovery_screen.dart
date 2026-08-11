import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_state.dart';
import '../data/mock_data.dart';
import '../models/application.dart';
import '../models/job.dart';
import '../theme/app_theme.dart';
import '../widgets/empathy_message.dart';
import '../widgets/job_card.dart';
import 'celebration_screen.dart';

/// Rotating pool of encouraging messages shown after a rejection so the
/// screen doesn't feel repetitive on repeat visits.
const _kEncouragingHeadlines = [
  'This one wasn\'t a match',
  'Not a "no" forever — just not this role',
  'One door closed, more are opening',
  'This is a redirect, not a dead end',
];

const _kEncouragingSubtitles = [
  'The right one is still out there. Here\'s what\'s next.',
  'Rejection means "not this fit," not "not good enough."',
  'Every application is practice for the one that says yes.',
  'You showed up. That already puts you ahead of most people.',
];

class RejectionRecoveryScreen extends StatelessWidget {
  final Application application;

  const RejectionRecoveryScreen({super.key, required this.application});

  List<Job> _similarJobs(List<String> appliedJobIds) {
    final rejectedJob = application.job;
    if (rejectedJob == null) return mockJobs.take(3).toList();
    return mockJobs
        .where((j) =>
            j.id != rejectedJob.id &&
            !appliedJobIds.contains(j.id) &&
            j.matchPercent >= rejectedJob.matchPercent)
        .take(3)
        .toList();
  }

  // Find the first skill from the rejected job that has a matching suggestion.
  String? _skillGap() {
    final rejectedJob = application.job;
    if (rejectedJob == null) return null;
    for (final skill in rejectedJob.skills) {
      final match = mockSkillSuggestions
          .any((s) => s.skill.toLowerCase() == skill.toLowerCase());
      if (match) return skill;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final appliedJobIds =
        state.applications.map((a) => a.job?.id).whereType<String>().toList();
    final similar = _similarJobs(appliedJobIds);
    final gap = _skillGap();

    // Pick a message consistently per application (stable across rebuilds)
    // but varying between different rejections.
    final rand = Random(application.id.hashCode);
    final headline =
        _kEncouragingHeadlines[rand.nextInt(_kEncouragingHeadlines.length)];
    final subtitle =
        _kEncouragingSubtitles[rand.nextInt(_kEncouragingSubtitles.length)];

    return Scaffold(
      appBar: AppBar(
        title: const Text('What\'s next'),
        backgroundColor: kColorSurface,
      ),
      body: ListView(
        padding: const EdgeInsets.all(kSpace16),
        children: [
          // Empathetic header
          EmpathyMessage(
            message: headline,
            subtitle: subtitle,
          ),
          const SizedBox(height: kSpace8),
          Text(
            '${application.title} at ${application.company}',
            style: const TextStyle(
                fontSize: kFontBody,
                color: kColorTextSecondary,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: kSpace16),

          // Stat normalisation
          Container(
            padding: const EdgeInsets.all(kSpace12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(kRadiusCard),
            ),
            child: const Text(
              'It takes 20–40 applications on average to land a job. '
              'You\'re building momentum.',
              style: TextStyle(
                  fontSize: kFontBody,
                  color: kColorTextSecondary,
                  fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: kSpace16),

          // Skill gap card
          if (gap != null) ...[
            _SkillGapCard(skill: gap),
            const SizedBox(height: kSpace16),
          ],

          // Similar jobs
          const Text(
            'Roles where you\'re an even stronger match',
            style: TextStyle(
                fontSize: kFontSubtitle,
                fontWeight: FontWeight.w700,
                color: kColorTextPrimary),
          ),
          const SizedBox(height: kSpace8),
          ...similar.map((job) => JobCard(
                job: job,
                isSaved: state.isSaved(job.id),
                onSave: () => state.toggleSave(job.id),
                onApply: () async {
                  state.applyToJob(job);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CelebrationScreen(
                            title: job.title,
                            company: job.company,
                            isResilience: true)),
                  );
                },
              )),
          const SizedBox(height: kSpace32),
        ],
      ),
    );
  }
}

class _SkillGapCard extends StatelessWidget {
  final String skill;

  const _SkillGapCard({required this.skill});

  @override
  Widget build(BuildContext context) {
    final suggestion = mockSkillSuggestions.firstWhere(
      (s) => s.skill == skill,
      orElse: () => mockSkillSuggestions.first,
    );

    return Container(
      padding: const EdgeInsets.all(kSpace12),
      decoration: BoxDecoration(
        color: kColorAccent.withAlpha(20),
        borderRadius: BorderRadius.circular(kRadiusCard),
        border: Border.all(color: kColorAccent.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📚', style: TextStyle(fontSize: 18)),
              const SizedBox(width: kSpace8),
              Text('This role wanted $skill',
                  style: const TextStyle(
                      fontSize: kFontBody,
                      fontWeight: FontWeight.w600,
                      color: kColorTextPrimary)),
            ],
          ),
          const SizedBox(height: kSpace8),
          Text('Here\'s a free course: ${suggestion.courseTitle}',
              style: const TextStyle(
                  fontSize: kFontBody, color: kColorTextPrimary)),
          const SizedBox(height: kSpace4),
          Text(suggestion.platform,
              style: const TextStyle(
                  fontSize: kFontCaption, color: kColorTextSecondary)),
          const SizedBox(height: kSpace8),
          OutlinedButton(
            onPressed: () {},
            child: const Text('View free course →'),
          ),
        ],
      ),
    );
  }
}

