import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'department_provider.dart';

class DepartmentListPage extends ConsumerWidget {
  const DepartmentListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departmentsAsync = ref.watch(departmentListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Departments')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/departments/add'),
        child: const Icon(Icons.add),
      ),
      body: departmentsAsync.when(
        data: (departments) => departments.isEmpty
            ? const Center(child: Text('No departments found.'))
            : ListView.builder(
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  final department = departments[index];
                  return ListTile(
                    title: Text(department.name),
                    subtitle: Text('${department.departmentCode} • ${department.head}'),
                    trailing: Chip(label: Text(department.status)),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load departments.\n$error')),
      ),
    );
  }
}
