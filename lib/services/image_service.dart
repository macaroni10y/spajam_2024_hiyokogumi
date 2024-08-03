import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/image_metadata.dart';
import '../repositories/image_metadata_repository.dart';

/// firebase storageによる画像の操作を提供する
class ImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final ImageMetadataRepository _imageMetadataRepository =
      ImageMetadataRepository.instance;

  ImageService._();
  static final ImageService _instance = ImageService._();
  static ImageService get instance => _instance;

  Future<File?> pickImageFrom(ImageSource imageSource) async {
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<ImageMetadata?> uploadImage(
      {String prefix = 'upload', required File imageFile}) async {
    try {
      final filePath = '$prefix/${imageFile.path.split('/').last}';
      TaskSnapshot snapshot = await _storage.ref(filePath).putFile(imageFile);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return await _imageMetadataRepository
          .addImageMetadata(ImageMetadata.create(filePath, downloadURL));
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<void> deleteImage(ImageMetadata imageMetadata) async {
    try {
      await _storage.ref(imageMetadata.filePath).delete();
      await _imageMetadataRepository.deleteImageMetadata(imageMetadata.id);
      print('File deleted successfully');
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
}
