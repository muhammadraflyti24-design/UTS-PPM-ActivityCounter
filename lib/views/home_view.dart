// lib/views/home_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/activity_viewmodel.dart';
import '../models/activity_model.dart';
import 'activity_form_view.dart';
import 'activity_detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ActivityViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ibadah Counter'),
        backgroundColor: const Color(0xFF6D28D9),
      ),
      body: Column(
        children: [
          // Banner total counter
          Container(
            width: double.infinity,
            color: const Color(0xFF6D28D9),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                'Total Hitungan: ${vm.totalCounter}',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Grid list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.9,
                ),
                itemCount: vm.activities.length,
                itemBuilder: (context, index) {
                  final activity = vm.activities[index];
                  return _ActivityCard(activity: activity);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // navigate to form for adding new activity
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ActivityFormView()),
          );
        },
        label: const Text('Tambah Ibadah'),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xFF6D28D9),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  const _ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ActivityDetailView(activityId: activity.id),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.deepPurple),
                  onPressed: () async {
                    // open form pre‑filled for edit
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ActivityFormView(editActivity: activity),
                    ));
                  },
                ),
              ),
              const Icon(Icons.auto_awesome, size: 40, color: Colors.deepPurple),
              Text(
                activity.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${activity.counter}',
                style: const TextStyle(fontSize: 28, color: Colors.deepPurple, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
