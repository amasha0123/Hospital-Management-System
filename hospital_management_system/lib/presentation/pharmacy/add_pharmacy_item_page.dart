import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/pharmacy_item.dart';
import 'pharmacy_provider.dart';

class AddPharmacyItemPage extends ConsumerStatefulWidget {
  const AddPharmacyItemPage({super.key});

  @override
  ConsumerState<AddPharmacyItemPage> createState() => _AddPharmacyItemPageState();
}

class _AddPharmacyItemPageState extends ConsumerState<AddPharmacyItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _quantityController = TextEditingController(text: '0');
  final _unitPriceController = TextEditingController(text: '0.00');
  final _reorderLevelController = TextEditingController(text: '10');
  final _supplierController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _reorderLevelController.dispose();
    _supplierController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(pharmacyRepositoryProvider);

    try {
      final item = PharmacyItem(
        id: '',
        itemCode: 'PH${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        name: _nameController.text.trim(),
        category: _categoryController.text.trim(),
        quantity: int.tryParse(_quantityController.text.trim()) ?? 0,
        unitPrice: double.tryParse(_unitPriceController.text.trim()) ?? 0.0,
        reorderLevel: int.tryParse(_reorderLevelController.text.trim()) ?? 0,
        supplier: _supplierController.text.trim(),
        status: 'In Stock',
        lastUpdated: DateTime.now(),
      );

      await repo.createPharmacyItem(item);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pharmacy item saved successfully.')),
        );
        ref.invalidate(pharmacyListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save item: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Pharmacy Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Medicine Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter medicine name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter category.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity *'),
                keyboardType: TextInputType.number,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter quantity.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _unitPriceController,
                decoration: const InputDecoration(labelText: 'Unit Price *'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter unit price.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _reorderLevelController,
                decoration: const InputDecoration(labelText: 'Reorder Level *'),
                keyboardType: TextInputType.number,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter reorder level.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _supplierController,
                decoration: const InputDecoration(labelText: 'Supplier *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter supplier.' : null,
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
                    : const Text('Save Item'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
