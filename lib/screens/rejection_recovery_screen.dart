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

class RejectionRecoveryScreen extends StatelessWidget {
  final Application application;

  const RejectionRecoveryScreen({super.key, required this.application});

  List<Job> _similarJobs(List<String> appliedJobIds) {
    return mockJobs
        .where((j) =>
            j.id != application.job.id &&
            !appliedJobIds.contains(j.id) &&
            j.matchPercent >= application.job.matchPercent)
        .take(3)
        .toList();
  }

  // Find the first skill from the rejected job that has a matching suggestion.
  String? _skillGap() {
    for (final skill in application.job.skills) {
      final match = mockSkillSuggestions
          .any((s) => s.skill.toLowerCase() == skill.toLowerCase());
      if (match) return skill;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final appliedJobIds = state.applications.map((a) => a.job.id).toList();
    final similar = _similarJobs(appliedJobIds);
    final gap = _skillGap();

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
            message: 'This one wasn\'t a match',
            subtitle:
                'The right one is still out there. Here\'s what\'s next.',
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
                        builder: (_) =>
                            CelebrationScreen(job: job, isResilience: true)),
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

