import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:spajam_2024_hiyokogumi/helper/location_tracking_helper.dart';
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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('LocationSample'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              CupertinoButton(
                child: const Text('10秒ごとに位置情報レコードを記録'),
                onPressed: () {
                  _locationTrackingHelper.startTracking(uid, 10);
                },
              ),
              CupertinoButton(
                child: const Text('記録を停止'),
                onPressed: () {
                  _locationTrackingHelper.stopTracking();
                },
              ),
              CupertinoButton(
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
                          return CupertinoListTile(
                            title: Text('id: ${locationHistory.id}'),
                            subtitle: Text('uid: ${locationHistory.userId}'),
                            trailing: Text(
                                'lat: ${locationHistory.latitude}, lon: ${locationHistory.longitude}'),
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
            ],
          ),
        ),
      ),
    );
  }
}
