import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spajam_2024_hiyokogumi/helper/location_tracking_helper.dart';
import 'package:spajam_2024_hiyokogumi/models/weather.dart';
import 'package:spajam_2024_hiyokogumi/repositories/location_history_repository.dart';

import '../models/location_history.dart';

/// 位置情報履歴のトラッキングを行うサンプルページ
class LocationSamplePage extends StatefulWidget {
  const LocationSamplePage({super.key});

  @override
  State<LocationSamplePage> createState() => _LocationSamplePageState();
}

class _LocationSamplePageState extends State<LocationSamplePage> {
  late LocationTrackingHelper _locationTrackingHelper;
  late LocationHistoryRepository _locationHistoryRepository;

  @override
  void initState() {
    super.initState();
    _locationTrackingHelper = LocationTrackingHelper.instance;
    _locationHistoryRepository = LocationHistoryRepository.instance;
  }

  @override
  void dispose() {
    super.dispose();
    _locationTrackingHelper.stopTracking();
  }

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('LocationSample'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                child: const Text('10秒ごとに位置情報レコードを記録'),
                onPressed: () {
                  _locationTrackingHelper.startTracking(uid, 10);
                },
              ),
              MaterialButton(
                child: const Text('記録を停止'),
                onPressed: () {
                  _locationTrackingHelper.stopTracking();
                },
              ),
              MaterialButton(
                  child: const Text('履歴を全て削除'),
                  onPressed: () {
                    _locationHistoryRepository.deleteAllHistories(uid);
                  }),
              const Text('履歴一覧↓'),
              StreamBuilder<List<LocationHistory>>(
                stream: _locationHistoryRepository.listenToLocations(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<LocationHistory> locationHistoryList =
                        snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: locationHistoryList.length,
                        itemBuilder: (context, index) {
                          final LocationHistory locationHistory =
                              locationHistoryList[index];
                          return ListTile(
                            title: Text('id: ${locationHistory.id}'),
                            subtitle: Text('uid: ${locationHistory.userId}'),
                            trailing: _getWeatherIcon(locationHistory),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No data'),
                    );
                  }
                },
              ),
              // ユーザの位置情報履歴が更新されるたびに、導き出されるポイントも更新
              StreamBuilder<int>(
                stream: _locationHistoryRepository.listenToTotalPoints(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final int totalPoints = snapshot.data!;
                    return Text('Total Points: $totalPoints');
                  } else {
                    return const Text('No data');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Icon _getWeatherIcon(LocationHistory locationHistory) {
    return switch (locationHistory.weatherType) {
      WeatherType.clear => const Icon(Icons.sunny),
      WeatherType.clouds => const Icon(Icons.cloud),
      WeatherType.rain => const Icon(Icons.umbrella),
      _ => const Icon(Icons.error)
    };
  }
}
