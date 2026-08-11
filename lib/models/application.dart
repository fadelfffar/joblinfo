import 'job.dart';

enum ApplicationStatus { applied, inReview, interview, rejected }

class Application {
  final String id;
  // Set when the application originated from a job-board listing (Explore).
  // Null for applications entered manually on the Home screen.
  final Job? job;
  final String title;
  final String company;
  final String? location;
  final ApplicationStatus status;
  final DateTime appliedAt;
  // When the user should check in / follow up on this application.
  final DateTime? followUpAt;
  final String? notes;

  const Application({
    required this.id,
    this.job,
    required this.title,
    required this.company,
    this.location,
    required this.status,
    required this.appliedAt,
    this.followUpAt,
    this.notes,
  });

  Application copyWith({
    ApplicationStatus? status,
    DateTime? followUpAt,
    bool clearFollowUp = false,
    String? notes,
  }) {
    return Application(
      id: id,
      job: job,
      title: title,
      company: company,
      location: location,
      status: status ?? this.status,
      appliedAt: appliedAt,
      followUpAt: clearFollowUp ? null : (followUpAt ?? this.followUpAt),
      notes: notes ?? this.notes,
    );
  }

  String get statusLabel {
    switch (status) {
      case ApplicationStatus.applied:
        return 'Applied';
      case ApplicationStatus.inReview:
        return 'In review';
      case ApplicationStatus.interview:
        return 'Interview';
      case ApplicationStatus.rejected:
        return 'Not selected';
    }
  }

  /// Days until the follow-up date. Negative means overdue.
  int? get daysUntilFollowUp {
    if (followUpAt == null) return null;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(followUpAt!.year, followUpAt!.month, followUpAt!.day);
    return due.difference(today).inDays;
  }

  bool get isFollowUpOverdue =>
      daysUntilFollowUp != null && daysUntilFollowUp! < 0;

  bool get isFollowUpDueSoon =>
      daysUntilFollowUp != null &&
      daysUntilFollowUp! >= 0 &&
      daysUntilFollowUp! <= 3;
}
