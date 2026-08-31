import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/lab_test.dart';
import 'lab_test_provider.dart';

class AddLabTestPage extends ConsumerStatefulWidget {
  const AddLabTestPage({super.key});

  @override
  ConsumerState<AddLabTestPage> createState() => _AddLabTestPageState();
}

class _AddLabTestPageState extends ConsumerState<AddLabTestPage> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _testNameController = TextEditingController();
  final _notesController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _patientNameController.dispose();
    _doctorNameController.dispose();
    _testNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(labTestRepositoryProvider);

    try {
      final labTest = LabTest(
        id: '',
        testCode: 'LT${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        patientName: _patientNameController.text.trim(),
        doctorName: _doctorNameController.text.trim(),
        testName: _testNameController.text.trim(),
        status: 'Pending',
        notes: _notesController.text.trim(),
        requestedAt: DateTime.now(),
      );

      await repo.createLabTest(labTest);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Laboratory test request saved successfully.')),
        );
        ref.invalidate(labTestListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save request: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Lab Test')),
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
                controller: _testNameController,
                decoration: const InputDecoration(labelText: 'Test Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter test name.' : null,
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
                    : const Text('Save Request'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
