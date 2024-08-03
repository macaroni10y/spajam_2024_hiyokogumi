import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spajam_2024_hiyokogumi/repositories/image_metadata_repository.dart';
import 'package:spajam_2024_hiyokogumi/services/image_service.dart';

import '../models/image_metadata.dart';
import 'image_detail_page.dart';

/// 画像をアップロードして表示するサンプルページ
class ImagePage extends StatelessWidget {
  ImagePage({super.key});

  final ImageService _imageService = ImageService.instance;
  final ImageMetadataRepository _imageMetadataRepository =
      ImageMetadataRepository.instance;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('imageUpload'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<List<ImageMetadata>>(
                stream: _imageMetadataRepository.listenToImageMetadata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<ImageMetadata> imageMetadataList =
                        snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: imageMetadataList.length,
                        itemBuilder: (context, index) {
                          final ImageMetadata imageMetadata =
                              imageMetadataList[index];
                          return CupertinoListTile(
                            title: Text('id: ${imageMetadata.id}'),
                            leading: Image.network(imageMetadata.downloadURL),
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => ImageDetailPage(
                                    imageMetadata: imageMetadata,
                                  ),
                                ),
                              );
                            },
                            trailing: CupertinoButton(
                              child: const Text('delete'),
                              onPressed: () {
                                _imageService.deleteImage(imageMetadata);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
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
                    },
                    child: const Text('upload from camera'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
