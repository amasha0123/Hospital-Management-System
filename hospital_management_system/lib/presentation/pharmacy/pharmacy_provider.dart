import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/pharmacy_item.dart';
import '../../data/repositories/pharmacy_repository.dart';

final pharmacyRepositoryProvider = Provider<PharmacyRepository>((ref) => PharmacyRepository());

final pharmacyListProvider = FutureProvider<List<PharmacyItem>>((ref) async {
  final repo = ref.watch(pharmacyRepositoryProvider);
  return repo.getPharmacyItems();
});
