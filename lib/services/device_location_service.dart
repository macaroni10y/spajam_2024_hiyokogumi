import 'package:geolocator/geolocator.dart';

/// 端末の位置情報にアクセスするサービス
class DeviceLocationService {
  /// implement as singleton
  DeviceLocationService._();
  static final DeviceLocationService _instance = DeviceLocationService._();
  static DeviceLocationService get instance => _instance;

  void _getPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  /// 現在の端末の位置情報を取得する
  Future<Position> getCurrentPosition() async {
    _getPermission();
    return await Geolocator.getCurrentPosition();
  }

  /// streamとして端末の位置情報を取得する
  Stream<Position> listenToPosition() {
    _getPermission();
    return Geolocator.getPositionStream();
  }
}
