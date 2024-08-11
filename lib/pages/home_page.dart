import 'package:flutter/material.dart';
import 'package:spajam_2024_hiyokogumi/models/location_history.dart';
import 'package:spajam_2024_hiyokogumi/pages/friend_list_page.dart';
import 'package:spajam_2024_hiyokogumi/pages/setting_page.dart';

import '../helper/location_tracking_helper.dart';
import '../models/weather.dart';
import '../repositories/location_history_repository.dart';
import '../services/firebase_auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isWalking = false;
  bool isDarkMode = false;
  late LocationTrackingHelper _locationTrackingHelper;
  late LocationHistoryRepository _locationHistoryRepository;

  @override
  void initState() {
    super.initState();
    _locationTrackingHelper = LocationTrackingHelper.instance;
    _locationHistoryRepository = LocationHistoryRepository.instance;
  }

  @override
  Widget build(BuildContext context) {
    return isWalking
        ? buildWalkingScaffold(context)
        : buildHomeScaffold(context);
  }

  /// ホーム画面のScaffoldを作成する
  /// つまり、さんぽしていないとき
  Scaffold buildHomeScaffold(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ホーム画面/背景画像.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 12.0, right: 12),
                height: 100,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // フレンドボタン
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FriendListPage()));
                      },
                      child: const Image(
                          width: 150,
                          image: AssetImage('assets/images/ホーム画面/フレンドボタン.png')),
                    ),
                    // ハンバーガーメニュー
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingPage()));
                      },
                      child: Image(
                          width: 35,
                          image: AssetImage(
                              'assets/images/ホーム画面/ハンバーガーメニューアイコン.png')),
                    ),
                  ],
                )),
            // 余白調整用
            Container(
              height: 60,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: StreamBuilder<LocationHistory?>(
                      stream: _locationHistoryRepository
                          .listenToLatestLocation(getDisplayName() ?? 'guest'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image(
                              width: 200,
                              image:
                                  _feelingsAccordingToWeather(snapshot.data!));
                        } else {
                          return Image(
                              width: 200,
                              image: AssetImage(
                                  'assets/images/ホーム画面/吹き出し_お散歩したいぷぅ.png'));
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Image(
                        width: 230,
                        image: AssetImage('assets/images/ホーム画面/ぷぅぷぅ_静止.png')),
                  ),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {
                _locationTrackingHelper.startTracking(
                    getDisplayName() ?? 'guest', 1);
                setState(() {
                  isWalking = true;
                });
              },
              child: Image(
                width: 240,
                image: AssetImage('assets/images/ホーム画面/散歩するボタン.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 最新のLocationHistoryを元にぷぅのセリフを決める
  AssetImage _feelingsAccordingToWeather(LocationHistory locationHistory) {
    if (locationHistory.temperature >= 35) {
      return AssetImage('assets/images/ホーム画面/吹き出し_お散歩したいぷぅ.png');
    } else {
      return AssetImage('assets/images/ホーム画面/吹き出し_お散歩したいぷぅ.png');
    }
  }

  /// さんぽ中の画面を作成する
  Scaffold buildWalkingScaffold(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/おさんぽ画面/背景画像.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 12.0, right: 12),
                  height: 100,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 画面を暗くするボタン
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            isDarkMode = true;
                          });
                        },
                        child: const Image(
                            width: 150,
                            image: AssetImage(
                                'assets/images/おさんぽ画面/画面を暗くするボタン.png')),
                      ),
                      // ハンバーガーメニュー
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingPage()));
                        },
                        child: Image(
                            width: 35,
                            image: AssetImage(
                                'assets/images/おさんぽ画面/ハンバーガーメニューアイコン.png')),
                      ),
                    ],
                  )),
              // 余白調整用
              Container(
                height: 172,
                child: Row(
                  children: [
                    StreamBuilder<int>(
                        stream: _locationHistoryRepository
                            .listenToTotalPoints(getDisplayName() ?? 'guest'),
                        builder: (context, snapshot) {
                          return Text(
                            'さんぽスコア: ${snapshot.data ?? 0}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          );
                        }),
                    // このようにして現在の天気を利用できる
                    StreamBuilder<LocationHistory?>(
                        stream:
                            _locationHistoryRepository.listenToLatestLocation(
                                getDisplayName() ?? 'guest'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            final location = snapshot.data;
                            return _getWeatherIcon(location!);
                          } else {
                            return const Text(
                              '位置情報取得中...',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            );
                          }
                        })
                  ],
                ),
              ),
              Center(
                child: Image(
                    width: 350,
                    image: AssetImage('assets/images/おさんぽ画面/ぷぅぷぅ.gif')),
              ),
              MaterialButton(
                onPressed: () {
                  _locationTrackingHelper.stopTracking();
                  setState(() {
                    isWalking = false;
                  });
                },
                child: Image(
                  width: 240,
                  image: AssetImage('assets/images/おさんぽ画面/散歩を終わるボタン.png'),
                ),
              ),
            ],
          ),
          if (isDarkMode)
            GestureDetector(
                onTap: () {
                  setState(() {
                    isDarkMode = false;
                  });
                },
                child: Opacity(
                    opacity: 0.5, child: Container(color: Colors.black))),
        ],
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
