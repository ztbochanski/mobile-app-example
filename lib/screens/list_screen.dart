import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/services/firestore_service.dart';
import 'package:wasteagram/models/posts_list.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
                title: Text('Posts - $totalQuantity wasted items'),
              ),
              body: ListView.builder(
                itemCount: postsList.length(),
                itemBuilder: (context, index) {
                  postsList.descendingSort();
                  var post = postsList.posts[index];
                  return ListTile(
                      title: Text(post.formattedDate.toString()),
                      subtitle: Text(post.quantity.toString()));
                },
              ),
              floatingActionButton: const NewPostButton(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat);
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Posts'),
              ),
              body: const Center(child: Text('An error occurred')));
        } else {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Posts'),
              ),
              body: const Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

class NewPostButton extends StatelessWidget {
  const NewPostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () {
          print('New post button pressed');
        });
  }
}
