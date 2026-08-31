import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/billing_record.dart';

class BillingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _billing =>
      _firestore.collection('billing_records');

  Future<List<BillingRecord>> getBillingRecords() async {
    final snapshot = await _billing.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) => BillingRecord.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<BillingRecord>> watchBillingRecords() {
    return _billing.orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => BillingRecord.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createBillingRecord(BillingRecord record) async {
    final ref = await _billing.add(record.toMap());
    return ref.id;
  }

  Future<void> updateBillingRecord(String id, Map<String, dynamic> data) async {
    await _billing.doc(id).update(data);
  }

  Future<void> markAsPaid(String id) async {
    await _billing.doc(id).update({
      'status': 'Paid',
    });
  }

  Future<List<BillingRecord>> searchBillingRecords(String query) async {
    if (query.trim().isEmpty) return getBillingRecords();

    final value = query.toLowerCase();
    final snapshot = await _billing.get();
    return snapshot.docs
        .map((doc) => BillingRecord.fromMap(doc.id, doc.data()))
        .where((record) {
          final patient = record.patientName.toLowerCase();
          final doctor = record.doctorName.toLowerCase();
          final service = record.serviceName.toLowerCase();
          final invoice = record.invoiceNumber.toLowerCase();
          return patient.contains(value) ||
              doctor.contains(value) ||
              service.contains(value) ||
              invoice.contains(value) ||
              record.status.toLowerCase().contains(value);
        })
        .toList();
  }
}
