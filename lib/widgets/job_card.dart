import 'package:flutter/material.dart';
import '../models/job.dart';
import '../theme/app_theme.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onApply;
  final VoidCallback onSave;
  final bool isSaved;
  final VoidCallback? onTap;

  const JobCard({
    super.key,
    required this.job,
    required this.onApply,
    required this.onSave,
    required this.isSaved,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: kSpace16, vertical: kSpace8),
      child: InkWell(
        borderRadius: BorderRadius.circular(kRadiusCard),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(kSpace16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Match % hero
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kSpace8, vertical: kSpace4),
                    decoration: BoxDecoration(
                      color: kColorPrimary.withAlpha(25),
                      borderRadius: BorderRadius.circular(kSpace4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_rounded,
                            color: kColorPrimary, size: 16),
                        const SizedBox(width: kSpace4),
                        Text(
                          '${job.matchPercent}% match',
                          style: const TextStyle(
                            color: kColorPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: kFontBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? kColorAccent : kColorTextSecondary,
                    ),
                    onPressed: onSave,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 44, minHeight: 44),
                    tooltip: isSaved ? 'Saved' : 'Save job',
                  ),
                ],
              ),
              const SizedBox(height: kSpace4),
              Text(
                'matches your skills',
                style: TextStyle(
                  color: kColorPrimary.withAlpha(180),
                  fontSize: kFontCaption,
                ),
              ),
              const SizedBox(height: kSpace8),
              Text(job.title,
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: kSpace4),
              Text(
                '${job.company} · ${job.location}',
                style: const TextStyle(
                    fontSize: kFontBody, color: kColorTextSecondary),
              ),
              const SizedBox(height: kSpace4),
              Row(
                children: [
                  const Icon(Icons.payments_outlined,
                      size: 14, color: kColorTextSecondary),
                  const SizedBox(width: 2),
                  Text(job.salaryDisplay,
                      style: const TextStyle(
                          fontSize: kFontCaption,
                          color: kColorTextSecondary)),
                  const SizedBox(width: kSpace8),
                  const Icon(Icons.work_outline,
                      size: 14, color: kColorTextSecondary),
                  const SizedBox(width: 2),
                  Text(job.workModeLabel,
                      style: const TextStyle(
                          fontSize: kFontCaption,
                          color: kColorTextSecondary)),
                ],
              ),
              const SizedBox(height: kSpace12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onApply,
                  child: const Text('Apply now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
