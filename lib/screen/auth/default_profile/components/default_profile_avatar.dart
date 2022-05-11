import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tapea/util/util.dart';

class DefaultProfileAvatar extends StatelessWidget {
  final ImageProvider<Object> selectedImage;
  final Function(Uint8List? img) onImagePick;
  const DefaultProfileAvatar({
    Key? key,
    required this.selectedImage,
    required this.onImagePick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: selectedImage,
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: () async => selectImage(),
                  icon: const Icon(Icons.add_a_photo),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void selectImage() async {
    final Uint8List? data = await pickImage();
    onImagePick(data);
  }
}
