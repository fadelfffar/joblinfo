import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_state.dart';
import '../data/mock_data.dart';
import '../models/application.dart';
import '../theme/app_theme.dart';
import '../widgets/streak_banner.dart';
import 'rejection_recovery_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  ApplicationStatus _status = ApplicationStatus.applied;
  DateTime _appliedAt = DateTime.now();
  DateTime? _followUpAt;

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickAppliedDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _appliedAt,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _appliedAt = picked);
  }

  Future<void> _pickFollowUpDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _followUpAt ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _followUpAt = picked);
  }

  void _submit(AppState state) {
    if (!_formKey.currentState!.validate()) return;
    state.addManualApplication(
      title: _titleController.text.trim(),
      company: _companyController.text.trim(),
      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
      status: _status,
      appliedAt: _appliedAt,
      followUpAt: _followUpAt,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_status == ApplicationStatus.rejected
            ? 'Logged. It didn\'t work out this time — but you kept going, and that counts. 💪'
            : 'Application logged. One step closer! 🚀'),
      ),
    );

    setState(() {
      _titleController.clear();
      _companyController.clear();
      _locationController.clear();
      _notesController.clear();
      _status = ApplicationStatus.applied;
      _appliedAt = DateTime.now();
      _followUpAt = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keep going 🚀'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: kSpace32),
        children: [
          const SizedBox(height: kSpace8),
          StreakBanner(streakDays: mockUser.searchStreakDays),
          _weeklyRecap(context),
          _followUpSection(context, state),
          _entryForm(context, state),
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

  Widget _followUpSection(BuildContext context, AppState state) {
    final overdue = state.overdueFollowUps;
    final upcoming = state.upcomingFollowUps;
    if (overdue.isEmpty && upcoming.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpace16, kSpace8, kSpace16, kSpace8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⏰ Time to follow up',
              style: TextStyle(
                  fontSize: kFontTitle,
                  fontWeight: FontWeight.w700,
                  color: kColorTextPrimary)),
          const SizedBox(height: kSpace8),
          ...overdue.map((a) => _FollowUpCard(application: a, overdue: true)),
          ...upcoming.map((a) => _FollowUpCard(application: a, overdue: false)),
        ],
      ),
    );
  }

  Widget _entryForm(BuildContext context, AppState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpace16, kSpace8, kSpace16, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kSpace16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('📝 Log an application',
                    style: TextStyle(
                        fontSize: kFontTitle,
                        fontWeight: FontWeight.w700,
                        color: kColorTextPrimary)),
                const SizedBox(height: kSpace4),
                const Text(
                  'Track it here yourself — no job board needed.',
                  style: TextStyle(
                      fontSize: kFontBody, color: kColorTextSecondary),
                ),
                const SizedBox(height: kSpace16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Position / job title',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: kSpace12),
                TextFormField(
                  controller: _companyController,
                  decoration: const InputDecoration(
                    labelText: 'Company',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: kSpace12),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location (optional)',
                  ),
                ),
                const SizedBox(height: kSpace12),
                DropdownButtonFormField<ApplicationStatus>(
                  initialValue: _status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: ApplicationStatus.values
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(Application(
                              id: '',
                              title: '',
                              company: '',
                              status: s,
                              appliedAt: DateTime.now(),
                            ).statusLabel),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _status = v ?? ApplicationStatus.applied),
                ),
                const SizedBox(height: kSpace12),
                _DatePickerTile(
                  icon: Icons.event_available,
                  label: 'Applied on',
                  value: _appliedAt,
                  onTap: _pickAppliedDate,
                ),
                const SizedBox(height: kSpace8),
                _DatePickerTile(
                  icon: Icons.alarm,
                  label: 'Remind me to follow up',
                  value: _followUpAt,
                  onTap: _pickFollowUpDate,
                  onClear: _followUpAt == null
                      ? null
                      : () => setState(() => _followUpAt = null),
                ),
                const SizedBox(height: kSpace12),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes (optional)',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: kSpace16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => _submit(state),
                    child: const Text('Save application'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DatePickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const _DatePickerTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  String _format(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(kRadiusButton),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kSpace12, vertical: kSpace12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusButton),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: kColorTextSecondary),
            const SizedBox(width: kSpace8),
            Expanded(
              child: Text(
                value == null ? label : '$label: ${_format(value!)}',
                style: const TextStyle(
                    fontSize: kFontBody, color: kColorTextPrimary),
              ),
            ),
            if (onClear != null)
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onClear,
              ),
          ],
        ),
      ),
    );
  }
}

class _FollowUpCard extends StatelessWidget {
  final Application application;
  final bool overdue;

  const _FollowUpCard({required this.application, required this.overdue});

  String _dueLabel() {
    final days = application.daysUntilFollowUp!;
    if (days < 0) {
      final n = days.abs();
      return 'Overdue by $n day${n == 1 ? '' : 's'}';
    }
    if (days == 0) return 'Due today';
    return 'Due in $days day${days == 1 ? '' : 's'}';
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final color = overdue ? Colors.redAccent : kColorAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: kSpace8),
      padding: const EdgeInsets.all(kSpace12),
      decoration: BoxDecoration(
        color: color.withAlpha(18),
        borderRadius: BorderRadius.circular(kRadiusCard),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(overdue ? Icons.notifications_active : Icons.alarm,
              color: color, size: 20),
          const SizedBox(width: kSpace12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${application.title} · ${application.company}',
                    style: const TextStyle(
                        fontSize: kFontBody,
                        fontWeight: FontWeight.w600,
                        color: kColorTextPrimary)),
                const SizedBox(height: kSpace4),
                Text(_dueLabel(),
                    style: TextStyle(
                        fontSize: kFontCaption,
                        color: color,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: kSpace8),
                Wrap(
                  spacing: kSpace8,
                  children: [
                    if (application.status == ApplicationStatus.rejected)
                      OutlinedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RejectionRecoveryScreen(
                                application: application),
                          ),
                        ),
                        child: const Text('See what\'s next'),
                      )
                    else
                      OutlinedButton(
                        onPressed: () =>
                            state.updateFollowUp(application.id, null),
                        child: const Text('Mark as followed up'),
                      ),
                    TextButton(
                      onPressed: () => state.updateFollowUp(
                        application.id,
                        DateTime.now().add(const Duration(days: 3)),
                      ),
                      child: const Text('Snooze 3d'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
