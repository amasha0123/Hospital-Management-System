import 'package:cloud_firestore/cloud_firestore.dart';

class PharmacyItem {
  final String id;
  final String itemCode;
  final String name;
  final String category;
  final int quantity;
  final double unitPrice;
  final int reorderLevel;
  final String supplier;
  final String status;
  final DateTime lastUpdated;

  const PharmacyItem({
    required this.id,
    required this.itemCode,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unitPrice,
    required this.reorderLevel,
    required this.supplier,
    required this.status,
    required this.lastUpdated,
  });

  bool get isLowStock => quantity <= reorderLevel;

  factory PharmacyItem.fromMap(String id, Map<String, dynamic> map) {
    return PharmacyItem(
      id: id,
      itemCode: map['itemCode'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (map['unitPrice'] as num?)?.toDouble() ?? 0.0,
      reorderLevel: (map['reorderLevel'] as num?)?.toInt() ?? 0,
      supplier: map['supplier'] ?? '',
      status: map['status'] ?? 'In Stock',
      lastUpdated: map['lastUpdated'] is Timestamp
          ? (map['lastUpdated'] as Timestamp).toDate()
          : DateTime.tryParse(map['lastUpdated']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'name': name,
      'category': category,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'reorderLevel': reorderLevel,
      'supplier': supplier,
      'status': status,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
    };
  }
}
