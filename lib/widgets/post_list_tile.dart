import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/screens/detail_screen.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({required this.analytics, required this.post, Key? key})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Post list tile',
      button: false,
      onTapHint: 'Tap to view post details',
      child: GestureDetector(
        onTap: () {
          analytics.logEvent(name: 'post_tap', parameters: {
            'post_id': post.id,
          });
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
