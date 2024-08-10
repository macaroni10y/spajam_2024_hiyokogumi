import 'package:geolocator/geolocator.dart';

import '../models/location_history.dart';
import '../models/weather.dart';

/// 特定のユーザの全ての位置情報履歴からポイントを計算する
int calculateTotalPoints(List<LocationHistory> historyList) {
  int totalPoints = 0;
  historyList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

  for (int i = 1; i < historyList.length; i++) {
    double distance = Geolocator.distanceBetween(
      historyList[i - 1].latitude,
      historyList[i - 1].longitude,
      historyList[i].latitude,
      historyList[i].longitude,
    );

    print('distance: $distance meters');

    int points = _calculatePoints(
      historyList[i].temperature,
      historyList[i].weatherType,
      distance,
    );

    totalPoints += points;
  }
  return totalPoints;
}

/// 位置情報と天気からポイントを計算する
/// どういう条件でポイントを加算・減算するかはここで変更すればイイ
int _calculatePoints(double temperature, WeatherType weather, double distance) {
  int points = 0;

  if (weather == WeatherType.clear && temperature >= 35) {
    // 危険な状態: ポイントを減算
    points -= (distance * 0.5).toInt();
  } else if (temperature < 30 || weather != WeatherType.clear) {
    // 安全な状態: ポイントを加算
    points += (distance).toInt();
  }
  return points;
}
