import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/audit_log.dart';

class AuditLogRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _auditLogs =>
      _firestore.collection('audit_logs');

  Future<List<AuditLog>> getAuditLogs() async {
    final snapshot = await _auditLogs.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) => AuditLog.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<AuditLog>> watchAuditLogs() {
    return _auditLogs.orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => AuditLog.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createAuditLog(AuditLog log) async {
    final ref = await _auditLogs.add(log.toMap());
    return ref.id;
  }
}
