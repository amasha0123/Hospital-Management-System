import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/patient.dart';
import 'patient_provider.dart';

class PatientListPage extends ConsumerStatefulWidget {
  const PatientListPage({super.key});

  @override
  ConsumerState<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends ConsumerState<PatientListPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(patientListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Registry'),
        actions: [
          IconButton(
            onPressed: () => context.push('/patients/add'),
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/patients/add'),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Add'),
      ),
      body: patientsAsync.when(
        data: (patients) {
          final query = _searchController.text.trim().toLowerCase();
          final filteredPatients = query.isEmpty
              ? patients
              : patients.where((patient) {
                  final fullName = '${patient.firstName} ${patient.lastName}'.toLowerCase();
                  return patient.patientNumber.toLowerCase().contains(query) ||
                      fullName.contains(query) ||
                      patient.email.toLowerCase().contains(query) ||
                      patient.phone.toLowerCase().contains(query);
                }).toList();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1D4ED8), Color(0xFF0EA5E9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.groups_rounded, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Patient Records',
                                style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 1.2),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${patients.length} total patients',
                                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search patient by ID, name, phone or email',
                      prefixIcon: const Icon(Icons.search_rounded),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: filteredPatients.isEmpty
                        ? const Center(
                            child: Text(
                              'No patients found.',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          )
                        : ListView.separated(
                            itemCount: filteredPatients.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final patient = filteredPatients[index];
                              return InkWell(
                                onTap: () => _openPatient(context, patient),
                                borderRadius: BorderRadius.circular(18),
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.04),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: const Color(0xFFE0F2FE),
                                        child: Text(
                                          patient.firstName.isNotEmpty ? patient.firstName[0].toUpperCase() : 'P',
                                          style: const TextStyle(
                                            color: Color(0xFF0F172A),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${patient.firstName} ${patient.lastName}',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF0F172A),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${patient.patientNumber} • ${patient.phone}',
                                              style: const TextStyle(color: Colors.black54, fontSize: 12),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              patient.email.isNotEmpty ? patient.email : 'No email provided',
                                              style: const TextStyle(color: Color(0xFF475569), fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Chip(
                                            label: Text(
                                              patient.isActive ? 'Active' : 'Inactive',
                                              style: const TextStyle(fontSize: 11),
                                            ),
                                            backgroundColor: patient.isActive
                                                ? const Color(0xFFDCFCE7)
                                                : const Color(0xFFFEF2F2),
                                            side: BorderSide.none,
                                          ),
                                          const SizedBox(height: 8),
                                          TextButton.icon(
                                            onPressed: () => _openHistory(context, patient),
                                            icon: const Icon(Icons.history_rounded, size: 16),
                                            label: const Text('View History'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Unable to load patients.\n$error')),
      ),
    );
  }

  void _openPatient(BuildContext context, Patient patient) {
    context.push('/patients/details', extra: patient);
  }

  void _openHistory(BuildContext context, Patient patient) {
    context.push('/patients/details', extra: patient);
  }
}
