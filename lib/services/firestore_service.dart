import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:wasteagram/services/location_service.dart';
import 'package:wasteagram/models/post.dart';

class Fires {
  final String collectionName = 'posts';

  // Singleton pattern
  static late Fires _instance;

  Fires._() {
    _instance = this;
  }

  factory Fires.getInstance() {
    return _instance;
  }

  static Future<void> initialize() async {
    _instance = Fires._();
  }

  // CRUD methods
  Future<void> addMetadata(Post post) async {
    LocationData? loc = await LocationService.getLocation();
    post.latitude = loc!.latitude as double;
    post.longitude = loc.longitude as double;
    post.date = DateTime.now();
  }

  Future<void> addPost(Post post) async {
    await addMetadata(post);
    await FirebaseFirestore.instance
        .collection(collectionName)
        .add(post.toMap());
  }

  Stream<List<Post>> posts() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Post.fromDocumentSnapshot(doc))
          .toList();
    });
  }
}
