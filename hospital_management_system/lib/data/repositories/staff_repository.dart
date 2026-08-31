import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/staff_member.dart';

class StaffRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _staff =>
      _firestore.collection('staff');

  Future<List<StaffMember>> getStaffMembers() async {
    final snapshot = await _staff.orderBy('firstName').get();
    return snapshot.docs.map((doc) => StaffMember.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<StaffMember>> watchStaffMembers() {
    return _staff.orderBy('firstName').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => StaffMember.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createStaffMember(StaffMember member) async {
    final ref = await _staff.add(member.toMap());
    return ref.id;
  }

  Future<void> updateStaffMember(String id, Map<String, dynamic> data) async {
    await _staff.doc(id).update(data);
  }

  Future<void> deactivateStaffMember(String id) async {
    await _staff.doc(id).update({'isActive': false});
  }

  Future<List<StaffMember>> searchStaffMembers(String query) async {
    if (query.trim().isEmpty) return getStaffMembers();

    final value = query.toLowerCase();
    final snapshot = await _staff.get();
    return snapshot.docs
        .map((doc) => StaffMember.fromMap(doc.id, doc.data()))
        .where((member) {
          final fullName = '${member.firstName} ${member.lastName}'.toLowerCase();
          return member.employeeNumber.toLowerCase().contains(value) ||
              fullName.contains(value) ||
              member.role.toLowerCase().contains(value) ||
              member.department.toLowerCase().contains(value) ||
              member.email.toLowerCase().contains(value);
        })
        .toList();
  }
}
