import 'package:cloud_firestore/cloud_firestore.dart';

class AuditLog {
  final String id;
  final String action;
  final String actor;
  final String entityType;
  final String entityId;
  final String details;
  final DateTime createdAt;

  const AuditLog({
    required this.id,
    required this.action,
    required this.actor,
    required this.entityType,
    required this.entityId,
    required this.details,
    required this.createdAt,
  });

  factory AuditLog.fromMap(String id, Map<String, dynamic> map) {
    return AuditLog(
      id: id,
      action: map['action'] ?? '',
      actor: map['actor'] ?? '',
      entityType: map['entityType'] ?? '',
      entityId: map['entityId'] ?? '',
      details: map['details'] ?? '',
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'action': action,
      'actor': actor,
      'entityType': entityType,
      'entityId': entityId,
      'details': details,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
