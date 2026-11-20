// lib/views/activity_form_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/activity_viewmodel.dart';
import '../models/activity_model.dart';

class ActivityFormView extends StatefulWidget {
  final ActivityModel? editActivity;
  const ActivityFormView({this.editActivity, super.key});

  @override
  State<ActivityFormView> createState() => _ActivityFormViewState();
}

class _ActivityFormViewState extends State<ActivityFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.editActivity?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final vm = Provider.of<ActivityViewModel>(context, listen: false);
      final name = _nameController.text.trim();
      if (widget.editActivity != null) {
        vm.updateName(widget.editActivity!.id, name);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aktivitas berhasil diperbarui')),
        );
      } else {
        vm.addActivity(name);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aktivitas baru berhasil ditambahkan')),
        );
      }
      if (!context.mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.editActivity != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Ubah Aktivitas' : 'Tambah Aktivitas'),
        backgroundColor: const Color(0xFF6D28D9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Aktivitas',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D28D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
