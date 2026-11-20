// lib/data/activity_data.dart

import "../models/activity_model.dart";

class ActivityData {
  final List<ActivityModel> _activities = [
    ActivityModel(id: "1", name: "Shalat Sunnah Dhuha (Rakaat)", counter: 4),
    ActivityModel(id: "2", name: "Tilawah Al-Quran (Halaman)", counter: 5),
    ActivityModel(id: "3", name: "Dzikir Pagi & Petang", counter: 2),
  ];

  List<ActivityModel> getAll() => List.unmodifiable(_activities);

  void add(ActivityModel activity) => _activities.add(activity);

  void updateName(String id, String newName) {
    final index = _activities.indexWhere((a) => a.id == id);
    if (index != -1) {
      _activities[index].name = newName;
    }
  }

  void delete(String id) => _activities.removeWhere((a) => a.id == id);

  void updateCounter(String id, int delta) {
    final activity = _activities.firstWhere((a) => a.id == id, orElse: () => throw Exception('Activity not found'));
    final newCounter = activity.counter + delta;
    if (newCounter >= 0) {
      activity.counter = newCounter;
    }
  }
}
