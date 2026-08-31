import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/security_event.dart';

class SecurityRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _securityEvents =>
      _firestore.collection('security_events');

  Future<List<SecurityEvent>> getSecurityEvents() async {
    final snapshot = await _securityEvents.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) => SecurityEvent.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<SecurityEvent>> watchSecurityEvents() {
    return _securityEvents.orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => SecurityEvent.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createSecurityEvent(SecurityEvent event) async {
    final ref = await _securityEvents.add(event.toMap());
    return ref.id;
  }

  Future<void> acknowledgeEvent(String id) async {
    await _securityEvents.doc(id).update({'severity': 'Acknowledged'});
  }
}
