import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spajam_2024_hiyokogumi/pages/friend_search_page.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            // padding: EdgeInsets.zero, // アイコンボタンのパディングを調整
            onPressed: () {
              Navigator.pop(context); // 戻るボタンの動作を追加
            },
            child: const Icon(CupertinoIcons.back),
          ),
          middle: Text('フレンド一覧'),
          trailing: CupertinoButton(
            child: const Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(
                builder: (context) {
                  return FriendSearchPage();
                },
              ));
            },
          )),
      child: ListView(children: [
        _menuItem(
            "xxxxxxxx",
            Image(image: AssetImage("assets/images/placeholder_usagi.png")),
            false),
        _menuItem(
            "yyyyyyyy",
            Image(image: AssetImage("assets/images/placeholder_usagi.png")),
            true),
        _menuItem(
            "zzzzzzzz",
            Image(image: AssetImage("assets/images/placeholder_usagi.png")),
            false),
        _menuItem(
            "aaaaaaaa",
            Image(image: AssetImage("assets/images/placeholder_usagi.png")),
            false),
        _menuItem(
            "cccccccc",
            Image(image: AssetImage("assets/images/placeholder_usagi.png")),
            false),
      ]),
    );
  }

  Widget _menuItem(String userName, Image image, bool isCrossing) {
    final containerColor = isCrossing ? Colors.lightBlue : Colors.white;
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey)),
            color: containerColor,
          ),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: image,
                height: 40,
                width: 40,
              ),
              Text(
                'UserName: ' + userName,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ],
          )),
      onTap: () {
        print("onTap called.");
      },
    );
  }
}
