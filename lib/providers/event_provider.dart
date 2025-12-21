import 'dart:async';
import 'package:flutter/foundation.dart';

import '../models/app_event.dart';
import '../services/event_repository.dart';

class EventProvider extends ChangeNotifier {
  EventProvider(this._repository);

  final EventRepository _repository;

  StreamSubscription<List<AppEvent>>? _sub;
  List<AppEvent> events = [];
  bool loading = false;
  String? error;
  String? _userId;

  void bindUser(String? userId) {
    if (userId == _userId) return;

    _userId = userId;
    _sub?.cancel();
    events = [];
    error = null;

    if (userId == null) {
      loading = false;
      notifyListeners();
      return;
    }

    loading = true;
    notifyListeners();

    _sub = _repository.streamEvents(userId).listen(
      (data) {
        events = data;
        loading = false;
        notifyListeners();
      },
      onError: (_) {
        error = 'Could not load events.';
        loading = false;
        notifyListeners();
      },
    );
  }

  Future<void> addEvent({
    required String title,
    required String description,
    required String date,
    required String imageUrl,
  }) async {
    if (_userId == null) {
      error = 'Not authenticated';
      notifyListeners();
      return;
    }

    loading = true;
    error = null;
    notifyListeners();

    try {
      final event = AppEvent(
        id: '', // repository will generate and set the real id
        title: title,
        description: description,
        date: date,
        imageUrl: imageUrl,
        createdBy: _userId!,
        createdAt: DateTime.now(), // not used on create (serverTimestamp used)
      );
      await _repository.addEvent(event);
    } catch (_) {
      error = 'Could not add event.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> updateEvent(AppEvent event) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await _repository.updateEvent(event);
    } catch (_) {
      error = 'Could not update event.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEvent(String id) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await _repository.deleteEvent(id);
    } catch (_) {
      error = 'Could not delete event.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
