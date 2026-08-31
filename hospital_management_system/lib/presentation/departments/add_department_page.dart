import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/department.dart';
import 'department_provider.dart';

class AddDepartmentPage extends ConsumerStatefulWidget {
  const AddDepartmentPage({super.key});

  @override
  ConsumerState<AddDepartmentPage> createState() => _AddDepartmentPageState();
}

class _AddDepartmentPageState extends ConsumerState<AddDepartmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _headController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _headController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repo = ref.read(departmentRepositoryProvider);

    try {
      final department = Department(
        id: '',
        departmentCode: _codeController.text.trim(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        head: _headController.text.trim(),
        location: _locationController.text.trim(),
        status: 'Active',
      );

      await repo.createDepartment(department);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Department created successfully.')),
        );
        ref.invalidate(departmentListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save department: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Department')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Department Name *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter department name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Department Code *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter department code.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _headController,
                decoration: const InputDecoration(labelText: 'Head of Department *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter head name.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter location.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Description *'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter description.' : null,
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
                    : const Text('Save Department'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
