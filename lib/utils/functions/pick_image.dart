 import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage(ValueNotifier<String> imageNotifier) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageNotifier.value = pickedFile.path;
    }
  }