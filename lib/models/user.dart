/// サンプル用のユーザーモデル
/// jsonと相互変換のためにtoMap, fromMapを用意するフシがある
class User {
  final String id;
  final String name;
  final int age;

  User({required this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() => {
        'name': name,
        'age': age,
      };

  factory User.fromMap(Map<String, dynamic> data, String id) => User(
        id: id,
        name: data['name'] ?? '',
        age: data['age'] ?? 0,
      );

  /// 未登録のユーザーを作成するため、idを指定せずに生成されることが期待される
  factory User.create(String name, int age) => User(
        id: '',
        name: name,
        age: age,
      );
}
