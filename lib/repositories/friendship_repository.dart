import '../models/friendship.dart';
import '../services/firestore_service.dart';

class FriendshipRepository {
  final FirestoreService _firestoreService = FirestoreService.instance;
  static const String collectionName = 'friends';

  FriendshipRepository._();
  static final FriendshipRepository _instance = FriendshipRepository._();
  static FriendshipRepository get instance => _instance;

  /// 2ユーザがフレンドである事実を作成する
  /// 2つのFriendshipオブジェクトを作成することで、双方向のフレンドシップを表現する
  /// isCrossingがtrueの場合、すれ違いによる登録をさす
  Future<void> createFriendship(
      String userId1, String userId2, bool isCrossing) async {
    final friendship = Friendship.create(userId1, userId2, isCrossing);
    await _firestoreService.addItem(collectionName, friendship.toMap());
    final friendship2 = Friendship.create(userId1, userId2, isCrossing);
    await _firestoreService.addItem(collectionName, friendship2.toMap());
  }

  /// 自分がフレンドであるユーザを取得する
  Future<List<Friendship>> getFriends(String userId) async {
    final query = await _firestoreService.getAllItems(
      collectionName,
      Friendship.fromMap,
    );
    return query.where((friendship) => friendship.userId == userId).toList();
  }

  /// 自分がフレンドであるユーザを取得する テスト用のモック
  Future<List<Friendship>> getFriendsMock(String userId) async {
    return [
      Friendship.create(userId, 'user2', false),
      Friendship.create(userId, 'user3', true),
      Friendship.create(userId, 'user4', false),
    ];
  }
}
