import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/admission.dart';
import 'admission_provider.dart';

class AddAdmissionPage extends ConsumerStatefulWidget {
  const AddAdmissionPage({super.key});

  @override
  ConsumerState<AddAdmissionPage> createState() => _AddAdmissionPageState();
}

class _AddAdmissionPageState extends ConsumerState<AddAdmissionPage> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _wardController = TextEditingController();
  final _bedNumberController = TextEditingController();
  final _reasonController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _saving = false;

  @override
  void dispose() {
    _patientNameController.dispose();
    _doctorNameController.dispose();
    _wardController.dispose();
    _bedNumberController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(admissionRepositoryProvider);

    try {
      final admission = Admission(
        id: '',
        admissionNumber: 'ADM${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        patientId: 'P${DateTime.now().millisecondsSinceEpoch}',
        patientName: _patientNameController.text.trim(),
        doctorId: 'D${DateTime.now().millisecondsSinceEpoch}',
        doctorName: _doctorNameController.text.trim(),
        ward: _wardController.text.trim(),
        bedNumber: _bedNumberController.text.trim(),
        admissionDate: _selectedDate,
        reason: _reasonController.text.trim(),
        status: 'Admitted',
      );

      await repo.createAdmission(admission);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Admission created successfully.')),
        );
        ref.invalidate(admissionListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save admission: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Admission')),
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
                decoration: const InputDecoration(labelText: 'Attending Doctor *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter doctor name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _wardController,
                decoration: const InputDecoration(labelText: 'Ward *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter ward.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bedNumberController,
                decoration: const InputDecoration(labelText: 'Bed Number *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter bed number.' : null,
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Admission Date'),
                subtitle: Text(_selectedDate.toLocal().toString().split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _reasonController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Reason for Admission *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter reason.' : null,
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
                    : const Text('Admit Patient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
