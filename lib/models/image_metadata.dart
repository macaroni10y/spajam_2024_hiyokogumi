/// サンプル用の画像モデル
/// jsonと相互変換のためにtoMap, fromMapを用意するフシがある
class ImageMetadata {
  final String id;
  final String filePath;
  final String downloadURL;

  ImageMetadata(
      {required this.id, required this.filePath, required this.downloadURL});

  Map<String, dynamic> toMap() => {
        'filePath': filePath,
        'downloadURL': downloadURL,
      };

  factory ImageMetadata.fromMap(Map<String, dynamic> data, String id) =>
      ImageMetadata(
        id: id,
        filePath: data['filePath'] ?? '',
        downloadURL: data['downloadURL'] ?? '',
      );

  /// 未登録の画像を作成するため、idを指定せずに生成されることが期待される
  factory ImageMetadata.create(String filePath, String downloadURL) =>
      ImageMetadata(
        id: '',
        filePath: filePath,
        downloadURL: downloadURL,
      );
}
