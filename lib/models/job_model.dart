import 'package:hive/hive.dart';
part 'job_model.g.dart';

@HiveType(typeId: 0)
class JobModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String company;
  @HiveField(3)
  final String location;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String description;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.url,
    required this.description,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      company: json['company_name'] ?? '',
      location: json['candidate_required_location'] ?? '',
      url: json['url'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
