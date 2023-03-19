import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static late StorageService _instance;

  StorageService._() {
    _instance = this;
  }

  factory StorageService.getInstance() {
    return _instance;
  }

  static Future<void> initialize() async {
    _instance = StorageService._();
  }

  Future<String> uploadImage(File image) async {
    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask;
    var url = await storageReference.getDownloadURL();
    return url;
  }

  Future<void> deleteImage(String url) async {
    Reference storageReference = FirebaseStorage.instance.refFromURL(url);
    await storageReference.delete();
  }
}
