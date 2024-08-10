import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: IconButton(onPressed: null, icon: Icon(Icons.arrow_back)),
        middle: Text('フレンド一覧'),
        trailing: IconButton(onPressed: null, icon: Icon(Icons.add)),
      ),
      child: ListView(
          children: [
            _menuItem("xxxxxxxx", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
            _menuItem("yyyyyyyy", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
            _menuItem("zzzzzzzz", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
            _menuItem("aaaaaaaa", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
            _menuItem("cccccccc", Image(image:  AssetImage("assets/images/placeholder_usagi.png"))),
          ]
      ),
    );
  }

  Widget _menuItem(String userName, Image image) {
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
                'UserName: ' + userName,
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