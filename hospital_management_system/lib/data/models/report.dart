import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final String reportCode;
  final String title;
  final String category;
  final String generatedBy;
  final String summary;
  final DateTime generatedAt;
  final String status;

  const Report({
    required this.id,
    required this.reportCode,
    required this.title,
    required this.category,
    required this.generatedBy,
    required this.summary,
    required this.generatedAt,
    required this.status,
  });

  factory Report.fromMap(String id, Map<String, dynamic> map) {
    return Report(
      id: id,
      reportCode: map['reportCode'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      generatedBy: map['generatedBy'] ?? '',
      summary: map['summary'] ?? '',
      generatedAt: map['generatedAt'] is Timestamp
          ? (map['generatedAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['generatedAt']?.toString() ?? '') ?? DateTime.now(),
      status: map['status'] ?? 'Ready',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reportCode': reportCode,
      'title': title,
      'category': category,
      'generatedBy': generatedBy,
      'summary': summary,
      'generatedAt': Timestamp.fromDate(generatedAt),
      'status': status,
    };
  }
}
