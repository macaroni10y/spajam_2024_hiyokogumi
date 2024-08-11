import 'package:flutter/material.dart';

import '../repositories/friendship_repository.dart';
import 'friend_search_page.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final friendshipRepository = FriendshipRepository.instance;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/フレンド一覧/bk.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Stack(children: [
              const Image(image: AssetImage('assets/images/フレンド一覧/hed.png')),
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
              Positioned(
                right: 20,
                top: 5,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FriendSearchPage();
                    }));
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
                child: ListView(
              children: const [
                Padding(
                  padding:
                      EdgeInsets.only(left: 32, right: 32, bottom: 16, top: 16),
                  child: Image(
                      image: AssetImage('assets/images/フレンド一覧/icon_01.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  child: Image(
                      image: AssetImage('assets/images/フレンド一覧/icon_02.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  child: Image(
                      image: AssetImage('assets/images/フレンド一覧/icon_03.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  child: Image(
                      image: AssetImage('assets/images/フレンド一覧/icon_04.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  child: Image(
                      image: AssetImage('assets/images/フレンド一覧/icon_05.png')),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

// ListView(
//         children: [
//           Image(image: AssetImage('assets/images/フレンド一覧/icon_01.png')),
//         ],
//       )
