import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_state.dart';
import '../models/job.dart';
import '../theme/app_theme.dart';
import 'celebration_screen.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;

  const JobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final alreadyApplied =
        state.applications.any((a) => a.job?.id == job.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
        actions: [
          IconButton(
            icon: Icon(
              state.isSaved(job.id) ? Icons.bookmark : Icons.bookmark_border,
              color:
                  state.isSaved(job.id) ? kColorAccent : kColorTextSecondary,
            ),
            onPressed: () => state.toggleSave(job.id),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(kSpace16),
        children: [
          // Match % hero
          Container(
            padding: const EdgeInsets.all(kSpace16),
            decoration: BoxDecoration(
              color: kColorPrimary.withAlpha(15),
              borderRadius: BorderRadius.circular(kRadiusCard),
            ),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.circular(kRadiusCard),
                  ),
                  child: Center(
                    child: Text(
                      '${job.matchPercent}%',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: kFontTitle,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: kSpace12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('match',
                          style: TextStyle(
                              color: kColorPrimary,
                              fontSize: kFontCaption,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: kSpace4),
                      Text(
                        'You match ${job.matchPercent}% of this role. '
                        'Most hires match less — go for it!',
                        style: const TextStyle(
                            fontSize: kFontBody, color: kColorTextPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kSpace16),

          Text(job.title,
              style: const TextStyle(
                  fontSize: kFontHeading, fontWeight: FontWeight.w700)),
          const SizedBox(height: kSpace4),
          Text('${job.company} · ${job.location}',
              style: const TextStyle(
                  fontSize: kFontSubtitle, color: kColorTextSecondary)),
          const SizedBox(height: kSpace8),
          Row(
            children: [
              _InfoChip(icon: Icons.attach_money, label: job.salaryDisplay),
              const SizedBox(width: kSpace8),
              _InfoChip(icon: Icons.work_outline, label: job.workModeLabel),
            ],
          ),
          const SizedBox(height: kSpace16),

          const Text('About the role',
              style: TextStyle(
                  fontSize: kFontSubtitle, fontWeight: FontWeight.w700)),
          const SizedBox(height: kSpace8),
          Text(job.description,
              style: const TextStyle(
                  fontSize: kFontBody,
                  color: kColorTextPrimary,
                  height: 1.5)),
          const SizedBox(height: kSpace16),

          const Text('Skills they\'re looking for',
              style: TextStyle(
                  fontSize: kFontSubtitle, fontWeight: FontWeight.w700)),
          const SizedBox(height: kSpace8),
          Wrap(
            spacing: kSpace8,
            runSpacing: kSpace8,
            children: job.skills
                .map((s) => Chip(
                      label: Text(s),
                      backgroundColor: kColorPrimary.withAlpha(15),
                      side: BorderSide(color: kColorPrimary.withAlpha(40)),
                      labelStyle: const TextStyle(
                          color: kColorPrimary, fontSize: kFontCaption),
                    ))
                .toList(),
          ),
          const SizedBox(height: kSpace24),

          if (alreadyApplied)
            Container(
              padding: const EdgeInsets.all(kSpace12),
              decoration: BoxDecoration(
                color: kColorPrimary.withAlpha(15),
                borderRadius: BorderRadius.circular(kRadiusButton),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: kColorPrimary),
                  SizedBox(width: kSpace8),
                  Text('Application submitted 🎉',
                      style: TextStyle(
                          color: kColorPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: kFontBody)),
                ],
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  state.applyToJob(job);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CelebrationScreen(
                            title: job.title,
                            company: job.company,
                            isResilience: false)),
                  );
                },
                child: const Text('Apply now'),
              ),
            ),
          const SizedBox(height: kSpace32),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSpace8, vertical: kSpace4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: kColorTextSecondary),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: kFontCaption, color: kColorTextSecondary)),
        ],
      ),
    );
  }
}

