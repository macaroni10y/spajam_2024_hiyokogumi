import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          // 背景画像
          Positioned.fill(
            child: Image.asset(
              'assets/images/フレンド登録画面/背景画像.png', // 背景画像のパス
              fit: BoxFit.cover,
            ),
          ),
          // カスタムナビゲーションバー
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 64, // ナビゲーションバーの高さ
            child: Stack(
              children: [
                // ヘッダー画像
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/フレンド登録画面/ユーザ登録ヘッダ.png', // ヘッダー画像のパス
                    fit: BoxFit.fill,
                  ),
                ),
                // 見えない戻るボタン
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: 50, // ボタンの幅を指定
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.transparent, // 見えないボタン
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 画面の他のコンテンツ
          Positioned.fill(
            top: 170, // ナビゲーションバーの下から始まるように調整
            child: Column(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 120),
                      Stack(
                        children: [
                          Positioned.fill(
                              left: 80,
                              right: 80,
                              child: Image.asset('assets/images/フレンド登録画面/ユーザIDラベル_テキストボックス.png',
                                fit: BoxFit.fill,
                              )
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(80, 16, 80, 0),
                            child: CupertinoTextField(
                              padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                // borderRadius: BorderRadius.circular(12),
                              ),
                            ),)
                        ]
                      ),
                      // SizedBox(height: 0),
                      CupertinoButton(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(96, 24, 96, 0),
                          child: Positioned.fill(
                              child: Image.asset('assets/images/フレンド登録画面/OKボタン.png',
                                fit: BoxFit.fill,
                              )),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
