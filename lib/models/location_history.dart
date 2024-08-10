import 'package:cloud_firestore/cloud_firestore.dart';

/// 位置情報の履歴を表すモデル
class LocationHistory {
  final String id;
  final String userId;
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  LocationHistory(
      {required this.id,
      required this.userId,
      required this.latitude,
      required this.longitude,
      required this.timestamp});

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': Timestamp.fromDate(timestamp),
      };

  factory LocationHistory.fromMap(Map<String, dynamic> data, String id) =>
      LocationHistory(
          id: id,
          userId: data['userId'] ?? '',
          latitude: data['latitude'] ?? 0.0,
          longitude: data['longitude'] ?? 0.0,
          timestamp: data['timestamp'].toDate());

  /// 未登録の位置情報履歴を作成するため、idを指定せずに生成されることが期待される
  factory LocationHistory.create(String userId, double latitude,
          double longitude, DateTime timestamp) =>
      LocationHistory(
        id: '',
        userId: userId,
        latitude: latitude,
        longitude: longitude,
        timestamp: timestamp,
      );
}
