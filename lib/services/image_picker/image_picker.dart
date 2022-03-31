import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickImage {

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<File?> chooseImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
      maxWidth: 1500,
      maxHeight: 1500);
    if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
      return _image;
  }
}