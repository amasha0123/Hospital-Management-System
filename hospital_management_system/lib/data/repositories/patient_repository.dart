import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient.dart';

class PatientRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _patients =>
      _firestore.collection('patients');

  Future<List<Patient>> getPatients() async {
    final snapshot = await _patients.orderBy('firstName').get();
    return snapshot.docs.map((doc) => Patient.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<Patient>> watchPatients() {
    return _patients.orderBy('firstName').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Patient.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> addPatient(Patient patient) async {
    final doc = await _patients.add(patient.toMap());
    return doc.id;
  }

  Future<String> createPatient(Patient patient) async {
    final doc = await _patients.add(patient.toMap());
    return doc.id;
  }

  Future<void> updatePatient(String id, Map<String, dynamic> data) async {
    await _patients.doc(id).update(data);
  }

  Future<void> deactivatePatient(String id) async {
    await _patients.doc(id).update({'isActive': false});
  }

  Future<List<Patient>> searchPatients(String query) async {
    if (query.trim().isEmpty) return getPatients();

    final value = query.toLowerCase();
    final snapshot = await _patients.get();
    final results = snapshot.docs
        .map((doc) => Patient.fromMap(doc.id, doc.data()))
        .where((patient) {
          final fullName = '${patient.firstName} ${patient.lastName}'.toLowerCase();
          return patient.patientNumber.toLowerCase().contains(value) ||
              fullName.contains(value) ||
              patient.email.toLowerCase().contains(value) ||
              patient.phone.toLowerCase().contains(value);
        })
        .toList();
    return results;
  }
}
