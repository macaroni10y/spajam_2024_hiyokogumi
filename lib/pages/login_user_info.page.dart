import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// firebaseの匿名ログインを行い、ログイン情報を表示するだけのサンプルページ
class LoginUserInfoPage extends StatelessWidget {
  const LoginUserInfoPage({super.key});

  Future<UserCredential> signedInAtFuture() async {
    final user = await FirebaseAuth.instance.signInAnonymously();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('userInfo'),
      ),
      child: FutureBuilder<UserCredential>(
        future: signedInAtFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildUserInfo(snapshot.data);
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }

  Center _buildUserInfo(UserCredential? userCredential) {
    return Center(
        child: Container(
            height: 150,
            width: 300,
            color: CupertinoColors.systemBlue,
            // render info as table
            child: Table(
              children: [
                TableRow(children: [
                  const Text("anonymousUserId: "),
                  Text(userCredential!.user!.uid),
                ]),
                TableRow(children: [
                  const Text("signedInAt: "),
                  Text(userCredential.user!.metadata.creationTime.toString()),
                ]),
                TableRow(children: [
                  const Text("now: "),
                  Text(DateTime.now().toIso8601String()),
                ]),
              ],
            )));
  }
}
