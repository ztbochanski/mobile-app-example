import 'dart:io';
import 'package:image_picker/image_picker.dart';

/// Singleton class for picking images from the gallery
class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  static late ImagePickerService _instance;

  /// Singleton constructor for [ImagePickerService]
  ImagePickerService._() {
    _instance = this;
  }

  factory ImagePickerService.getInstance() {
    return _instance;
  }

  static Future<void> initialize() async {
    _instance = ImagePickerService._();
  }

  /// returns a [File] object from the image picked from the gallery
  Future pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
  }
}
