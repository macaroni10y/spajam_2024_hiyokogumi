import 'package:flutter/cupertino.dart';

import '../models/image_metadata.dart';
import '../services/image_service.dart';

class ImageDetailPage extends StatelessWidget {
  final ImageMetadata imageMetadata;
  final ImageService _imageService = ImageService.instance;

  ImageDetailPage({super.key, required this.imageMetadata});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('imageDetail'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.network(imageMetadata.downloadURL,
                  width: 400.0, height: 400.0),
              Text('id: ${imageMetadata.id}'),
              CupertinoButton(
                  child: const Text('delete'),
                  onPressed: () {
                    _imageService.deleteImage(imageMetadata);
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
