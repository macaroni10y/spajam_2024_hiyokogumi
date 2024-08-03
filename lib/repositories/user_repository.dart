import '../models/user.dart';
import '../services/firestore_service.dart';

/// リポジトリのサンプル
/// Userモデル単位でのCRUDを提供する
/// firestoreのAPIを直接利用するとMap型でデータをやり取りする必要があるが、このようにリポジトリを挟むことでモデル単位で操作できる
class UserRepository {
  final FirestoreService _firestoreService = FirestoreService.instance;
  static const String collectionName = 'users';

  /// implement as singleton
  UserRepository._();
  static final UserRepository _instance = UserRepository._();
  static UserRepository get instance => _instance;

  Future<void> addUser(User user) async {
    await _firestoreService.addItem(collectionName, user.toMap());
  }

  Future<void> updateUser(User user) async {
    await _firestoreService.updateItem(collectionName, user.id, user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await _firestoreService.deleteItem(collectionName, id);
  }

  Stream<List<User>> listenToUsers() {
    return _firestoreService.listenToCollection(collectionName, User.fromMap);
  }

  Future<User?> getUser(String id) async {
    return await _firestoreService.getItem(collectionName, id, User.fromMap);
  }
}
