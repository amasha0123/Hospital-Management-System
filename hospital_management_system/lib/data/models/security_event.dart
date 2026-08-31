import 'package:cloud_firestore/cloud_firestore.dart';

class SecurityEvent {
  final String id;
  final String eventType;
  final String actor;
  final String location;
  final String description;
  final String severity;
  final DateTime createdAt;

  const SecurityEvent({
    required this.id,
    required this.eventType,
    required this.actor,
    required this.location,
    required this.description,
    required this.severity,
    required this.createdAt,
  });

  factory SecurityEvent.fromMap(String id, Map<String, dynamic> map) {
    return SecurityEvent(
      id: id,
      eventType: map['eventType'] ?? '',
      actor: map['actor'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      severity: map['severity'] ?? 'Medium',
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventType': eventType,
      'actor': actor,
      'location': location,
      'description': description,
      'severity': severity,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
