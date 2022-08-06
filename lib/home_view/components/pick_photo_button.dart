import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:img2ascii_app/convert_image_view/convert_image_view.dart';

class PickPhotoButton extends StatelessWidget {
  const PickPhotoButton(
      {required this.picker,
      required this.source,
      this.text = "Photo",
      super.key});

  final String text;
  final ImagePicker picker;
  final ImageSource source;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(4),
        constraints: const BoxConstraints.tightFor(height: 150, width: 150),
        child: ElevatedButton(
          onPressed: () async {
            pickImage(source).then(
              (file) {
                if (file != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ConvertImageView(file)),
                  );
                }
              },
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                source == ImageSource.camera
                    ? Icons.camera_alt_rounded
                    : Icons.add_photo_alternate_rounded,
                size: 80,
              ),
              Text(text, textAlign: TextAlign.center),
            ],
          ),
        ));
  }

  Future<File?> pickImage(ImageSource source) async {
    final XFile? file = await picker.pickImage(source: source);

    if (file != null) {
      return File(file.path);
    }
    return null;
  }
}