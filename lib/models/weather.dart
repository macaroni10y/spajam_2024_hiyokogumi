/// 天気情報を表すモデルクラス
/// getterで使えそうな指標を提供します
/// 他に取得したい属性があれば以下を参照して追加してください
/// https://openweathermap.org/current#parameter
class Weather {
  final WeatherType type;
  final String cityName;

  /// 絶対温度
  final double temperature;
  final double windSpeed;
  final int humidity;

  Weather({
    required this.type,
    required this.cityName,
    required this.temperature,
    this.windSpeed = 0.0,
    this.humidity = 0,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      type: mapStringToWeatherType(json['weather'][0]['main']),
      cityName: json['name'],
      temperature: json['main']['temp'],
      windSpeed: json['wind']['speed'],
      humidity: json['main']['humidity'],
    );
  }

  double get temperatureCelsius => temperature - 273.15;
  double get discomfortIndex =>
      0.81 * temperatureCelsius +
      0.01 * humidity * (0.99 * temperatureCelsius - 14.3) +
      46.3;

  /// 不快指数が75以上の場合は不快と判定する
  bool get isDiscomfort => discomfortIndex >= 75.0;
}

WeatherType mapStringToWeatherType(String main) {
  return switch (main.toLowerCase()) {
    'clear' => WeatherType.clear,
    'clouds' => WeatherType.clouds,
    'rain' => WeatherType.rain,
    'drizzle' => WeatherType.drizzle,
    'thunderstorm' => WeatherType.thunderstorm,
    'snow' => WeatherType.snow,
    'mist' => WeatherType.mist,
    _ => WeatherType.unknown
  };
}

/// 天気の区分の列挙
enum WeatherType {
  clear,
  clouds,
  rain,
  drizzle,
  thunderstorm,
  snow,
  mist,
  unknown,
}
