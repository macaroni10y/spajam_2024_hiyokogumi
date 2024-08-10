import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('フレンド一覧'),
      ),
      child: ListView(
          children: [
            _menuItem("メニュー1", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
            _menuItem("メニュー2", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
            _menuItem("メニュー3", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
            _menuItem("メニュー4", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
            _menuItem("メニュー5", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
          ]
      ),
    );
  }

  Widget _menuItem(String title, Image image) {
    return GestureDetector(
      child:Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
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
                title,
                style: TextStyle(
                    color:Colors.black,
                    fontSize: 18.0
                ),
              ),
            ],
          )
      ),
      onTap: () {
        print("onTap called.");
      },
    );
  }
}