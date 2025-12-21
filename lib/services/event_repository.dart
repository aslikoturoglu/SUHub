import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_event.dart';

class EventRepository {
  EventRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('events');

  Stream<List<AppEvent>> streamEvents(String userId) {
    return _collection
        .where('createdBy', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(AppEvent.fromDoc).toList());
  }

  Future<void> addEvent(AppEvent event) async {
    final doc = _collection.doc(); // ✅ generate id
    final eventWithId = event.copyWith(id: doc.id);
    await doc.set(eventWithId.toCreateMap()); // ✅ writes id field + server time
  }

  Future<void> updateEvent(AppEvent event) async {
    await _collection.doc(event.id).update(event.toUpdateMap());
  }

  Future<void> deleteEvent(String id) async {
    await _collection.doc(id).delete();
  }
}
