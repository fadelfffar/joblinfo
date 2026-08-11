import 'package:flutter/foundation.dart';
import '../models/application.dart';
import '../models/job.dart';
import '../data/mock_data.dart';

class AppState extends ChangeNotifier {
  final List<Application> _applications = List.from(mockApplications);
  final List<String> _savedJobIds = [];

  List<Application> get applications => List.unmodifiable(_applications);
  List<String> get savedJobIds => List.unmodifiable(_savedJobIds);

  bool isSaved(String jobId) => _savedJobIds.contains(jobId);

  void toggleSave(String jobId) {
    if (_savedJobIds.contains(jobId)) {
      _savedJobIds.remove(jobId);
    } else {
      _savedJobIds.add(jobId);
    }
    notifyListeners();
  }

  int _nextId = 100;

  void applyToJob(Job job) {
    final alreadyApplied = _applications.any((a) => a.job?.id == job.id);
    if (alreadyApplied) return;
    _applications.add(Application(
      id: 'a${_nextId++}',
      job: job,
      title: job.title,
      company: job.company,
      location: job.location,
      status: ApplicationStatus.applied,
      appliedAt: DateTime.now(),
    ));
    notifyListeners();
  }

  /// Adds an application entered manually by the user (Home screen).
  void addManualApplication({
    required String title,
    required String company,
    String? location,
    required ApplicationStatus status,
    required DateTime appliedAt,
    DateTime? followUpAt,
    String? notes,
  }) {
    _applications.insert(
      0,
      Application(
        id: 'a${_nextId++}',
        title: title,
        company: company,
        location: location,
        status: status,
        appliedAt: appliedAt,
        followUpAt: followUpAt,
        notes: notes,
      ),
    );
    notifyListeners();
  }

  void updateFollowUp(String applicationId, DateTime? followUpAt) {
    final i = _applications.indexWhere((a) => a.id == applicationId);
    if (i == -1) return;
    _applications[i] = _applications[i].copyWith(
      followUpAt: followUpAt,
      clearFollowUp: followUpAt == null,
    );
    notifyListeners();
  }

  void updateStatus(String applicationId, ApplicationStatus status) {
    final i = _applications.indexWhere((a) => a.id == applicationId);
    if (i == -1) return;
    _applications[i] = _applications[i].copyWith(status: status);
    notifyListeners();
  }

  /// Applications whose follow-up date has passed and still need attention.
  List<Application> get overdueFollowUps => (_applications
        .where((a) => a.isFollowUpOverdue)
        .toList()
    ..sort((a, b) => a.followUpAt!.compareTo(b.followUpAt!)));

  /// Applications with a follow-up due today or within the next few days.
  List<Application> get upcomingFollowUps => (_applications
        .where((a) => a.isFollowUpDueSoon)
        .toList()
    ..sort((a, b) => a.followUpAt!.compareTo(b.followUpAt!)));
}
