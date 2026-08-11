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
    final alreadyApplied = _applications.any((a) => a.job.id == job.id);
    if (alreadyApplied) return;
    _applications.add(Application(
      id: 'a${_nextId++}',
      job: job,
      status: ApplicationStatus.applied,
      appliedAt: DateTime.now(),
    ));
    notifyListeners();
  }
}
