/// Preferred work arrangement for a job listing.
enum WorkMode { remote, hybrid, onsite }

/// Immutable job listing model used across browse and apply flows.
class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String? salaryMin;
  final String? salaryMax;
  final WorkMode workMode;
  final int matchPercent;
  final String description;
  final List<String> skills;
  final String category;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    this.salaryMin,
    this.salaryMax,
    required this.workMode,
    required this.matchPercent,
    required this.description,
    required this.skills,
    required this.category,
  });

  String get salaryDisplay {
    if (salaryMin == null) return 'Salary not listed';
    return 'Rp $salaryMin – $salaryMax';
  }

  String get workModeLabel {
    switch (workMode) {
      case WorkMode.remote:
        return 'Remote';
      case WorkMode.hybrid:
        return 'Hybrid';
      case WorkMode.onsite:
        return 'On-site';
    }
  }
}
