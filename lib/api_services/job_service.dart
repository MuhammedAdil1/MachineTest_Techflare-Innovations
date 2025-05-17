import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';
import '../utils/constants.dart';

class JobService {

  static Future<List<JobModel>> fetchJobs() async {
    final url = Uri.parse(apiUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jobs = json.decode(response.body)['jobs'];
      return jobs.map((e) => JobModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
