import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_state.dart';
import '../models/application.dart';
import '../theme/app_theme.dart';
import 'rejection_recovery_screen.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final apps = state.applications;

    return Scaffold(
      appBar: AppBar(title: const Text('My Applications')),
      body: apps.isEmpty
          ? const Center(child: Text('No applications yet. Start applying! 🚀'))
          : ListView.separated(
              padding: const EdgeInsets.all(kSpace16),
              itemCount: apps.length,
              separatorBuilder: (_, __) => const SizedBox(height: kSpace8),
              itemBuilder: (_, i) => _AppCard(app: apps[i]),
            ),
    );
  }
}

class _AppCard extends StatelessWidget {
  final Application app;

  const _AppCard({required this.app});

  Color _statusColor() {
    switch (app.status) {
      case ApplicationStatus.applied:
        return Colors.blue;
      case ApplicationStatus.inReview:
        return kColorAccent;
      case ApplicationStatus.interview:
        return kColorPrimary;
      case ApplicationStatus.rejected:
        return kColorRejectionNeutral;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRejected = app.status == ApplicationStatus.rejected;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(kSpace12),
        title: Text(app.title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: kFontSubtitle)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kSpace4),
            Text(app.location != null
                    ? '${app.company} · ${app.location}'
                    : app.company,
                style: const TextStyle(
                    fontSize: kFontBody, color: kColorTextSecondary)),
            const SizedBox(height: kSpace4),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSpace8, vertical: 3),
              decoration: BoxDecoration(
                color: _statusColor().withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isRejected ? 'Not selected — see what\'s next →' : app.statusLabel,
                style: TextStyle(
                    color: _statusColor(),
                    fontSize: kFontCaption,
                    fontWeight: FontWeight.w600),
              ),
            ),
            if (app.followUpAt != null) ...[
              const SizedBox(height: kSpace4),
              Text(
                app.isFollowUpOverdue
                    ? '⏰ Good time to follow up'
                    : '⏰ Follow-up due ${app.followUpAt!.day}/${app.followUpAt!.month}',
                style: TextStyle(
                    fontSize: kFontCaption,
                    color: app.isFollowUpOverdue
                        ? kColorAccent
                        : kColorTextSecondary,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ],
        ),
        onTap: isRejected
            ? () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RejectionRecoveryScreen(application: app),
                  ),
                )
            : null,
        trailing: isRejected
            ? const Icon(Icons.arrow_forward_ios,
                size: 16, color: kColorTextSecondary)
            : null,
      ),
    );
  }
}
