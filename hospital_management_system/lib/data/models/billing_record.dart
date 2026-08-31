import 'package:cloud_firestore/cloud_firestore.dart';

class BillingRecord {
  final String id;
  final String invoiceNumber;
  final String patientName;
  final String doctorName;
  final String serviceName;
  final double amount;
  final String status;
  final DateTime createdAt;

  const BillingRecord({
    required this.id,
    required this.invoiceNumber,
    required this.patientName,
    required this.doctorName,
    required this.serviceName,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  factory BillingRecord.fromMap(String id, Map<String, dynamic> map) {
    return BillingRecord(
      id: id,
      invoiceNumber: map['invoiceNumber'] ?? '',
      patientName: map['patientName'] ?? '',
      doctorName: map['doctorName'] ?? '',
      serviceName: map['serviceName'] ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] ?? 'Pending',
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoiceNumber': invoiceNumber,
      'patientName': patientName,
      'doctorName': doctorName,
      'serviceName': serviceName,
      'amount': amount,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
