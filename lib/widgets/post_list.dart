import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy');

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data!.docs[index];
                  return ListTile(
                      title: Text(dateFormat.format(post['date'].toDate())),
                      subtitle: Text(post['quantity'].toString()));
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('Error $snapshot.error'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
