import 'job.dart';

enum ApplicationStatus { applied, inReview, interview, rejected }

class Application {
  final String id;
  final Job job;
  final ApplicationStatus status;
  final DateTime appliedAt;

  const Application({
    required this.id,
    required this.job,
    required this.status,
    required this.appliedAt,
  });

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
}
