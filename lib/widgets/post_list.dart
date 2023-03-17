import 'package:flutter/material.dart';

import 'package:wasteagram/database/database_service.dart';
import 'package:wasteagram/models/post.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final DatabaseService _databaseService = DatabaseService();

  Stream<List<Post>>? _posts;

  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  void _getPosts() {
    _posts = _databaseService.posts();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _posts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var post = snapshot.data![index];
                return ListTile(
                    title: Text(post.date), subtitle: Text(post.quantity));
              });
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
