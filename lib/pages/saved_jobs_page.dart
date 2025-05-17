import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/saved_jobs_helper.dart';
import 'job_detail_page.dart';

class SavedJobsPage extends StatefulWidget {
  const SavedJobsPage({super.key});

  @override
  State<SavedJobsPage> createState() => _SavedJobsPageState();
}

class _SavedJobsPageState extends State<SavedJobsPage> {
  late List savedJobs;

  @override
  void initState() {
    super.initState();
    loadSavedJobs();
  }

  void loadSavedJobs() {
    setState(() {
      savedJobs = SavedJobsHelper.getSavedJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Saved jobs ',
          style: GoogleFonts.wellfleet(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.4,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: savedJobs.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bookmark_border,
                size: 80, color: Colors.deepPurple.shade200),
            const SizedBox(height: 16),
            Text(
              'No saved jobs yet',
              style: GoogleFonts.wellfleet(
                fontWeight: FontWeight.bold,
                letterSpacing: 2.4,
                fontSize: 28,
                color: Colors.deepPurple.shade400,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Save jobs to see them here.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.deepPurple.shade300,
              ),
            ),
          ],
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: savedJobs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final job = savedJobs[index];
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            elevation: 6,
            shadowColor: Colors.deepPurple.withOpacity(0.3),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 14),
              title: Text(
                job.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.deepPurple.shade900,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    if (job.company != null &&
                        job.company!.isNotEmpty)
                      Flexible(
                        child: Text(
                          job.company,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.deepPurple.shade300,
                          ),
                        ),
                      ),
                    if (job.location != null &&
                        job.location!.isNotEmpty) ...[
                      const SizedBox(width: 10),
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
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
                    ],
                  ],
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  size: 18, color: Colors.deepPurple.shade400),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JobDetailPage(job: job),
                  ),
                );
                loadSavedJobs();
              },
            ),
          );
        },
      ),
    );
  }
}
