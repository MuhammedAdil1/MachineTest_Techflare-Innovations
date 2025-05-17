import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jobease/pages/saved_jobs_page.dart';
import '../api_services/job_service.dart';
import '../models/job_model.dart';
import '../widgets/build_search_filter_bar.dart';
import 'job_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<JobModel> allJobs = [];
  List<JobModel> _filteredJobs = [];

  String _searchFilter = '';
  String _locationFilter = '';
  String _companyFilter = '';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    final jobs = await JobService.fetchJobs();
    setState(() {
      allJobs = jobs;
      _filteredJobs = jobs;
      _isLoading = false;
    });
  }

  void _applyFilters({String? search, String? location, String? company}) {
    setState(() {
      _searchFilter = search ?? _searchFilter;
      _locationFilter = location ?? _locationFilter;
      _companyFilter = company ?? _companyFilter;

      _filteredJobs = allJobs.where((job) {
        final matchesSearch = job.title.toLowerCase().contains(_searchFilter.toLowerCase());
        final matchesLocation = _locationFilter.isEmpty ||
            job.location.toLowerCase().contains(_locationFilter.toLowerCase());
        final matchesCompany = _companyFilter.isEmpty ||
            job.company.toLowerCase().contains(_companyFilter.toLowerCase());
        return matchesSearch && matchesLocation && matchesCompany;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JobEase',
          style: GoogleFonts.wellfleet(
            fontWeight: FontWeight.bold,
            letterSpacing: 6.4,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade700,
        elevation: 4,
        actions: [
          IconButton(
            tooltip: 'Saved Jobs',
            icon: const Icon(Icons.bookmark_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavedJobsPage()),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          BuildSearchFilterBar(onFilterChanged: _applyFilters),
          Expanded(
            child: _isLoading
                ? const Center(
              child: SpinKitFadingCircle(
                color: Colors.deepPurple,
                size: 50.0,
              ),
            )
                : _filteredJobs.isEmpty
                ? Center(
              child: Text(
                'No jobs found',
                style: GoogleFonts.wellfleet(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5.4,
                  fontSize: 20,
                  color: Colors.deepPurple[500],
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _filteredJobs.length,
              itemBuilder: (context, index) {
                final job = _filteredJobs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.deepPurple.withOpacity(0.3),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobDetailPage(job: job),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.deepPurple.shade900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            job.company,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.deepPurple.shade300,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 18,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  job.location,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.deepPurple.shade400,
                                size: 28,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
