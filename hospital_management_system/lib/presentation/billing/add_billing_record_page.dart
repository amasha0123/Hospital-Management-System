import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/billing_record.dart';
import 'billing_provider.dart';

class AddBillingRecordPage extends ConsumerStatefulWidget {
  const AddBillingRecordPage({super.key});

  @override
  ConsumerState<AddBillingRecordPage> createState() => _AddBillingRecordPageState();
}

class _AddBillingRecordPageState extends ConsumerState<AddBillingRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _serviceNameController = TextEditingController();
  final _amountController = TextEditingController(text: '0.00');
  bool _saving = false;

  @override
  void dispose() {
    _patientNameController.dispose();
    _doctorNameController.dispose();
    _serviceNameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(billingRepositoryProvider);

    try {
      final record = BillingRecord(
        id: '',
        invoiceNumber: 'INV${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        patientName: _patientNameController.text.trim(),
        doctorName: _doctorNameController.text.trim(),
        serviceName: _serviceNameController.text.trim(),
        amount: double.tryParse(_amountController.text.trim()) ?? 0.0,
        status: 'Pending',
        createdAt: DateTime.now(),
      );

      await repo.createBillingRecord(record);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Billing record saved successfully.')),
        );
        ref.invalidate(billingListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save billing record: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Billing Record')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _patientNameController,
                decoration: const InputDecoration(labelText: 'Patient Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter patient name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _doctorNameController,
                decoration: const InputDecoration(labelText: 'Doctor Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter doctor name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _serviceNameController,
                decoration: const InputDecoration(labelText: 'Service Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter service name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Amount *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter amount.' : null,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Generate Bill'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
