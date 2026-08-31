import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment.dart';

class AppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _appointments =>
      _firestore.collection('appointments');

  Future<List<Appointment>> getAppointments() async {
    final snapshot = await _appointments.orderBy('appointmentDate').get();
    return snapshot.docs
        .map((doc) => Appointment.fromMap(doc.id, doc.data()))
        .toList();
  }

  Stream<List<Appointment>> watchAppointments() {
    return _appointments.orderBy('appointmentDate').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Appointment.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createAppointment(Appointment appointment) async {
    final ref = await _appointments.add(appointment.toMap());
    return ref.id;
  }

  Future<void> updateAppointment(String id, Map<String, dynamic> data) async {
    await _appointments.doc(id).update(data);
  }

  Future<void> cancelAppointment(String id) async {
    await _appointments.doc(id).update({'status': 'Cancelled'});
  }
}
