import 'package:hive/hive.dart';
import '../models/job_model.dart';

class SavedJobsHelper {
  static const String boxName = 'savedJobs';

  static Future<void> saveJob(JobModel job) async {
    final box = Hive.box<JobModel>(boxName);
    box.put(job.id, job);
  }

  static Future<void> removeJob(String id) async {
    final box = Hive.box<JobModel>(boxName);
    box.delete(id);
  }

  static List<JobModel> getSavedJobs() {
    final box = Hive.box<JobModel>(boxName);
    return box.values.toList();
  }

  static bool isJobSaved(String id) {
    final box = Hive.box<JobModel>(boxName);
    return box.containsKey(id);
  }
}
