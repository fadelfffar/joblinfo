import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_state.dart';
import '../data/mock_data.dart';
import '../models/job.dart';
import '../theme/app_theme.dart';
import '../widgets/job_card.dart';
import 'job_detail_screen.dart';
import 'celebration_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _query = '';
  String? _selectedCategory;

  final _categories = ['All', 'Design', 'Engineering', 'Data', 'Product', 'Content', 'Marketing'];

  List<Job> get _filtered {
    var jobs = mockJobs;
    if (_query.isNotEmpty) {
      jobs = jobs
          .where((j) =>
              j.title.toLowerCase().contains(_query.toLowerCase()) ||
              j.company.toLowerCase().contains(_query.toLowerCase()) ||
              j.location.toLowerCase().contains(_query.toLowerCase()))
          .toList();
    }
    if (_selectedCategory != null && _selectedCategory != 'All') {
      jobs = jobs.where((j) => j.category == _selectedCategory).toList();
    }
    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final jobs = _filtered;

    return Scaffold(
      appBar: AppBar(title: const Text('Explore Jobs')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                kSpace16, kSpace8, kSpace16, 0),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search jobs, companies…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadiusCard),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadiusCard),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
          ),
          const SizedBox(height: kSpace8),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: kSpace16),
              children: _categories.map((cat) {
                final selected = _selectedCategory == cat ||
                    (_selectedCategory == null && cat == 'All');
                return Padding(
                  padding: const EdgeInsets.only(right: kSpace8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => setState(() =>
                        _selectedCategory = cat == 'All' ? null : cat),
                    selectedColor: kColorPrimary.withAlpha(30),
                    checkmarkColor: kColorPrimary,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: kSpace8),
          Expanded(
            child: jobs.isEmpty
                ? _emptyState()
                : ListView.builder(
                    itemCount: jobs.length,
                    itemBuilder: (_, i) => JobCard(
                      job: jobs[i],
                      isSaved: state.isSaved(jobs[i].id),
                      onSave: () => state.toggleSave(jobs[i].id),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                JobDetailScreen(job: jobs[i])),
                      ),
                      onApply: () async {
                        state.applyToJob(jobs[i]);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CelebrationScreen(
                                  job: jobs[i], isResilience: false)),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(kSpace32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🔍', style: TextStyle(fontSize: 48)),
            SizedBox(height: kSpace16),
            Text(
              'No matches today',
              style: TextStyle(
                  fontSize: kFontTitle,
                  fontWeight: FontWeight.w700,
                  color: kColorTextPrimary),
            ),
            SizedBox(height: kSpace8),
            Text(
              'Here\'s how to improve your profile:\n'
              '• Add more skills\n'
              '• Update your headline\n'
              '• Set your preferred locations',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: kFontBody, color: kColorTextSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
