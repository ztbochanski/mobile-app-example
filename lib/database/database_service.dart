import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:wasteagram/models/post.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Post>> posts() {
    return _db.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Post.fromDocumentSnapshot(doc))
          .toList();
    });
  }
}
