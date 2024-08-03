import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spajam_2024_hiyokogumi/services/image_service.dart';

/// 画像をアップロードして表示するサンプルページ
class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final ImageService _imageService = ImageService.instance;
  String? _imageUrl;
  String? _filePath;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('imageUpload'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('filePath: $_filePath'),
            Text('imageUrl: $_imageUrl'),
            if (_filePath != null)
              SizedBox(
                  width: 400, height: 400, child: Image.network(_imageUrl!)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () async {
                    final File? file =
                        await _imageService.pickImageFrom(ImageSource.camera);
                    if (file == null) {
                      print('no image selected');
                      return;
                    }
                    final uploadResult = await _imageService.uploadImage(
                        prefix: 'sample', imageFile: file);
                    if (uploadResult == null) {
                      print('upload failed');
                      return;
                    }
                    setState(() {
                      _filePath = uploadResult.filePath;
                      _imageUrl = uploadResult.downloadURL;
                    });
                    print('uploaded: $_imageUrl');
                  },
                  child: const Text('upload from camera'),
                ),
                // delete
                CupertinoButton(
                  onPressed: () async {
                    if (_filePath == null) {
                      return;
                    }
                    await _imageService.deleteImage(_filePath!);
                    setState(() {
                      _filePath = null;
                      _imageUrl = null;
                    });
                  },
                  child: const Text('delete image'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
