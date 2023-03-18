import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';

/// A model for a list of posts. This class builds a list of posts using the post model.
class PostsList {
  List<Post> posts;

  PostsList(this.posts);

  /// A factory method for creating a `PostList` of `Posts` from a Firestore query snapshot.
  factory PostsList.fromFirestore(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<Post> posts =
        snapshot.data!.docs.map((doc) => Post.fromFirestore(doc)).toList();
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
