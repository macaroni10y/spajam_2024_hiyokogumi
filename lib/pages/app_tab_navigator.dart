import 'package:flutter/cupertino.dart';
import 'package:spajam_2024_hiyokogumi/pages/image_page.dart';
import 'package:spajam_2024_hiyokogumi/pages/login_user_info.page.dart';
import 'package:spajam_2024_hiyokogumi/pages/user_list_page.dart';

/// 複数ページを切り替えられる下部タブを司る親ウィジェット
class AppTabNavigator extends StatelessWidget {
  const AppTabNavigator({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'userInfo',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'userList',
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.photo), label: 'imageUpload'),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return switch (index) {
              0 => const LoginUserInfoPage(),
              1 => const UserListPage(),
              _ => const ImagePage(),
            };
          },
        );
      },
    );
  }
}
