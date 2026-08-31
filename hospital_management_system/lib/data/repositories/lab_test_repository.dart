import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/lab_test.dart';

class LabTestRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _labTests =>
      _firestore.collection('lab_tests');

  Future<List<LabTest>> getLabTests() async {
    final snapshot = await _labTests.orderBy('requestedAt', descending: true).get();
    return snapshot.docs.map((doc) => LabTest.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<LabTest>> watchLabTests() {
    return _labTests.orderBy('requestedAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => LabTest.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createLabTest(LabTest labTest) async {
    final ref = await _labTests.add(labTest.toMap());
    return ref.id;
  }

  Future<void> updateLabTest(String id, Map<String, dynamic> data) async {
    await _labTests.doc(id).update(data);
  }

  Future<void> completeLabTest(String id) async {
    await _labTests.doc(id).update({
      'status': 'Completed',
      'isCompleted': true,
    });
  }

  Future<List<LabTest>> searchLabTests(String query) async {
    if (query.trim().isEmpty) return getLabTests();

    final value = query.toLowerCase();
    final snapshot = await _labTests.get();
    return snapshot.docs
        .map((doc) => LabTest.fromMap(doc.id, doc.data()))
        .where((labTest) {
          final patient = labTest.patientName.toLowerCase();
          final doctor = labTest.doctorName.toLowerCase();
          final testName = labTest.testName.toLowerCase();
          final code = labTest.testCode.toLowerCase();
          return patient.contains(value) ||
              doctor.contains(value) ||
              testName.contains(value) ||
              code.contains(value) ||
              labTest.status.toLowerCase().contains(value);
        })
        .toList();
  }
}
