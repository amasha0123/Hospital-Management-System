import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/admission.dart';

class AdmissionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _admissions =>
      _firestore.collection('admissions');

  Future<List<Admission>> getAdmissions() async {
    final snapshot = await _admissions.orderBy('admissionDate', descending: true).get();
    return snapshot.docs.map((doc) => Admission.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<Admission>> watchAdmissions() {
    return _admissions.orderBy('admissionDate', descending: true).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Admission.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createAdmission(Admission admission) async {
    final ref = await _admissions.add(admission.toMap());
    return ref.id;
  }

  Future<void> updateAdmission(String id, Map<String, dynamic> data) async {
    await _admissions.doc(id).update(data);
  }

  Future<void> dischargeAdmission(String id) async {
    await _admissions.doc(id).update({'status': 'Discharged'});
  }

  Future<List<Admission>> searchAdmissions(String query) async {
    if (query.trim().isEmpty) return getAdmissions();

    final value = query.toLowerCase();
    final snapshot = await _admissions.get();
    return snapshot.docs
        .map((doc) => Admission.fromMap(doc.id, doc.data()))
        .where((admission) {
          return admission.admissionNumber.toLowerCase().contains(value) ||
              admission.patientName.toLowerCase().contains(value) ||
              admission.doctorName.toLowerCase().contains(value) ||
              admission.ward.toLowerCase().contains(value) ||
              admission.status.toLowerCase().contains(value);
        })
        .toList();
  }
}
