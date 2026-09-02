import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attendance_record.dart';

class AttendanceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _attendance =>
      _firestore.collection('attendance_records');

  Future<List<AttendanceRecord>> getAttendanceRecords() async {
    final snapshot = await _attendance.orderBy('date', descending: true).get();
    return snapshot.docs
        .map((doc) => AttendanceRecord.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<String> createAttendanceRecord(AttendanceRecord record) async {
    final ref = await _attendance.add(record.toMap());
    return ref.id;
  }

  Future<void> updateAttendanceRecord(String id, Map<String, dynamic> data) async {
    await _attendance.doc(id).update(data);
  }
}
