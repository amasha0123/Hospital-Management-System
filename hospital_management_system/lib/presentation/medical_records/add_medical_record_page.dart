import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/medical_record.dart';
import '../../data/repositories/medical_record_repository.dart';
import 'medical_record_provider.dart';

class AddMedicalRecordPage extends ConsumerStatefulWidget {
  const AddMedicalRecordPage({super.key});

  @override
  ConsumerState<AddMedicalRecordPage> createState() => _AddMedicalRecordPageState();
}

class _AddMedicalRecordPageState extends ConsumerState<AddMedicalRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _treatmentController = TextEditingController();
  final _notesController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _patientNameController.dispose();
    _doctorNameController.dispose();
    _diagnosisController.dispose();
    _treatmentController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(medicalRecordRepositoryProvider);

    try {
      final record = MedicalRecord(
        id: '',
        recordNumber: 'MR${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        patientId: 'P${DateTime.now().millisecondsSinceEpoch}',
        patientName: _patientNameController.text.trim(),
        doctorId: 'D${DateTime.now().millisecondsSinceEpoch}',
        doctorName: _doctorNameController.text.trim(),
        diagnosis: _diagnosisController.text.trim(),
        treatment: _treatmentController.text.trim(),
        notes: _notesController.text.trim(),
        createdAt: DateTime.now(),
      );

      await repo.createRecord(record);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Medical record saved successfully.')),
        );
        ref.invalidate(medicalRecordListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save record: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Medical Record')),
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
                controller: _diagnosisController,
                decoration: const InputDecoration(labelText: 'Diagnosis *'),
                minLines: 2,
                maxLines: 3,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter diagnosis.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _treatmentController,
                decoration: const InputDecoration(labelText: 'Treatment *'),
                minLines: 2,
                maxLines: 3,
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter treatment.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
                minLines: 2,
                maxLines: 4,
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
                    : const Text('Save Record'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
