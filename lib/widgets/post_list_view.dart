import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/services/firestore_service.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/models/posts_list.dart';

class PostListView extends StatefulWidget {
  const PostListView({Key? key}) : super(key: key);

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  final FirestoreService _firestoreService = FirestoreService.getInstance();

  Stream<QuerySnapshot> _getPostsStream() {
    return _firestoreService.postsStream();
  }

  PostsList _postsListToModel(QuerySnapshot snapshot) {
    return PostsList.fromFirestore(snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _getPostsStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          PostsList postsList = _postsListToModel(snapshot.data!);
          return ListView.builder(
            itemCount: postsList.length(),
            itemBuilder: (context, index) {
              var post = postsList.posts[index];
              return ListTile(
                  title: Text(post.formattedDate.toString()),
                  subtitle: Text(post.quantity.toString()));
            },
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
