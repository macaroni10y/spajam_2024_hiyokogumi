import 'package:flutter/material.dart';
import 'package:spajam_2024_hiyokogumi/pages/friend_search_page.dart';

import '../models/friendship.dart';
import '../repositories/friendship_repository.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final friendshipRepository = FriendshipRepository.instance;
    return Scaffold(
      appBar: AppBar(
          leading: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: Text('フレンド一覧'),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FriendSearchPage(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ]),
      body: FutureBuilder<List<Friendship>>(
        future: friendshipRepository
            .getFriendsMock('TODO 自分のユーザIDを入れる。ただ、モックで返せてるのでこれでもイイ'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('エラーが発生しました'));
          }
          final List<Friendship>? friendships = snapshot.data;
          if (friendships!.isEmpty) {
            return const Center(child: Text('フレンドがいません'));
          }
          return ListView.builder(
            itemCount: friendships.length,
            itemBuilder: (context, index) {
              final friendship = friendships[index];
              final userName = friendship.friendId;
              final image = Image.asset('assets/images/placeholder_usagi.png');
              return _menuItem(userName, image, friendship.isCrossing);
            },
          );
        },
      ),
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
