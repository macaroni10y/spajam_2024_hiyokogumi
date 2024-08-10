import 'package:flutter/material.dart';
import 'package:spajam_2024_hiyokogumi/pages/friend_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController myController = TextEditingController();

  /// TODO お散歩中かどうかに使いたいけどまだ何もしてない
  bool isWalking = false;

  @override
  Widget build(BuildContext context) {
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
                        // TODO 設定画面に遷移させる
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
                    child: Image(
                        width: 230,
                        image: AssetImage(
                            'assets/images/ホーム画面/吹き出し_お散歩したいぷぅ.png')),
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
              onPressed: () {},
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
}
