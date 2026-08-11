import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_state.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/job_card.dart';
import '../widgets/streak_banner.dart';
import 'job_detail_screen.dart';
import 'celebration_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final picks = mockJobs.take(4).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Let\'s find your next opportunity 🚀'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: kSpace8),
          StreakBanner(streakDays: mockUser.searchStreakDays),
          _weeklyRecap(context),
          const Padding(
            padding: EdgeInsets.fromLTRB(kSpace16, kSpace16, kSpace16, kSpace8),
            child: Text('Daily picks for you',
                style: TextStyle(
                    fontSize: kFontTitle,
                    fontWeight: FontWeight.w700,
                    color: kColorTextPrimary)),
          ),
          ...picks.map((job) => JobCard(
                job: job,
                isSaved: state.isSaved(job.id),
                onSave: () => state.toggleSave(job.id),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => JobDetailScreen(job: job)),
                ),
                onApply: () async {
                  state.applyToJob(job);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            CelebrationScreen(job: job, isResilience: false)),
                  );
                },
              )),
          const SizedBox(height: kSpace16),
        ],
      ),
    );
  }

  Widget _weeklyRecap(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: kSpace16, vertical: kSpace8),
      padding: const EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: kColorAccent.withAlpha(20),
        borderRadius: BorderRadius.circular(kRadiusCard),
        border: Border.all(color: kColorAccent.withAlpha(60)),
      ),
      child: Row(
        children: [
          const Text('📊', style: TextStyle(fontSize: 24)),
          const SizedBox(width: kSpace12),
          Expanded(
            child: Text(
              'You applied to ${mockUser.thisWeekApplications} jobs and added '
              '${mockUser.skillsAddedThisWeek} skills this week 💪',
              style: const TextStyle(
                  fontSize: kFontBody, color: kColorTextPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
