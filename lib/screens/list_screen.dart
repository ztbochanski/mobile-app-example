import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/services/firestore_service.dart';
import 'package:wasteagram/models/posts_list.dart';
import 'package:wasteagram/widgets/new_post_fab.dart';
import 'package:wasteagram/widgets/post_list_tile.dart';
import 'package:wasteagram/widgets/title_text.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({required this.analytics, required this.observer, Key? key})
      : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  static const routeName = '/';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final String screenTitle = 'Posts';
  final FirestoreService _firestoreService = FirestoreService.getInstance();

  Stream<QuerySnapshot> _getPostsStream() {
    return _firestoreService.postsStream();
  }

  PostsList _postsListToModel(AsyncSnapshot<QuerySnapshot> snapshot) {
    return PostsList.fromFirestore(snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _getPostsStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          PostsList postsList = _postsListToModel(snapshot);

          int totalQuantity = postsList.totalQuantity();

          return Scaffold(
              appBar: AppBar(
                  title:
                      TitleText(title: screenTitle, quantity: totalQuantity)),
              body: ListView.builder(
                itemCount: postsList.length(),
                itemBuilder: (context, index) {
                  postsList.descendingSort();
                  var post = postsList.posts[index];
                  return PostListTile(analytics: widget.analytics, post: post);
                },
              ),
              floatingActionButton: NewPostFAB(analytics: widget.analytics),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat);
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(title: TitleText(title: screenTitle, quantity: 0)),
              body: const Center(child: Text('An error occurred')));
        } else {
          return Scaffold(
              appBar: AppBar(title: TitleText(title: screenTitle, quantity: 0)),
              body: const Center(child: CircularProgressIndicator()),
              floatingActionButton: NewPostFAB(analytics: widget.analytics),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat);
        }
      },
    );
  }
}
