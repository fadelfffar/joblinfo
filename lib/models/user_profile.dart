class Badge {
  final String id;
  final String label;
  final String emoji;
  final String description;
  final bool earned;

  const Badge({
    required this.id,
    required this.label,
    required this.emoji,
    required this.description,
    required this.earned,
  });
}

class UserProfile {
  final String name;
  final String headline;
  final String location;
  final int completenessPercent;
  final int searchStreakDays;
  final int totalApplications;
  final int thisWeekApplications;
  final int skillsAddedThisWeek;
  final List<Badge> badges;

  const UserProfile({
    required this.name,
    required this.headline,
    required this.location,
    required this.completenessPercent,
    required this.searchStreakDays,
    required this.totalApplications,
    required this.thisWeekApplications,
    required this.skillsAddedThisWeek,
    required this.badges,
  });
}
