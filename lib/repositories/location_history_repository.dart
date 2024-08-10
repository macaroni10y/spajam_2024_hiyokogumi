import 'package:spajam_2024_hiyokogumi/models/location_history.dart';

import '../helper/walking_point_calculator.dart';
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

  Stream<List<LocationHistory>> listenToLocations() {
    return _firestoreService.listenToCollection(
        collectionName, LocationHistory.fromMap);
  }

  /// 特定のユーザの最新の位置情報をstreamで取得する
  Stream<LocationHistory?> listenToLatestLocation(String userId) {
    return listenToLocations().map((locations) {
      final userLocations =
          locations.where((element) => element.userId == userId).toList();
      userLocations.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return userLocations.isNotEmpty ? userLocations.first : null;
    });
  }

  /// 特定のユーザの合計ポイントをstreamで取得する
  /// 位置情報履歴が更新されると、自動的に再計算されて通知される
  Stream<int> listenToTotalPoints(String userId) {
    return listenToLocations().map((locations) {
      final userLocations =
          locations.where((element) => element.userId == userId).toList();
      return calculateTotalPoints(userLocations);
    });
  }

  /// 特定のユーザの合計ポイントを取得する
  Future<int> getTotalPoints(String userId) async {
    final histories = await getLocationHistories(userId);
    return calculateTotalPoints(histories);
  }

  /// 特定のユーザの位置情報履歴をすべて削除する
  Future<void> deleteAllHistories(String userId) async {
    final histories = await getLocationHistories(userId);
    for (final history in histories) {
      await _firestoreService.deleteItem(collectionName, history.id);
    }
  }
}
