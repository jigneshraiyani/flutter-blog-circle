import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<File?> pickImage() async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
