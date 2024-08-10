import 'package:spajam_2024_hiyokogumi/models/location_history.dart';

import '../services/firestore_service.dart';

class LocationHistoryRepository {
  final FirestoreService _firestoreService = FirestoreService.instance;
  static const String collectionName = 'locations';

  LocationHistoryRepository._();
  static final LocationHistoryRepository _instance =
      LocationHistoryRepository._();
  static LocationHistoryRepository get instance => _instance;

  Future<void> addLocationHistory(
    LocationHistory locationHistory,
  ) async {
    await _firestoreService.addItem(collectionName, locationHistory.toMap());
    print('Location added: ${locationHistory.timestamp}');
  }

  /// 特定のユーザの位置情報履歴一覧を取得する
  Future<List<LocationHistory>> getLocationHistories(String userId) async {
    final List<LocationHistory> allHistories = await _firestoreService
        .getAllItems(collectionName, LocationHistory.fromMap);
    return allHistories.where((element) => element.userId == userId).toList();
  }

  Stream<List<LocationHistory>> listenToLocations() => _firestoreService
      .listenToCollection(collectionName, LocationHistory.fromMap);

  /// 特定のユーザの位置情報履歴をすべて削除する
  Future<void> deleteAllHistories(String userId) async {
    final histories = await getLocationHistories(userId);
    for (final history in histories) {
      await _firestoreService.deleteItem(collectionName, history.id);
    }
  }
}
