import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor.dart';

class DoctorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _doctors =>
      _firestore.collection('doctors');

  Future<List<Doctor>> getDoctors() async {
    final snapshot = await _doctors.orderBy('firstName').get();
    return snapshot.docs.map((doc) => Doctor.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<Doctor>> watchDoctors() {
    return _doctors.orderBy('firstName').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Doctor.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createDoctor(Doctor doctor) async {
    final ref = await _doctors.add(doctor.toMap());
    return ref.id;
  }

  Future<void> updateDoctor(String id, Map<String, dynamic> data) async {
    await _doctors.doc(id).update(data);
  }

  Future<void> deactivateDoctor(String id) async {
    await _doctors.doc(id).update({'isActive': false});
  }

  Future<List<Doctor>> searchDoctors(String query) async {
    if (query.trim().isEmpty) return getDoctors();

    final value = query.toLowerCase();
    final snapshot = await _doctors.get();
    return snapshot.docs
        .map((doc) => Doctor.fromMap(doc.id, doc.data()))
        .where((doctor) {
          final fullName = '${doctor.firstName} ${doctor.lastName}'.toLowerCase();
          return doctor.doctorNumber.toLowerCase().contains(value) ||
              fullName.contains(value) ||
              doctor.specialty.toLowerCase().contains(value) ||
              doctor.department.toLowerCase().contains(value) ||
              doctor.email.toLowerCase().contains(value);
        })
        .toList();
  }
}
