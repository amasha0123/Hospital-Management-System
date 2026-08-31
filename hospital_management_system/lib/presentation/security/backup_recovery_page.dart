import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackupRecoveryPage extends ConsumerWidget {
  const BackupRecoveryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupItems = [
      _BackupItem(title: 'Daily automatic backup', detail: 'Runs every 24 hours'),
      _BackupItem(title: 'Weekly full backup', detail: 'Stored in encrypted cloud storage'),
      _BackupItem(title: 'Disaster recovery plan', detail: 'Restores operational data within SLA'),
      _BackupItem(title: 'Audit trail retention', detail: 'Locked and immutable for compliance'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Recovery')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('System Recovery Policy', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Text(
                      'The HMS keeps encrypted daily backups, weekly full snapshots, and a documented recovery process to restore patient, billing, pharmacy, and clinical data with minimal downtime.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...backupItems.map(
              (item) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.backup_rounded, color: Colors.green),
                  title: Text(item.title),
                  subtitle: Text(item.detail),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackupItem {
  final String title;
  final String detail;

  const _BackupItem({required this.title, required this.detail});
}
