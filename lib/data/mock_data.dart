import '../models/job.dart';
import '../models/application.dart';
import '../models/user_profile.dart';

// ─── Mock Jobs ────────────────────────────────────────────────────────────────
final List<Job> mockJobs = [
  const Job(
    id: 'j1',
    title: 'UX Designer',
    company: 'Tokopedia',
    location: 'Jakarta',
    salaryMin: '8jt',
    salaryMax: '12jt',
    workMode: WorkMode.hybrid,
    matchPercent: 85,
    description:
        'Join our product team to craft delightful user experiences for millions of Indonesians. You will own end-to-end design from research to pixel-perfect specs.',
    skills: ['Figma', 'User Research', 'Prototyping', 'Design Systems'],
    category: 'Design',
  ),
  const Job(
    id: 'j2',
    title: 'Flutter Developer',
    company: 'Gojek',
    location: 'Jakarta',
    salaryMin: '10jt',
    salaryMax: '15jt',
    workMode: WorkMode.hybrid,
    matchPercent: 92,
    description:
        'Build high-performance cross-platform apps used by 38 million users. You will work closely with product and design to ship features end-to-end.',
    skills: ['Flutter', 'Dart', 'REST API', 'Firebase'],
    category: 'Engineering',
  ),
  const Job(
    id: 'j3',
    title: 'Data Analyst',
    company: 'Shopee Indonesia',
    location: 'Jakarta',
    salaryMin: '7jt',
    salaryMax: '11jt',
    workMode: WorkMode.onsite,
    matchPercent: 72,
    description:
        'Turn data into insights that drive business decisions. You will build dashboards, run SQL queries, and present findings to leadership.',
    skills: ['SQL', 'Python', 'Tableau', 'Excel'],
    category: 'Data',
  ),
  const Job(
    id: 'j4',
    title: 'Product Manager',
    company: 'Traveloka',
    location: 'Bandung',
    salaryMin: '12jt',
    salaryMax: '18jt',
    workMode: WorkMode.hybrid,
    matchPercent: 68,
    description:
        'Lead a cross-functional squad building travel tech products. You will define roadmaps, write PRDs, and ship with engineers and designers.',
    skills: ['Product Strategy', 'Agile', 'Data Analysis', 'Stakeholder Management'],
    category: 'Product',
  ),
  const Job(
    id: 'j5',
    title: 'UI Designer',
    company: 'Bukalapak',
    location: 'Remote',
    salaryMin: '6jt',
    salaryMax: '9jt',
    workMode: WorkMode.remote,
    matchPercent: 78,
    description:
        'Create stunning, accessible UI for our marketplace. You will maintain our design system and collaborate with engineers on pixel-perfect implementation.',
    skills: ['Figma', 'UI Design', 'Design Systems', 'Accessibility'],
    category: 'Design',
  ),
  const Job(
    id: 'j6',
    title: 'Backend Developer',
    company: 'Dana Indonesia',
    location: 'Jakarta',
    salaryMin: '11jt',
    salaryMax: '16jt',
    workMode: WorkMode.hybrid,
    matchPercent: 60,
    description:
        'Build reliable, scalable APIs for Indonesia\'s leading e-wallet. You will work on payments infrastructure serving millions of daily transactions.',
    skills: ['Golang', 'PostgreSQL', 'Microservices', 'Kubernetes'],
    category: 'Engineering',
  ),
  const Job(
    id: 'j7',
    title: 'Content Strategist',
    company: 'Kompas Gramedia',
    location: 'Jakarta',
    salaryMin: '5jt',
    salaryMax: '8jt',
    workMode: WorkMode.onsite,
    matchPercent: 74,
    description:
        'Craft content that connects with readers across digital platforms. You will plan editorial calendars, optimise for SEO, and analyse performance metrics.',
    skills: ['Content Writing', 'SEO', 'Social Media', 'Analytics'],
    category: 'Content',
  ),
  const Job(
    id: 'j8',
    title: 'Mobile Developer (Android)',
    company: 'Akulaku',
    location: 'Remote',
    salaryMin: '9jt',
    salaryMax: '14jt',
    workMode: WorkMode.remote,
    matchPercent: 82,
    description:
        'Build Android features for our fintech app. Kotlin-first codebase, clean architecture, CI/CD pipeline already in place.',
    skills: ['Kotlin', 'Jetpack Compose', 'REST API', 'Git'],
    category: 'Engineering',
  ),
  const Job(
    id: 'j9',
    title: 'Growth Marketer',
    company: 'Halodoc',
    location: 'Bandung',
    salaryMin: '7jt',
    salaryMax: '10jt',
    workMode: WorkMode.hybrid,
    matchPercent: 65,
    description:
        'Drive user acquisition and retention for Indonesia\'s leading healthtech platform. You will run experiments, manage paid channels, and analyse funnels.',
    skills: ['Growth Hacking', 'Google Ads', 'Meta Ads', 'Analytics'],
    category: 'Marketing',
  ),
  const Job(
    id: 'j10',
    title: 'Graphic Designer',
    company: 'Kopi Kenangan',
    location: 'Jakarta',
    salaryMin: null,
    salaryMax: null,
    workMode: WorkMode.onsite,
    matchPercent: 88,
    description:
        'Create visual assets across digital and print for one of Indonesia\'s fastest-growing F&B brands. Strong illustration and brand sensibility a plus.',
    skills: ['Adobe Illustrator', 'Photoshop', 'Brand Design', 'Typography'],
    category: 'Design',
  ),
];

// ─── Mock Applications ────────────────────────────────────────────────────────
final List<Application> mockApplications = [
  Application(
    id: 'a1',
    job: mockJobs[0],
    status: ApplicationStatus.interview,
    appliedAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Application(
    id: 'a2',
    job: mockJobs[2],
    status: ApplicationStatus.rejected,
    appliedAt: DateTime.now().subtract(const Duration(days: 8)),
  ),
  Application(
    id: 'a3',
    job: mockJobs[4],
    status: ApplicationStatus.inReview,
    appliedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Application(
    id: 'a4',
    job: mockJobs[6],
    status: ApplicationStatus.rejected,
    appliedAt: DateTime.now().subtract(const Duration(days: 12)),
  ),
  Application(
    id: 'a5',
    job: mockJobs[7],
    status: ApplicationStatus.applied,
    appliedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];

// ─── Mock User ────────────────────────────────────────────────────────────────
final UserProfile mockUser = UserProfile(
  name: 'Rina Kusuma',
  headline: 'Fresh Graduate · UI/UX Designer',
  location: 'Bandung, Indonesia',
  completenessPercent: 80,
  searchStreakDays: 5,
  totalApplications: 8,
  thisWeekApplications: 6,
  skillsAddedThisWeek: 2,
  badges: const [
    Badge(
      id: 'b1',
      label: 'First Application',
      emoji: '🎉',
      description: 'Sent your first application',
      earned: true,
    ),
    Badge(
      id: 'b2',
      label: '5-Day Streak',
      emoji: '🔥',
      description: 'Searched for jobs 5 days in a row',
      earned: true,
    ),
    Badge(
      id: 'b3',
      label: 'Bounced Back',
      emoji: '💪',
      description: 'Applied within 48 h of a rejection',
      earned: true,
    ),
    Badge(
      id: 'b4',
      label: 'Applied to 10 Jobs',
      emoji: '🚀',
      description: 'Sent 10 applications',
      earned: false,
    ),
    Badge(
      id: 'b5',
      label: 'Skill Builder',
      emoji: '📚',
      description: 'Added 5 new skills to your profile',
      earned: false,
    ),
  ],
);

// ─── Skill-gap suggestions ─────────────────────────────────────────────────────
class SkillSuggestion {
  final String skill;
  final String courseTitle;
  final String platform;
  final String url;

  const SkillSuggestion({
    required this.skill,
    required this.courseTitle,
    required this.platform,
    required this.url,
  });
}

final List<SkillSuggestion> mockSkillSuggestions = const [
  SkillSuggestion(
    skill: 'SQL',
    courseTitle: 'SQL for Beginners',
    platform: 'Coursera',
    url: 'https://coursera.org',
  ),
  SkillSuggestion(
    skill: 'Figma Advanced',
    courseTitle: 'Advanced Figma — Auto Layout & Components',
    platform: 'YouTube (Free)',
    url: 'https://youtube.com',
  ),
  SkillSuggestion(
    skill: 'Product Thinking',
    courseTitle: 'Introduction to Product Management',
    platform: 'Dicoding',
    url: 'https://dicoding.com',
  ),
];
