// lib/views/activity_detail_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/activity_viewmodel.dart';

class ActivityDetailView extends StatelessWidget {
  final String activityId;
  const ActivityDetailView({required this.activityId, super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ActivityViewModel>(context);
    final activity = vm.activities.firstWhere((a) => a.id == activityId);

    void showSnack(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    Future<void> confirmReset() async {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Konfirmasi Reset'),
          content: const Text('Apakah Anda yakin ingin mengatur ulang hitungan menjadi 0?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(c).pop(false), child: const Text('Batal')),
            TextButton(onPressed: () => Navigator.of(c).pop(true), child: const Text('Ya')),
          ],
        ),
      );
      if (!context.mounted) return;
      if (confirm == true) {
        vm.resetCounter(activity.id);
        showSnack('Hitungan direset');
      }
    }

    Future<void> confirmDelete() async {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus aktivitas ini?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(c).pop(false), child: const Text('Batal')),
            TextButton(onPressed: () => Navigator.of(c).pop(true), child: const Text('Ya')),
          ],
        ),
      );
      if (!context.mounted) return;
      if (confirm == true) {
        vm.deleteActivity(activity.id);
        showSnack('Aktivitas dihapus');
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activity.name),
        backgroundColor: const Color(0xFF6D28D9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Counter pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFB794F4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                '${activity.counter}',
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
            // Increment / Decrement buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    vm.decrement(activity.id);
                    showSnack('Hitungan berkurang');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D28D9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('-'),
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: () {
                    vm.increment(activity.id);
                    showSnack('Hitungan bertambah');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D28D9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Reset button
            ElevatedButton(
              onPressed: confirmReset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Reset'),
            ),
            const SizedBox(height: 16),
            // Delete button
            ElevatedButton(
              onPressed: confirmDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Hapus'),
            ),
          ],
        ),
      ),
    );
  }
}
