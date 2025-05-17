import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/job_model.dart';
import '../utils/saved_jobs_helper.dart';

class JobDetailPage extends StatefulWidget {
  final JobModel job;

  const JobDetailPage({super.key, required this.job});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    isSaved = SavedJobsHelper.isJobSaved(widget.job.id);
  }

  void toggleSave() {
    setState(() {
      if (isSaved) {
        SavedJobsHelper.removeJob(widget.job.id);
      } else {
        SavedJobsHelper.saveJob(widget.job);
      }
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JOB DETAILS',
          style: GoogleFonts.wellfleet(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.4,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        color: Colors.deepPurple.shade50,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.job.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.job.company ?? 'Unknown Company',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          widget.job.location ?? 'Location not specified',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSaved
                            ? Colors.black12
                            : Colors.deepPurple.shade400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.white,
                      ),
                      label: Text(
                        isSaved ? 'Saved' : 'Save Job',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: toggleSave,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Job Description',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const Divider(thickness: 1.5, height: 16),
                  // This regex keeps only letters, spaces, and basic punctuation.
                  Text(
                    widget.job.description
                        .replaceAll(RegExp(r'[^a-zA-Z\s\.,!?]'), ''),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
