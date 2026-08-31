import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/department.dart';

class DepartmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _departments =>
      _firestore.collection('departments');

  Future<List<Department>> getDepartments() async {
    final snapshot = await _departments.orderBy('name').get();
    return snapshot.docs.map((doc) => Department.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<Department>> watchDepartments() {
    return _departments.orderBy('name').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Department.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createDepartment(Department department) async {
    final ref = await _departments.add(department.toMap());
    return ref.id;
  }

  Future<void> updateDepartment(String id, Map<String, dynamic> data) async {
    await _departments.doc(id).update(data);
  }

  Future<void> archiveDepartment(String id) async {
    await _departments.doc(id).update({'status': 'Inactive'});
  }

  Future<List<Department>> searchDepartments(String query) async {
    if (query.trim().isEmpty) return getDepartments();

    final value = query.toLowerCase();
    final snapshot = await _departments.get();
    return snapshot.docs
        .map((doc) => Department.fromMap(doc.id, doc.data()))
        .where((department) {
          return department.name.toLowerCase().contains(value) ||
              department.departmentCode.toLowerCase().contains(value) ||
              department.head.toLowerCase().contains(value) ||
              department.location.toLowerCase().contains(value);
        })
        .toList();
  }
}
