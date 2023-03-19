import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/screens/detail_screen.dart';

class PostListTile extends StatelessWidget {
  final Post post;

  const PostListTile({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Post list tile',
      button: false,
      onTapHint: 'Tap to view post details',
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetailScreen(post: post);
          }));
        },
        child: ListTile(
          title: Text(post.formattedDate.toString()),
          subtitle: Text(post.quantity.toString()),
        ),
      ),
    );
  }
}
