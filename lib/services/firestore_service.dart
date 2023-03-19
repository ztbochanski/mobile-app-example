import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:wasteagram/services/location_service.dart';
import 'package:wasteagram/models/post.dart';

class FirestoreService {
  final String collectionName = 'posts';

  // Singleton pattern
  static late FirestoreService _instance;

  FirestoreService._() {
    _instance = this;
  }

  factory FirestoreService.getInstance() {
    return _instance;
  }

  static Future<void> initialize() async {
    _instance = FirestoreService._();
  }

  Stream<QuerySnapshot> postsStream() {
    return FirebaseFirestore.instance.collection('posts').snapshots();
  }

  Future<void> addMetadata(Post post) async {
    LocationData? loc = await LocationService.getLocation();
    post.latitude = loc!.latitude as double;
    post.longitude = loc.longitude as double;
    post.date = DateTime.now();
  }

  Future<void> uploadPost(Post post) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(post.id)
        .set(post.toMap());
  }
}
