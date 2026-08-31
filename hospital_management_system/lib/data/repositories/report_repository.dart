import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/report.dart';

class ReportRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _reports =>
      _firestore.collection('reports');

  Future<List<Report>> getReports() async {
    final snapshot = await _reports.orderBy('generatedAt', descending: true).get();
    return snapshot.docs.map((doc) => Report.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<Report>> watchReports() {
    return _reports.orderBy('generatedAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Report.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createReport(Report report) async {
    final ref = await _reports.add(report.toMap());
    return ref.id;
  }

  Future<void> updateReport(String id, Map<String, dynamic> data) async {
    await _reports.doc(id).update(data);
  }

  Future<void> archiveReport(String id) async {
    await _reports.doc(id).update({'status': 'Archived'});
  }

  Future<List<Report>> searchReports(String query) async {
    if (query.trim().isEmpty) return getReports();

    final value = query.toLowerCase();
    final snapshot = await _reports.get();
    return snapshot.docs
        .map((doc) => Report.fromMap(doc.id, doc.data()))
        .where((report) {
          final title = report.title.toLowerCase();
          final category = report.category.toLowerCase();
          final generatedBy = report.generatedBy.toLowerCase();
          final summary = report.summary.toLowerCase();
          return title.contains(value) ||
              category.contains(value) ||
              generatedBy.contains(value) ||
              summary.contains(value) ||
              report.status.toLowerCase().contains(value);
        })
        .toList();
  }
}
