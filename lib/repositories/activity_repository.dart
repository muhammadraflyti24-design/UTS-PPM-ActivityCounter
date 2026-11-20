// lib/repositories/activity_repository.dart

import "../data/activity_data.dart";
import "../models/activity_model.dart";

class ActivityRepository {
  final ActivityData _data = ActivityData();

  List<ActivityModel> getAll() => _data.getAll();

  void add(ActivityModel activity) => _data.add(activity);

  void updateName(String id, String newName) => _data.updateName(id, newName);

  void delete(String id) => _data.delete(id);

  void updateCounter(String id, int delta) => _data.updateCounter(id, delta);
}
