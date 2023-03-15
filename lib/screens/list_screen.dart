import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:wasteagram/widgets/app_scaffold.dart';
import 'package:wasteagram/widgets/post_list.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Posts',
      floatingActionButton: NewEntryButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      child: PostList(),
    );
  }
}

class NewEntryButton extends StatelessWidget {
  const NewEntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('posts')
              .add({'date': 'Fake Date', 'quantity': 3});
        });
  }
}
