import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

/// OpenWeatherMap APIを使用して天気情報を取得する関数
/// serviceって言っちゃったけどクラスにはしないで単独の関数として定義している
Future<Weather> fetchWeather(double lat, double lon) async {
  final apiKey = '__already_revoked__';
  final url =
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey';

  final response = await http.get(Uri.parse(url));
  print('fetchWeather called');
  print(response.body);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return Weather.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load weather');
  }
}

/// モックの天気情報を返す関数
/// デモで好きな値が欲しいときとかに使いますか
Future<Weather> fetchWeatherMock(double lat, double lon) async {
  print('fetchWeatherMock called');
  return Weather(
    type: _mockWeatherType(),
    cityName: 'Kyoto',
    temperature: _mockTemperature(),
  );
}

double _mockTemperature() {
  // 32から34の間でランダムな値を返す。小数点1桁まで
  return (32 + (2 * (DateTime.now().second % 100) / 100)).toDouble();
}

WeatherType _mockWeatherType() {
  // 0から6の間でランダムな値を返す
  return WeatherType.values[DateTime.now().second % 2];
}
