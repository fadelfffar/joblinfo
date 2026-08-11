import 'package:flutter_test/flutter_test.dart';
import 'package:joblinfo/data/app_state.dart';
import 'package:joblinfo/data/mock_data.dart';
import 'package:joblinfo/models/application.dart';

void main() {
  group('AppState', () {
    test('starts with mock applications', () {
      final state = AppState();
      expect(state.applications.length, equals(mockApplications.length));
    });

    test('applyToJob adds a new application', () {
      final state = AppState();
      final job = mockJobs.last;
      final before = state.applications.length;
      state.applyToJob(job);
      expect(state.applications.length, equals(before + 1));
      expect(state.applications.last.status, equals(ApplicationStatus.applied));
    });

    test('applyToJob is idempotent for existing jobs', () {
      final state = AppState();
      final job = mockJobs[0]; // already applied in mock data
      final before = state.applications.length;
      state.applyToJob(job);
      expect(state.applications.length, equals(before));
    });

    test('toggleSave saves and unsaves a job', () {
      final state = AppState();
      final jobId = mockJobs[0].id;
      expect(state.isSaved(jobId), isFalse);
      state.toggleSave(jobId);
      expect(state.isSaved(jobId), isTrue);
      state.toggleSave(jobId);
      expect(state.isSaved(jobId), isFalse);
    });
  });

  group('Mock data', () {
    test('has 10 jobs', () => expect(mockJobs.length, equals(10)));
    test('has 5 applications', () => expect(mockApplications.length, equals(5)));
    test('has at least 2 rejections', () {
      final rejected = mockApplications
          .where((a) => a.status == ApplicationStatus.rejected)
          .length;
      expect(rejected, greaterThanOrEqualTo(2));
    });
    test('one job has missing salary', () {
      final noSalary = mockJobs.where((j) => j.salaryMin == null).length;
      expect(noSalary, greaterThanOrEqualTo(1));
    });
    test('match percent in range 60–95', () {
      for (final job in mockJobs) {
        expect(job.matchPercent, inInclusiveRange(60, 95));
      }
    });
  });
}
