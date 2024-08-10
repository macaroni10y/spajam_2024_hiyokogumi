import 'package:flutter/material.dart';
import 'package:spajam_2024_hiyokogumi/services/firebase_auth_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/設定画面/背景画像.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Stack(children: [
                  const Image(
                      image: AssetImage('assets/images/設定画面/設定ヘッダ.png')),
                  Positioned(
                    left: 20,
                    top: 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                                    'assets/images/設定画面/ユーザIDラベル_テキストボックス.png')),
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
                          if (_controller.text.isEmpty) return;
                          updateDisplayName(_controller.text);
                          FocusScope.of(context).unfocus();
                          // キーボードが閉じてからじゃないとホーム画面の要素がオーバーフローするので応急処置
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Image(
                            height: 80,
                            image: AssetImage('assets/images/設定画面/OKボタン.png')),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
