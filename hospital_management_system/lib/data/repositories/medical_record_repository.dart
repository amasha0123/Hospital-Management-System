import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/medical_record.dart';

class MedicalRecordRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _records =>
      _firestore.collection('medical_records');

  Future<List<MedicalRecord>> getRecords() async {
    final snapshot = await _records.orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => MedicalRecord.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<String> createRecord(MedicalRecord record) async {
    final ref = await _records.add(record.toMap());
    return ref.id;
  }

  Future<void> updateRecord(String id, Map<String, dynamic> data) async {
    await _records.doc(id).update(data);
  }
}
