import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/leave_request.dart';

class LeaveRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _leaveRequests =>
      _firestore.collection('leave_requests');

  Future<List<LeaveRequest>> getLeaveRequests() async {
    final snapshot = await _leaveRequests.orderBy('startDate', descending: true).get();
    return snapshot.docs.map((doc) => LeaveRequest.fromMap(doc.id, doc.data())).toList();
  }

  Future<String> createLeaveRequest(LeaveRequest request) async {
    final ref = await _leaveRequests.add(request.toMap());
    return ref.id;
  }

  Future<void> updateLeaveRequest(String id, Map<String, dynamic> data) async {
    await _leaveRequests.doc(id).update(data);
  }
}
