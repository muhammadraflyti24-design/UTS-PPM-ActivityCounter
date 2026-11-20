// lib/viewmodels/activity_viewmodel.dart

import "package:flutter/foundation.dart";
import "package:uuid/uuid.dart";
import "../models/activity_model.dart";
import "../repositories/activity_repository.dart";

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repository = ActivityRepository();
  final Uuid _uuid = const Uuid();

  List<ActivityModel> get activities => _repository.getAll();

  int get totalCounter => activities.fold(0, (sum, a) => sum + a.counter);

  void addActivity(String name) {
    final activity = ActivityModel(id: _uuid.v4(), name: name);
    _repository.add(activity);
    notifyListeners();
  }

  void updateName(String id, String newName) {
    _repository.updateName(id, newName);
    notifyListeners();
  }

  void deleteActivity(String id) {
    _repository.delete(id);
    notifyListeners();
  }

  void increment(String id) {
    _repository.updateCounter(id, 1);
    notifyListeners();
  }

  void decrement(String id) {
    _repository.updateCounter(id, -1);
    notifyListeners();
  }

  void resetCounter(String id) {
    final activity = activities.firstWhere((a) => a.id == id);
    final delta = -activity.counter; // bring to zero
    _repository.updateCounter(id, delta);
    notifyListeners();
  }
}
