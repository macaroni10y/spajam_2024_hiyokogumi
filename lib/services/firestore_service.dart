import 'package:cloud_firestore/cloud_firestore.dart';

/// firestoreへのCRUDを提供する
/// Mapとモデルの変換を担う
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// implement as singleton
  FirestoreService._();
  static final FirestoreService _instance = FirestoreService._();
  static FirestoreService get instance => _instance;

  Future<T?> getItem<T>(String collection, String id,
      T Function(Map<String, dynamic>, String) fromMap) async {
    final doc = await _db.collection(collection).doc(id).get();
    return doc.exists && doc.data() != null
        ? fromMap(doc.data()!, doc.id)
        : null;
  }

  /// コレクション内のすべてのドキュメントを取得する
  Future<List<T>> getAllItems<T>(String collection,
      T Function(Map<String, dynamic>, String) fromMap) async {
    final snapshot = await _db.collection(collection).get();
    return snapshot.docs.map((doc) => fromMap(doc.data(), doc.id)).toList();
  }

  Future<DocumentReference<Map<String, dynamic>>> addItem(
      String collection, Map<String, dynamic> data) {
    return _db.collection(collection).add(data);
  }

  Future<void> updateItem(
      String collection, String id, Map<String, dynamic> data) {
    return _db.collection(collection).doc(id).update(data);
  }

  Future<void> deleteItem(String collection, String id) {
    return _db.collection(collection).doc(id).delete();
  }

  Future<void> deleteAllItems(String collection) async {
    final snapshot = await _db.collection(collection).get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Stream<List<T>> listenToCollection<T>(
      String collection, T Function(Map<String, dynamic>, String) fromMap) {
    return _db.collection(collection).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => fromMap(doc.data(), doc.id)).toList());
  }
}
