import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/billing_record.dart';
import '../../data/repositories/billing_repository.dart';

final billingRepositoryProvider = Provider<BillingRepository>((ref) => BillingRepository());

final billingListProvider = FutureProvider<List<BillingRecord>>((ref) async {
  final repo = ref.watch(billingRepositoryProvider);
  return repo.getBillingRecords();
});
