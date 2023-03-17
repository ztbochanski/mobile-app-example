import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/models/post.dart';

/// A model for a list of posts. This class builds a list of posts using the post model.
class PostsList {
  List<Post> posts;

  PostsList(this.posts);

  factory PostsList.fromFirestore(QuerySnapshot snapshot) {
    List<Post> posts =
        snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();
    return PostsList(posts);
  }

  bool isEmpty() => posts.isEmpty;

  int length() => posts.length;

  void descendingSort() {
    posts.sort((a, b) => b.date.compareTo(a.date));
  }

  int totalQuantity() {
    int total = 0;
    for (var post in posts) {
      total += post.quantity;
    }
    return total;
  }
}
