import 'dart:async';

import 'package:spajam_2024_hiyokogumi/models/weather.dart';
import 'package:spajam_2024_hiyokogumi/repositories/location_history_repository.dart';
import 'package:spajam_2024_hiyokogumi/services/weather_service.dart';

import '../models/location_history.dart';
import '../services/device_location_service.dart';

/// 位置情報の取得と保存を行うヘルパークラス
/// 位置情報に紐づいて天気の情報も取得して保存する
class LocationTrackingHelper {
  final DeviceLocationService _deviceLocationService =
      DeviceLocationService.instance;
  final LocationHistoryRepository _locationHistoryRepository =
      LocationHistoryRepository.instance;
  Timer? _timer;

  /// implement as singleton
  LocationTrackingHelper._();
  static final LocationTrackingHelper _instance = LocationTrackingHelper._();
  static LocationTrackingHelper get instance => _instance;

  /// 端末の位置情報を取得し、それを10秒ごとにデータベースに保存するという処理を開始する
  void startTracking(String userId, int intervalSeconds) {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
      print('Timer canceled before starting new timer.');
    }
    _timer = Timer.periodic(Duration(seconds: intervalSeconds), (timer) async {
      final location = await _deviceLocationService.getCurrentPosition();
      Weather weather =
          await fetchWeather(location.latitude, location.longitude);
      await _locationHistoryRepository.addLocationHistory(
        LocationHistory.create(
          userId,
          location.latitude,
          location.longitude,
          weather.type,
          weather.temperature,
          location.timestamp,
        ),
      );
    });
    print('Timer started with interval: $intervalSeconds seconds.');
  }

  /// 位置情報の取得と保存を停止する
  void stopTracking() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
      print('Timer canceled.');
    }
  }
}
