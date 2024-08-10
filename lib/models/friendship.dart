/// 2ユーザがフレンドである事実を表すモデル
class Friendship {
  final String id;
  final String userId;
  final String friendId;
  final bool isCrossing;

  Friendship(
      {required this.id,
      required this.userId,
      required this.friendId,
      required this.isCrossing});

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'friendId': friendId,
        'isCrossing': isCrossing,
      };

  factory Friendship.fromMap(Map<String, dynamic> json, String id) {
    return Friendship(
      id: id,
      userId: json['userId'],
      friendId: json['friendId'],
      isCrossing: json['isCrossing'],
    );
  }

  /// 未登録のフレンドシップを作成するため、idを指定せずに生成されることが期待される
  factory Friendship.create(String userId, String friendId, bool isCrossing) =>
      Friendship(
        id: '',
        userId: userId,
        friendId: friendId,
        isCrossing: isCrossing,
      );
}
