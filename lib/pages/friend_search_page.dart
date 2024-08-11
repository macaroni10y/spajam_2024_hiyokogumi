import 'package:flutter/material.dart';

class FriendSearchPage extends StatefulWidget {
  @override
  State<FriendSearchPage> createState() => _FriendSearchPageState();
}

class _FriendSearchPageState extends State<FriendSearchPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/フレンド登録画面/背景画像.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Stack(children: [
                  const Image(
                      image: AssetImage('assets/images/フレンド登録画面/ユーザ登録ヘッダ.png')),
                  Positioned(
                    left: 20,
                    top: 5,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ]),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          children: [
                            Image(
                                height: 80,
                                image: AssetImage(
                                    'assets/images/フレンド登録画面/ユーザIDラベル_テキストボックス.png')),
                            Positioned(
                              top: 30,
                              left: 10,
                              right: 10,
                              child: TextField(
                                controller: _controller,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          // キーボードが閉じてからじゃないとホーム画面の要素がオーバーフローするので応急処置
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Image(
                            height: 80,
                            image:
                                AssetImage('assets/images/フレンド登録画面/OKボタン.png')),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
