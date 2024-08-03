import '../models/image_metadata.dart';
import '../services/firestore_service.dart';

/// リポジトリのサンプル
/// ImageMetadataモデル単位でのCRUDを提供する
/// firestoreのAPIを直接利用するとMap型でデータをやり取りする必要があるが、このようにリポジトリを挟むことでモデル単位で操作できる
class ImageMetadataRepository {
  final FirestoreService _firestoreService = FirestoreService.instance;
  static const String collectionName = 'images';

  ImageMetadataRepository._();
  static final ImageMetadataRepository _instance = ImageMetadataRepository._();
  static ImageMetadataRepository get instance => _instance;

  Future<ImageMetadata> addImageMetadata(ImageMetadata imageMetadata) async {
    final documentReference =
        await _firestoreService.addItem(collectionName, imageMetadata.toMap());
    return ImageMetadata.fromMap(imageMetadata.toMap(), documentReference.id);
  }

  Future<void> updateImageMetadata(ImageMetadata imageMetadata) async {
    await _firestoreService.updateItem(
        collectionName, imageMetadata.id, imageMetadata.toMap());
  }

  Future<void> deleteImageMetadata(String id) async {
    await _firestoreService.deleteItem(collectionName, id);
  }

  Stream<List<ImageMetadata>> listenToImageMetadata() {
    return _firestoreService.listenToCollection(
        collectionName, ImageMetadata.fromMap);
  }

  Future<ImageMetadata?> getImageMetadata(String id) async {
    return await _firestoreService.getItem(
        collectionName, id, ImageMetadata.fromMap);
  }
}
