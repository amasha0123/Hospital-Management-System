import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pharmacy_item.dart';

class PharmacyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _pharmacyItems =>
      _firestore.collection('pharmacy_items');

  Future<List<PharmacyItem>> getPharmacyItems() async {
    final snapshot = await _pharmacyItems.orderBy('name').get();
    return snapshot.docs.map((doc) => PharmacyItem.fromMap(doc.id, doc.data())).toList();
  }

  Stream<List<PharmacyItem>> watchPharmacyItems() {
    return _pharmacyItems.orderBy('name').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => PharmacyItem.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<String> createPharmacyItem(PharmacyItem item) async {
    final ref = await _pharmacyItems.add(item.toMap());
    return ref.id;
  }

  Future<void> updatePharmacyItem(String id, Map<String, dynamic> data) async {
    await _pharmacyItems.doc(id).update(data);
  }

  Future<void> updateStock(String id, int newQuantity) async {
    await _pharmacyItems.doc(id).update({
      'quantity': newQuantity,
      'status': newQuantity <= 0 ? 'Out of Stock' : (newQuantity <= 10 ? 'Low Stock' : 'In Stock'),
      'lastUpdated': Timestamp.now(),
    });
  }

  Future<List<PharmacyItem>> searchPharmacyItems(String query) async {
    if (query.trim().isEmpty) return getPharmacyItems();

    final value = query.toLowerCase();
    final snapshot = await _pharmacyItems.get();
    return snapshot.docs
        .map((doc) => PharmacyItem.fromMap(doc.id, doc.data()))
        .where((item) {
          final name = item.name.toLowerCase();
          final category = item.category.toLowerCase();
          final supplier = item.supplier.toLowerCase();
          final code = item.itemCode.toLowerCase();
          return name.contains(value) ||
              category.contains(value) ||
              supplier.contains(value) ||
              code.contains(value) ||
              item.status.toLowerCase().contains(value);
        })
        .toList();
  }
}
