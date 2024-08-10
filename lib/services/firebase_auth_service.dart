import 'package:firebase_auth/firebase_auth.dart';

/// firebaseのdisplayNameを更新する
/// これをユーザに見えたり、ユーザが登録したりするユーザIDとして使用する
Future<void> updateDisplayName(String displayName) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      await user.updateDisplayName(displayName);
      await user.reload();
      user = FirebaseAuth.instance.currentUser;
      print("DisplayName updated: ${user!.displayName}");
    } catch (e) {
      print("Failed to update displayName: $e");
    }
  }
}

/// firebaseのdisplayNameを取得する
String? getDisplayName() {
  User? user = FirebaseAuth.instance.currentUser;
  return user?.displayName;
}
